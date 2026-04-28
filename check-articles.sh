#!/bin/bash

# ExpatGuide Article Quality Check Script v1.5
# 用法: 在项目根目录运行 bash check-articles.sh
# 可选: bash check-articles.sh path/to/specific-file.md (只检查单篇)
# 可选: bash check-articles.sh --who-links /vietnam/xxx/slug-name (查引用)
#
# v1.5 更新:
#   - 新增反引号路径格式检测 (Pattern G4): 拦截 `/vietnam/...` 写法
#   - 新增 frontmatter 字段白名单检测 (Pattern F1): 拦截 slug/lastUpdated 等禁止字段
#   - 新增 frontmatter description 长度检测 (120-160 区间, WARN 级)
#   - 新增 Affiliate URL 模板检测 (Pattern G1):
#     * SafetyWing 必须用 referenceID=26505542 模板
#     * Wise 必须用 invite/dic/ganqiuh 模板
#     * World Nomads 占位符检测 (待 CJ URL 启用)
#   - 第一人称地名白名单扩充: 新增 My Tho / My Son / My Dinh / Phu My Bridge
#
# v1.4 更新: OpenAI 内部引用标记检测 (ERROR)
# v1.3 更新: 禁用词分硬禁用(ERROR) + 语境敏感(WARN) 两级

DOCS_DIR="src/content/docs"
CURRENT_YEAR="2026"
ERRORS=0
WARNINGS=0

RED='\033[0;31m'
YELLOW='\033[1;33m'
GREEN='\033[0;32m'
CYAN='\033[0;36m'
NC='\033[0m'

# Affiliate URL 模板常量 (集中管理,便于以后更新)
SW_AFFILIATE_MARKER="referenceID=26505542"
WISE_AFFILIATE_MARKER="invite/dic/ganqiuh"
WN_AFFILIATE_MARKER=""  # 待 CJ URL 启用后填入

divider() {
  echo ""
  echo -e "${CYAN}════════════════════════════════════════════════════════════════${NC}"
  echo -e "${CYAN}  $1${NC}"
  echo -e "${CYAN}════════════════════════════════════════════════════════════════${NC}"
}

error() {
  echo -e "  ${RED}✗ ERROR${NC}  $1"
  ((ERRORS++))
}

warn() {
  echo -e "  ${YELLOW}⚠ WARN ${NC}  $1"
  ((WARNINGS++))
}

ok() {
  echo -e "  ${GREEN}✓ OK   ${NC}  $1"
}

# --who-links 模式
if [ "$1" == "--who-links" ] && [ -n "$2" ]; then
  echo ""
  echo -e "${CYAN}查询: 谁引用了 $2${NC}"
  echo ""
  results=$(grep -rn "$2" $DOCS_DIR --include="*.md" --include="*.mdx" 2>/dev/null)
  if [ -n "$results" ]; then
    while IFS= read -r r; do
      echo -e "  ${CYAN}$(echo "$r" | cut -d: -f1)${NC} (line $(echo "$r" | cut -d: -f2))"
    done <<< "$results"
  else
    echo "  没有文件引用此路径"
  fi
  echo ""
  exit 0
fi

# 确定要检查的文件
if [ -n "$1" ]; then
  FILES="$1"
else
  FILES=$(find "$DOCS_DIR" -name "*.md" -o -name "*.mdx" | grep -v "example.md" | sort)
fi

if [ ! -d "$DOCS_DIR" ]; then
  echo -e "${RED}错误: 找不到 $DOCS_DIR 目录。请在项目根目录运行此脚本。${NC}"
  exit 1
fi

# ============================================================
# 1. 断链检测
# ============================================================
divider "1. 断链检测 (Broken Internal Links)"

LINK_BEFORE=$ERRORS
for file in $FILES; do
  links=$(grep -oE '\]\(/[^)]+\)' "$file" | sed 's/\](//' | sed 's/)//' | grep -v '^/http' | grep -v '#')
  
  if [ -n "$links" ]; then
    while IFS= read -r link; do
      clean_link=$(echo "$link" | sed 's:/$::')
      target_file="${DOCS_DIR}${clean_link}.md"
      target_file_mdx="${DOCS_DIR}${clean_link}.mdx"
      target_index="${DOCS_DIR}${clean_link}/index.md"
      target_index_mdx="${DOCS_DIR}${clean_link}/index.mdx"
      
      if [ ! -f "$target_file" ] && [ ! -f "$target_file_mdx" ] && [ ! -f "$target_index" ] && [ ! -f "$target_index_mdx" ]; then
        error "$file → 断链: $link"
      fi
    done <<< "$links"
  fi
