#!/bin/bash

# ExpatGuide Batch Fix Script
# 在项目根目录运行: bash fix-errors.sh
# 运行前建议先 git commit 当前状态,方便回滚

DOCS="src/content/docs/vietnam"

echo "开始修复..."
echo ""

# ============================================================
# 禁用词修复 (15 处)
# ============================================================

echo "===== 禁用词修复 ====="

# 1. motorbike-guide:49 - leverage → bargaining power
sed -i '' 's/you have zero leverage in any dispute/you have zero bargaining power in any dispute/' "$DOCS/daily-life/motorbike-guide-2026.md"
echo "  ✓ motorbike-guide:49 leverage → bargaining power"

# 2. digital-nomad:86 - foster → build
sed -i '' 's/actively foster community/actively build community/' "$DOCS/digital-nomad/da-nang-vs-hanoi-vs-saigon-digital-nomad-guide-2026.md"
echo "  ✓ digital-nomad:86 foster → build"

# 3. healthcare:9 - landscape → situation
sed -i '' 's/the post-reform landscape as of/the post-reform situation as of/' "$DOCS/healthcare/healthcare-vietnam-expats-2026.md"
echo "  ✓ healthcare:9 landscape → situation"

# 4. healthcare:69 - whether you are → whether you get
sed -i '' 's/whether you are quoted the local price/whether you get quoted the local price/' "$DOCS/healthcare/healthcare-vietnam-expats-2026.md"
echo "  ✓ healthcare:69 whether you are → whether you get"

# 5. avoid-rental-scams:17 - nuanced → complicated
sed -i '' 's/the situation is more nuanced/the situation is more complicated/' "$DOCS/housing/avoid-rental-scams-vietnam-2026.md"
echo "  ✓ avoid-rental-scams:17 nuanced → complicated"

# 6. avoid-rental-scams:17 - leverage → bargaining power
sed -i '' 's/significantly more leverage in negotiations/significantly more bargaining power in negotiations/' "$DOCS/housing/avoid-rental-scams-vietnam-2026.md"
echo "  ✓ avoid-rental-scams:17 leverage → bargaining power"

# 7. danang:267 - Crucially → In practice
sed -i '' 's/^Crucially, the government abolished/In practice, the government abolished/' "$DOCS/housing/best-neighborhoods-danang-expats-2026.md"
echo "  ✓ danang:267 Crucially → In practice"

# 8. hanoi:236 - seamless → easy
sed -i '' 's/international integration is seamless/international integration is easy/' "$DOCS/housing/best-neighborhoods-hanoi-expats-2026.md"
echo "  ✓ hanoi:236 seamless → easy"

# 9. hanoi:238 - charming → pleasant
sed -i '' 's/"charming on Sunday morning"/"pleasant on Sunday morning"/' "$DOCS/housing/best-neighborhoods-hanoi-expats-2026.md"
echo "  ✓ hanoi:238 charming → pleasant"

# 10. trc:36 - navigate → deal with
sed -i '' 's/having to navigate monthly foreigner/having to deal with monthly foreigner/' "$DOCS/visa/trc-application-guide-2026.md"
echo "  ✓ trc:36 navigate → deal with"

# 11. trc:156 - straightforward → direct
sed -i '' 's/the most straightforward path/the most direct path/' "$DOCS/visa/trc-application-guide-2026.md"
echo "  ✓ trc:156 straightforward → direct"

# 12. trc:312 - straightforward → simple
sed -i '' 's/Long-term leases become straightforward/Long-term leases become simple/' "$DOCS/visa/trc-application-guide-2026.md"
echo "  ✓ trc:312 straightforward → simple"

# 13. trc:321 - straightforward → standard
sed -i '' 's/for a straightforward LD or TT/for a standard LD or TT/' "$DOCS/visa/trc-application-guide-2026.md"
echo "  ✓ trc:321 straightforward → standard"

# 14. visa:29 - Landscape → System
sed -i '' 's/The 2026 Visa Landscape/The 2026 Visa System/' "$DOCS/visa/visa-guide-2026.md"
echo "  ✓ visa:29 Landscape → System"

# 15. visa:181 - straightforward → simple
sed -i '' "s/It's straightforward/It's simple/" "$DOCS/visa/visa-guide-2026.md"
echo "  ✓ visa:181 straightforward → simple"

echo ""

# ============================================================
# 第一人称修复 (1 处)
# ============================================================

echo "===== 第一人称修复 ====="

# trc:17 - "before we dive in" → "before getting started" (同时修掉禁用词 dive in)
sed -i '' 's/One scope note before we dive in:/One scope note before getting started:/' "$DOCS/visa/trc-application-guide-2026.md"
echo "  ✓ trc:17 'before we dive in' → 'before getting started'"

echo ""

# ============================================================
# SafetyWing 超标修复 (2 篇)
# ============================================================

echo "===== SafetyWing 超标修复 ====="

# visa-guide:144 - 删除 SafetyWing 提及,保留实用信息
# 原文: "If you're doing frequent visa runs, make sure your travel medical insurance like [SafetyWing](https://safetywing.com/...) covers you while in transit across borders — some policies have gaps during overland crossings."
# 改为: 去掉品牌名和链接,保留保险建议
sed -i '' 's/make sure your travel medical insurance like \[SafetyWing\](https:\/\/safetywing.com\/?referenceID=26505542\&utm_source=26505542\&utm_medium=Ambassador) covers you while in transit/make sure your travel medical insurance covers you while in transit/' "$DOCS/visa/visa-guide-2026.md"
echo "  ✓ visa:144 SafetyWing 品牌提及移除,保留保险建议"

# motorbike-guide:66 - 删除整个 SafetyWing+World Nomads 重复推荐段落
# 原文: "**Regardless of your license situation**, having travel insurance... World Nomads is another widely used alternative worth comparing."
# 改为: 保留核心建议但去掉品牌名
sed -i '' 's/\*\*Regardless of your license situation\*\*, having travel insurance that covers motorbike incidents in Southeast Asia is non-negotiable. \[SafetyWing'\''s Nomad Insurance\](https:\/\/safetywing.com\/?referenceID=26505542\&utm_source=26505542\&utm_medium=Ambassador) is one of the most popular options among expats in Vietnam. It can cover motorbike-related incidents, but coverage depends on your license status, bike displacement, and other policy conditions — check their current terms and pricing before purchasing. World Nomads is another widely used alternative worth comparing./**Regardless of your license situation**, having travel insurance that covers motorbike incidents in Southeast Asia is non-negotiable. Coverage depends on your license status, bike displacement, and other policy conditions — check the current terms of your plan before purchasing./' "$DOCS/daily-life/motorbike-guide-2026.md"
echo "  ✓ motorbike:66 SafetyWing+World Nomads 重复推荐移除"

echo ""
echo "===== 修复完成 ====="
echo ""
echo "下一步:"
echo "  1. 运行 bash check-articles.sh 验证"
echo "  2. 用 git diff 检查所有改动"
echo "  3. 确认无误后 git add . && git commit -m 'fix: banned words, SafetyWing caps, first person' && git push"
