#!/bin/bash

# ExpatGuide Article Quality Check Script v1.1
# 用法: 在项目根目录运行 bash check-articles.sh
# 可选: bash check-articles.sh path/to/specific-file.md (只检查单篇)
# 可选: bash check-articles.sh --who-links /vietnam/xxx/slug-name (查引用)

DOCS_DIR="src/content/docs"
CURRENT_YEAR="2026"
ERRORS=0
WARNINGS=0

# 颜色
RED='\033[0;31m'
YELLOW='\033[1;33m'
GREEN='\033[0;32m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

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
# 2. 禁用词检测
# ============================================================
divider "2. 禁用词检测 (Banned Words)"

BANNED_WORDS=(
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
  "navigate"
  "leverage"
  "robust"
  "ever-evolving"
  "landscape"
  "seamless"
  "holistic"
  "intricate"
  "nuanced"
  "multifaceted"
  "underscore"
  "pivotal"
  "crucial"
  "foster"
  "empower"
  "streamline"
  "tailored"
  "comprehensive"
  "in today's world"
  "in today's fast-paced environment"
  "whether you are"
  "it is worth noting"
  "plays a key role"
  "serves as a cornerstone"
)

BANNED_BEFORE=$ERRORS
for file in $FILES; do
  for word in "${BANNED_WORDS[@]}"; do
    matches=$(grep -ni "$word" "$file" 2>/dev/null)
    if [ -n "$matches" ]; then
      while IFS= read -r match; do
        line_num=$(echo "$match" | cut -d: -f1)
        error "$file:$line_num → 禁用词: \"$word\""
      done <<< "$matches"
    fi
  done
done

if [ $ERRORS -eq $BANNED_BEFORE ]; then
  ok "没有发现禁用词"
fi

# ============================================================
# 3. 标题年份检测
# ============================================================
divider "3. 标题年份检测 (Year in Title)"

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
# 4. Affiliate 计数
# ============================================================
divider "4. Affiliate 检测 (SafetyWing / Wise / World Nomads)"

AFF_BEFORE=$ERRORS
for file in $FILES; do
  sw_count=$(grep -oi "safetywing" "$file" | wc -l | tr -d ' ')
  
  # Wise: 排除 otherwise, likewise, wisdom 等非品牌词
  wise_all=$(grep -oiE '\bwise\b' "$file" | wc -l | tr -d ' ')
  wise_false=$(grep -oiE '\b(otherwise|likewise|wisdom)\b' "$file" | wc -l | tr -d ' ')
  wise_brand=$((wise_all - wise_false))
  if [ $wise_brand -lt 0 ]; then wise_brand=0; fi
  
  wn_count=$(grep -oi "world nomads" "$file" | wc -l | tr -d ' ')
  
  # SafetyWing 超标
  if [ "$sw_count" -gt 1 ]; then
    error "$file → SafetyWing 出现 $sw_count 次 (上限1次)"
  fi
  
  # Wise: banking guide 是专题文章,Wise 作为正文主题不算超标
  is_banking=false
  if [[ "$file" == *"bank-account"* ]] || [[ "$file" == *"banking"* ]]; then
    is_banking=true
  fi
  
  if [ "$is_banking" = false ] && [ "$wise_brand" -gt 1 ]; then
    warn "$file → Wise 品牌提及 $wise_brand 次 (上限1次,请人工确认)"
  fi
  
  # World Nomads 超标
  if [ "$wn_count" -gt 1 ]; then
    error "$file → World Nomads 出现 $wn_count 次 (上限1次)"
  fi
  
  # World Nomads + SafetyWing 同句
  if [ "$wn_count" -gt 0 ] && [ "$sw_count" -gt 0 ]; then
    same_line=$(grep -i "safetywing" "$file" | grep -i "world nomads")
    if [ -n "$same_line" ]; then
      error "$file → World Nomads 和 SafetyWing 出现在同一句"
    fi
  fi
done

if [ $ERRORS -eq $AFF_BEFORE ]; then
  ok "Affiliate 提及次数合规"
fi

# ============================================================
# 5. 第一人称检测 (带例外)
# ============================================================
divider "5. 第一人称检测 (First Person)"