done

if [ $ERRORS -eq $LINK_BEFORE ]; then
  ok "没有发现断链"
fi

# ============================================================
# 2. OpenAI 内部引用标记检测
# ============================================================
divider "2. OpenAI 引用标记检测 (Citation Markers)"

MARKER_BEFORE=$ERRORS
for file in $FILES; do
  markers=$(grep -nE "(:contentReference|oaicite|\{index=)" "$file" 2>/dev/null)
  
  if [ -n "$markers" ]; then
    while IFS= read -r match; do
      line_num=$(echo "$match" | cut -d: -f1)
      line_text=$(echo "$match" | cut -d: -f2- | cut -c1-120)
      error "$file:$line_num → OpenAI 引用标记泄漏: $line_text"
    done <<< "$markers"
  fi
done

if [ $ERRORS -eq $MARKER_BEFORE ]; then
  ok "没有发现 OpenAI 内部引用标记"
fi

# ============================================================
# 3. 反引号路径格式检测 (v1.5 新增 - Pattern G4)
# ============================================================
divider "3. 反引号路径格式检测 (Backtick Internal Path)"

BT_BEFORE=$ERRORS
for file in $FILES; do
  # 匹配反引号包裹的 /vietnam/ 开头路径
  # 例: `/vietnam/visa/visa-guide-2026`
  bt_paths=$(grep -nE '`/vietnam/[a-z0-9-]+/[a-z0-9-]+`' "$file" 2>/dev/null)
  
  if [ -n "$bt_paths" ]; then
    while IFS= read -r match; do
      line_num=$(echo "$match" | cut -d: -f1)
      line_text=$(echo "$match" | cut -d: -f2- | cut -c1-150)
      error "$file:$line_num → 内链使用反引号格式 (应改为 markdown link [text](path)): $line_text"
    done <<< "$bt_paths"
  fi
  
  # 同时检测裸路径 (无反引号也无 markdown link 包裹)
  # 例: see /vietnam/visa/visa-guide-2026 directly
  # 这部分用 WARN 级,因为可能误伤(比如 frontmatter 里的描述性提及)
  # 排除 markdown link 内的路径 + 反引号内的路径
  bare_paths=$(grep -nE '(^|[[:space:]])/vietnam/[a-z0-9-]+/[a-z0-9-]+([[:space:]]|$|\.|,)' "$file" 2>/dev/null | \
    grep -vE '\]\(/vietnam/' | \
    grep -vE '`/vietnam/')
  
  if [ -n "$bare_paths" ]; then
    while IFS= read -r match; do
      line_num=$(echo "$match" | cut -d: -f1)
      line_text=$(echo "$match" | cut -d: -f2- | cut -c1-150)
      # 排除 frontmatter 区块 (前 10 行的 description/title 等)
      if [ "$line_num" -le 10 ]; then
        continue
      fi
      warn "$file:$line_num → 裸路径未包裹 (建议用 markdown link): $line_text"
    done <<< "$bare_paths"
  fi
done

if [ $ERRORS -eq $BT_BEFORE ]; then
  ok "没有发现反引号路径格式"
fi

# ============================================================
# 4. Frontmatter 字段白名单检测 (v1.5 新增 - Pattern F1)
# ============================================================
divider "4. Frontmatter 白名单检测 (Forbidden Frontmatter Fields)"

FORBIDDEN_FIELDS=("slug" "country" "city" "category" "tags" "lastUpdated" "date" "publishDate" "author" "draft")

FM_BEFORE=$ERRORS
for file in $FILES; do
  # index.md/mdx 是 hub 页,字段规则可能不同,跳过严格检查
  if [[ "$file" == *"index.md"* ]] || [[ "$file" == *"index.mdx"* ]]; then
    continue
  fi
  
  # 提取 frontmatter 区块 (开头第一个 --- 到第二个 ---)
  fm=$(awk '/^---$/{c++; if(c==2) exit; next} c==1' "$file")
  
  if [ -z "$fm" ]; then
    warn "$file → 未检测到 frontmatter 区块"
    continue
  fi
  
  # 检查禁止字段
  for field in "${FORBIDDEN_FIELDS[@]}"; do
    if echo "$fm" | grep -qE "^${field}:"; then
      error "$file → frontmatter 含禁止字段: $field (白名单仅 title/description/sidebar.label)"
    fi
  done
  
  # description 长度检测 (WARN 级,因为 health-insurance 基准本身是 252 字符 trade-off)
  desc=$(echo "$fm" | grep -m1 "^description:" | sed 's/^description:[[:space:]]*//' | sed 's/^["'"'"']//' | sed 's/["'"'"']$//')
  if [ -n "$desc" ]; then
    desc_len=${#desc}
    if [ "$desc_len" -lt 120 ]; then
      warn "$file → description 长度 $desc_len 字符,过短 (建议 120-160)"
    elif [ "$desc_len" -gt 160 ]; then
      warn "$file → description 长度 $desc_len 字符,过长 (建议 120-160,如有信息密度 trade-off 可保留)"
    fi
  else
    warn "$file → frontmatter 缺 description 字段"
  fi
done

if [ $ERRORS -eq $FM_BEFORE ]; then
  ok "frontmatter 字段合规"
fi

# ============================================================
# 5. 禁用词检测 (硬禁用 + 语境敏感)
# ============================================================
divider "5. 禁用词检测 (Banned Words)"

HARD_BANNED=(
  "vibrant"
  "bustling"
  "hidden gem"
  "melting pot"
  "charming"
  "nestled"
  "epicenter"
  "In conclusion"
  "Let's dive in"
  "It's important to note"
  "straightforward"
  "paradise"
  "tropical haven"
  "delve"
  "tapestry"
  "ever-evolving"
  "seamless"
  "holistic"
  "intricate"
  "multifaceted"
  "underscore"
  "pivotal"
  "foster"
  "empower"
  "streamline"
  "tailored"
  "in today's world"
  "in today's fast-paced environment"
  "whether you are"
  "it is worth noting"
  "plays a key role"
  "serves as a cornerstone"
)

CONTEXT_SENSITIVE=(
  "leverage"
  "navigate"
  "landscape"
  "comprehensive"
  "robust"
  "nuanced"
  "crucial"
)

BANNED_BEFORE=$ERRORS
WARN_BEFORE=$WARNINGS

for file in $FILES; do
  for word in "${HARD_BANNED[@]}"; do
    matches=$(grep -ni "$word" "$file" 2>/dev/null)
    if [ -n "$matches" ]; then
      while IFS= read -r match; do
        line_num=$(echo "$match" | cut -d: -f1)
        error "$file:$line_num → 硬禁用词: \"$word\""
      done <<< "$matches"
    fi
  done
done

for file in $FILES; do
  for word in "${CONTEXT_SENSITIVE[@]}"; do
    matches=$(grep -ni "$word" "$file" 2>/dev/null)
    if [ -n "$matches" ]; then
      while IFS= read -r match; do
        line_num=$(echo "$match" | cut -d: -f1)
        line_text=$(echo "$match" | cut -d: -f2- | cut -c1-100)
        warn "$file:$line_num → 语境敏感词 \"$word\" — 人工判断: $line_text"
      done <<< "$matches"
    fi
  done
done

if [ $ERRORS -eq $BANNED_BEFORE ] && [ $WARNINGS -eq $WARN_BEFORE ]; then
  ok "没有发现禁用词"
elif [ $ERRORS -eq $BANNED_BEFORE ]; then
  ok "没有硬禁用词 (语境敏感词请人工判断)"
fi

# ============================================================
# 6. 标题年份检测
# ============================================================
divider "6. 标题年份检测 (Year in Title)"

YEAR_BEFORE=$ERRORS
for file in $FILES; do
  if [[ "$file" == *"index.md"* ]] || [[ "$file" == *"index.mdx"* ]]; then
    continue
  fi
  
  title=$(grep -m1 "^title:" "$file" | sed 's/^title:[[:space:]]*//' | sed 's/^["'"'"']//' | sed 's/["'"'"']$//')
  
  if [ -n "$title" ]; then
    if ! echo "$title" | grep -q "$CURRENT_YEAR"; then
      error "$file → 标题缺少 $CURRENT_YEAR: \"$title\""
    fi
  else
    warn "$file → 未找到 title 字段"
  fi
done

if [ $ERRORS -eq $YEAR_BEFORE ]; then
  ok "所有文章标题包含 $CURRENT_YEAR"
fi

# ============================================================
# 7. Affiliate 计数 + URL 模板检测 (v1.5 增强 - Pattern G1)
# ============================================================
divider "7. Affiliate 检测 (SafetyWing / Wise / World Nomads)"

AFF_BEFORE=$ERRORS

# 7a. 计数检测 (沿用 v1.4 逻辑)
for file in $FILES; do
  # SafetyWing: 剔除 affiliate URL 内的 safetywing 字样,只数 anchor text + 自然提及
  sw_count=$(sed 's/(https:\/\/safetywing\.com[^)]*)//g' "$file" | grep -oi "safetywing" | wc -l | tr -d ' ')
  
  # Wise: 排除 otherwise / likewise / wisdom 等假阳性
  wise_all=$(grep -oiE '\bwise\b' "$file" | wc -l | tr -d ' ')
  wise_false=$(grep -oiE '\b(otherwise|likewise|wisdom)\b' "$file" | wc -l | tr -d ' ')
  wise_brand=$((wise_all - wise_false))
  if [ $wise_brand -lt 0 ]; then wise_brand=0; fi
  
  wn_count=$(grep -oi "world nomads" "$file" | wc -l | tr -d ' ')
  
  if [ "$sw_count" -gt 1 ]; then
    error "$file → SafetyWing 出现 $sw_count 次 (上限1次)"
  fi
  
  is_wise_topic=false
  if [[ "$file" == *"bank"* ]] || [[ "$file" == *"visa"* ]] || [[ "$file" == *"trc"* ]] || [[ "$file" == *"cost-of-living"* ]]; then
    is_wise_topic=true
  fi
  
  if [ "$is_wise_topic" = false ] && [ "$wise_brand" -gt 1 ]; then
    warn "$file → Wise 品牌提及 $wise_brand 次 (上限1次,请人工确认)"
  fi
  
  if [ "$wn_count" -gt 1 ]; then
    error "$file → World Nomads 出现 $wn_count 次 (上限1次)"
  fi
  
  if [ "$wn_count" -gt 0 ] && [ "$sw_count" -gt 0 ]; then
    same_line=$(sed 's/(https:\/\/safetywing\.com[^)]*)//g' "$file" | grep -i "safetywing" | grep -i "world nomads")
    if [ -n "$same_line" ]; then
      error "$file → World Nomads 和 SafetyWing 出现在同一句"
    fi
  fi
done

# 7b. URL 模板检测 (v1.5 新增)
for file in $FILES; do
  # SafetyWing URL 检测
  # 提取所有 safetywing.com URL
  sw_urls=$(grep -noE 'https://safetywing\.com[^)[:space:]]*' "$file" 2>/dev/null)
  if [ -n "$sw_urls" ]; then
    while IFS= read -r match; do
      line_num=$(echo "$match" | cut -d: -f1)
      url=$(echo "$match" | cut -d: -f2-)
      if ! echo "$url" | grep -q "$SW_AFFILIATE_MARKER"; then
        error "$file:$line_num → SafetyWing 使用普通 URL,缺 affiliate 标记 ($SW_AFFILIATE_MARKER): $url"
      fi
    done <<< "$sw_urls"
  fi
  
  # Wise URL 检测
  wise_urls=$(grep -noE 'https://wise\.com[^)[:space:]]*' "$file" 2>/dev/null)
  if [ -n "$wise_urls" ]; then
    while IFS= read -r match; do
      line_num=$(echo "$match" | cut -d: -f1)
      url=$(echo "$match" | cut -d: -f2-)
      if ! echo "$url" | grep -q "$WISE_AFFILIATE_MARKER"; then
        error "$file:$line_num → Wise 使用普通 URL,缺 affiliate 标记 ($WISE_AFFILIATE_MARKER): $url"
      fi
    done <<< "$wise_urls"
  fi
  
  # World Nomads 占位符检测
  wn_placeholder=$(grep -nE '\[WORLDNOMADS_AFFILIATE_URL\]' "$file" 2>/dev/null)
  if [ -n "$wn_placeholder" ]; then
    while IFS= read -r match; do
      line_num=$(echo "$match" | cut -d: -f1)
      warn "$file:$line_num → World Nomads 仍为占位符,等待 CJ affiliate URL 启用"
    done <<< "$wn_placeholder"
  fi
  
  # World Nomads 普通 URL 检测 (CJ URL 启用前,任何 worldnomads.com 出现都标 ERROR)
  wn_naked=$(grep -noE 'https://(www\.)?worldnomads\.com[^)[:space:]]*' "$file" 2>/dev/null)
  if [ -n "$wn_naked" ]; then
    while IFS= read -r match; do
      line_num=$(echo "$match" | cut -d: -f1)
      url=$(echo "$match" | cut -d: -f2-)
      if [ -z "$WN_AFFILIATE_MARKER" ]; then
        error "$file:$line_num → World Nomads URL 出现但 CJ affiliate URL 尚未启用,应改用占位符 [WORLDNOMADS_AFFILIATE_URL]: $url"
      elif ! echo "$url" | grep -q "$WN_AFFILIATE_MARKER"; then
        error "$file:$line_num → World Nomads 使用普通 URL,缺 affiliate 标记: $url"
      fi
    done <<< "$wn_naked"
  fi
done

if [ $ERRORS -eq $AFF_BEFORE ]; then
  ok "Affiliate 提及次数与 URL 模板均合规"
fi

# ============================================================
# 8. 第一人称检测 (v1.5: 地名白名单扩充)
# ============================================================
divider "8. 第一人称检测 (First Person)"

FP_BEFORE=$ERRORS
for file in $FILES; do
  
  grep -nE '\b(my|we|our)\b' "$file" | while IFS= read -r match; do
    line_num=$(echo "$match" | cut -d: -f1)
    line_content=$(echo "$match" | cut -d: -f2-)
    
    if echo "$line_content" | grep -qE "^(---|title:|description:|sidebar|template)"; then
      continue
    fi
    
    # 白名单: "our + 内链" 形式 (例: our [Vietnam visa guide](/vietnam/visa/...))
    if echo "$line_content" | grep -qiE '\bour\s+\[' && echo "$line_content" | grep -qE '\]\(/'; then
      cleaned=$(echo "$line_content" | sed -E 's/our \[[^]]*\]\([^)]*\)//gi')
      if ! echo "$cleaned" | grep -qiE '\b(my|we|our)\b'; then
        continue
      fi
    fi
    
    # 白名单: FAQ 标题读者第一人称 (## Can I... / ### Do I...)
    if echo "$line_content" | grep -qE '^\s*(##|###|\*\*)' && echo "$line_content" | grep -qE '\?'; then
      continue
    fi
    
    # 白名单: 越南地名含 "My" (v1.5 扩充)
    if echo "$line_content" | grep -qiE 'My An|My Khe|Phu My|Hoan My|My Tho|My Son|My Dinh'; then
      cleaned=$(echo "$line_content" | sed -E 's/(My An|My Khe|Phu My Hung|Phu My Bridge|Phu My|Hoan My|My Tho|My Son|My Dinh)//gi')
      if ! echo "$cleaned" | grep -qiE '\b(my)\b'; then
        continue
      fi
    fi
    
    has_outside_quotes=false
    stripped=$(echo "$line_content" | sed -E 's/"[^"]*"//g')
    if echo "$stripped" | grep -qiE '\b(my|we|our)\b'; then
      has_outside_quotes=true
    fi
    
    if [ "$has_outside_quotes" = false ]; then
      continue
    fi
    
    error "$file:$line_num → 第一人称: $(echo "$line_content" | cut -c1-150)"
  done
  
  grep -nE '\bI\b' "$file" | while IFS= read -r match; do
    line_num=$(echo "$match" | cut -d: -f1)
    line_content=$(echo "$match" | cut -d: -f2-)
    
    if echo "$line_content" | grep -qE "^(---|title:|description:|sidebar|template)"; then
      continue
    fi
    
    # 白名单: 缩写词 (AI/UI/ID/FDI/JCI/VNeID/I-XX)
    cleaned=$(echo "$line_content" | sed -E 's/\b(AI|UI|ID|FDI|JCI|VNeID|I-[0-9]+)\b//g')
    if ! echo "$cleaned" | grep -qE '\bI\b'; then
      continue
    fi
    
    if echo "$line_content" | grep -qE '^\s*(##|###|\*\*)' && echo "$line_content" | grep -qE '\?'; then
      continue
    fi
    
    stripped=$(echo "$line_content" | sed -E 's/"[^"]*"//g')
    cleaned2=$(echo "$stripped" | sed -E 's/\b(AI|UI|ID|FDI|JCI|VNeID|I-[0-9]+)\b//g')
    if ! echo "$cleaned2" | grep -qE '\bI\b'; then
      continue
    fi
    
    warn "$file:$line_num → 可能的第一人称 I (请人工确认)"
  done
  
done

if [ $ERRORS -eq $FP_BEFORE ]; then
  ok "没有发现明确的第一人称使用"
fi

# ============================================================
# 9. 相对路径内链检测
# ============================================================
divider "9. 相对路径内链检测 (Relative Links)"

REL_BEFORE=$ERRORS
for file in $FILES; do
  rel_links=$(grep -onE '\]\([^)/][^)]*\)' "$file" | grep -v "http" | grep -v "mailto" | grep -v "\](#")
  
  if [ -n "$rel_links" ]; then
    while IFS= read -r match; do
      line_num=$(echo "$match" | cut -d: -f1)
      link=$(echo "$match" | cut -d: -f2-)
      error "$file:$line_num → 相对路径内链: $link (应使用绝对路径)"
    done <<< "$rel_links"
  fi
done

if [ $ERRORS -eq $REL_BEFORE ]; then
  ok "所有内链均使用绝对路径"
fi

# ============================================================
# 10. 内链引用地图
# ============================================================
divider "10. 内链引用地图 (Link Map)"

echo ""
echo "  每篇文章被引用次数:"
echo ""

for file in $FILES; do
  link_path=$(echo "$file" | sed "s|^${DOCS_DIR}||" | sed 's|\.md$||' | sed 's|\.mdx$||')
  ref_count=$(grep -rl "$link_path" $DOCS_DIR --include="*.md" --include="*.mdx" 2>/dev/null | grep -v "$file" | wc -l | tr -d ' ')
  short_name=$(basename "$file" .md)
  
  if [ "$ref_count" -eq 0 ]; then
    echo -e "    ${YELLOW}$short_name${NC} → 被引用 0 次 (孤立页面)"
  else
    echo -e "    ${GREEN}$short_name${NC} → 被引用 $ref_count 次"
  fi
done

# ============================================================
# 总结
# ============================================================
divider "检查总结"

echo ""
echo -e "  ${RED}Errors:   $ERRORS${NC}"
echo -e "  ${YELLOW}Warnings: $WARNINGS${NC}"
echo ""
echo "  说明:"
echo "  - ERROR  = 必须修复 (citation 标记、硬禁用词、断链、affiliate URL/超标、"
echo "             frontmatter 禁止字段、反引号路径、第一人称等)"
echo "  - WARN   = 人工判断 (语境敏感词、孤立页面、可能的第一人称、description 长度、"
echo "             裸路径、World Nomads 占位符等)"
echo ""

if [ $ERRORS -eq 0 ] && [ $WARNINGS -eq 0 ]; then
  echo -e "  ${GREEN}全部通过 ✓${NC}"
elif [ $ERRORS -eq 0 ]; then
  echo -e "  ${YELLOW}有 $WARNINGS 个警告需要人工确认${NC}"
else
  echo -e "  ${RED}有 $ERRORS 个错误必须修复${NC}"
fi

echo ""
exit $ERRORS