# 例外规则:
# 1. "our" + 紧跟内链引用 (our [xxx](...)) → 站点编辑语气,允许
# 2. FAQ 标题 (## / ### / ** 开头的问句) 中的 I/my → 读者视角,允许
# 3. 地名中的 My (My An, My Khe, Phu My Hung, Hoan My) → 不是第一人称

FP_BEFORE=$ERRORS
for file in $FILES; do
  
  # --- 检测 my / we / our ---
  grep -nE '\b(my|we|our)\b' "$file" | while IFS= read -r match; do
    line_num=$(echo "$match" | cut -d: -f1)
    line_content=$(echo "$match" | cut -d: -f2-)
    
    # 跳过 frontmatter 区域
    if echo "$line_content" | grep -qE "^(---|title:|description:|sidebar|template)"; then
      continue
    fi
    
    # 例外1: our + 内链 (our [xxx](/...))
    if echo "$line_content" | grep -qiE '\bour\s+\[' && echo "$line_content" | grep -qE '\]\(/'; then
      # 检查这行除了 "our [link]" 之外是否还有其他 my/we/our
      cleaned=$(echo "$line_content" | sed -E 's/our \[[^]]*\]\([^)]*\)//gi')
      if ! echo "$cleaned" | grep -qiE '\b(my|we|our)\b'; then
        continue
      fi
    fi
    
    # 例外2: FAQ 标题问句
    if echo "$line_content" | grep -qE '^\s*(##|###|\*\*)' && echo "$line_content" | grep -qE '\?'; then
      continue
    fi
    
    # 例外3: 地名 My
    if echo "$line_content" | grep -qiE 'My An|My Khe|Phu My|Hoan My'; then
      cleaned=$(echo "$line_content" | sed -E 's/(My An|My Khe|Phu My Hung|Phu My|Hoan My)//gi')
      if ! echo "$cleaned" | grep -qiE '\b(my)\b'; then
        continue
      fi
    fi
    
    error "$file:$line_num → 第一人称: $(echo "$line_content" | cut -c1-150)"
  done
  
  # --- 检测独立大写 I ---
  grep -nE '\bI\b' "$file" | while IFS= read -r match; do
    line_num=$(echo "$match" | cut -d: -f1)
    line_content=$(echo "$match" | cut -d: -f2-)
    
    # 跳过 frontmatter
    if echo "$line_content" | grep -qE "^(---|title:|description:|sidebar|template)"; then
      continue
    fi
    
    # 排除常见缩写: AI, UI, ID, FDI, JCI, VNeID, I-xx
    cleaned=$(echo "$line_content" | sed -E 's/\b(AI|UI|ID|FDI|JCI|VNeID|I-[0-9]+)\b//g')
    if ! echo "$cleaned" | grep -qE '\bI\b'; then
      continue
    fi
    
    # 例外: FAQ 标题问句
    if echo "$line_content" | grep -qE '^\s*(##|###|\*\*)' && echo "$line_content" | grep -qE '\?'; then
      continue
    fi
    
    # 例外: 引号内的 I (如 "I had an IDP")
    if echo "$line_content" | grep -qE '"[^"]*\bI\b[^"]*"'; then
      cleaned2=$(echo "$line_content" | sed -E 's/"[^"]*"//g')
      if ! echo "$cleaned2" | grep -qE '\bI\b'; then
        continue
      fi
    fi
    
    warn "$file:$line_num → 可能的第一人称 I (请人工确认)"
  done
  
done

if [ $ERRORS -eq $FP_BEFORE ]; then
  ok "没有发现明确的第一人称使用"
fi

# ============================================================
# 6. 相对路径内链检测
# ============================================================
divider "6. 相对路径内链检测 (Relative Links)"

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
# 7. 内链引用地图
# ============================================================
divider "7. 内链引用地图 (Link Map)"

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

if [ $ERRORS -eq 0 ] && [ $WARNINGS -eq 0 ]; then
  echo -e "  ${GREEN}全部通过 ✓${NC}"
elif [ $ERRORS -eq 0 ]; then
  echo -e "  ${YELLOW}有 $WARNINGS 个警告需要人工确认${NC}"
else
  echo -e "  ${RED}有 $ERRORS 个错误必须修复${NC}"
fi

echo ""
exit $ERRORS
