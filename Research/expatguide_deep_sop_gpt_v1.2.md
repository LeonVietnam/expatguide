# ExpatGuide GPT-Only 深度文章生产 SOP v1.2

## 文档定位

本文件只服务 **deep lane / 深度车道文章生产**。

适用于高风险、高后果、高时效、高法规依赖、高商业价值或 flagship 类型的 ExpatGuide 文章。

本文件是 GPT-only deep lane 的主 SOP，不使用 Claude QA。深度文章通过三个隔离项目 / 窗口完成：

1. Deep Draft
2. Deep Risk QA
3. Deep Patch Verify

## v1.2 更新重点

相对 v1.1，本版继续修补正式测试前暴露的 2 个风险点：

1. Source Spot Check Evidence 规则收紧：Evidence 必须是从 source 实际抓取的原文或结构化原始内容；“无法访问 / 无法验证”不再算合格 Evidence。
2. high-risk claim 如果 unable to verify 且文章写成确定性事实，必须升级为 Critical issue，除非正文已经明确写成 uncertain / approximate / as of / varies by / subject to change。
3. Source Spot Check 引入 60% Evidence quota，防止整篇 spot check 空转；100% unable to verify 时返回 `GPT QA ISSUE LIST — DEFERRED`，不进入 patch。
4. GRAY 立场第三条改为主动搜索 + 结果声明，堵住“没找证据就默认无差异”的循环逻辑。

---

## 与 normal lane 的关系

- normal lane 使用 `expatguide_sop_v2.53_normal.md`。
- deep lane 使用本文件 + deep draft / risk QA / patch verify mini-specs。
- normal lane 以 decision-usefulness 优先。
- deep lane 以 factual robustness 优先。

---

## Deep Lane 适用范围

以下主题默认进入 deep lane：

- visa
- residency / TRC
- tax
- insurance
- healthcare
- banking
- legality / compliance
- drivers license / legal driving status
- work permits
- immigration status
- official registration / police reporting
- high-consequence financial decisions
- high-consequence medical decisions
- major effective-date changes
- multiple official sources conflict
- official rule vs practical execution strongly diverges
- pillar / flagship topic

规则：

- high 就是 deep。
- 不存在“先用 normal lane 试试看”。
- 不能为了效率降低风险等级。

---

## Deep Lane 核心原则

1. factual robustness 优先于流畅度。
2. official rules 和 practical execution 必须分层。
3. gray-area claims 不得被压成确定结论。
4. effective date / eligibility / scope boundary 必须保留。
5. 如果法规、资格、费用、适用对象存在不确定性，必须写出条件或降级措辞。
6. 不为了 SEO、简洁或可读性删除关键限制条件。
7. 不把 community reports 写成 universal facts。
8. 不把 company marketing copy 写成事实。
9. 不把旧法规、旧行政区、旧流程当成当前事实。
10. 所有 patch 必须最小改动，并保留 deep-lane 风险边界。

---

## 站点固定规则

- 标题必须带年份。
- frontmatter 必须包含 `sidebar.label`。
- 内链必须以 `/` 开头。
- 内链 slug 必须存在于最新 `internal-articles-index.md`。
- 禁止编造 slug。
- 禁止作者第一人称。
- 允许 `our + internal link` 的站点编辑语气。
- 允许 FAQ 标题中的读者第一人称，如 “Can I...”。
- 禁用词规则沿用 normal lane。
- SafetyWing / Wise / World Nomads 等 affiliate 提及必须自然、克制、合规。
- 不得留下 OpenAI citation markers：`:contentReference`、`oaicite`、`{index=`、未替换的 `【...】`。

---

## Deep Lane 总流程

### Deep Draft 项目

1. Deep TOPIC SHEET
2. DEEP RESEARCH PACK
3. VALIDATION PACK — STRICT
4. VALIDATION PACK — GRAY
5. VALIDATION PACK — FINAL (Merged)
6. DEEP DRAFT PACKAGE
7. DEEP CLAIM SHEET
8. RISK QA HANDOFF BLOCK

### Deep Risk QA 项目

9. Risk QA + Source Spot Check → GPT QA ISSUE LIST

### Deep Draft 项目

10. DEEP FINAL PACKAGE
11. PATCH VERIFY HANDOFF BLOCK

### Deep Patch Verify 项目

12. PATCH VERIFICATION LIST

### 本地落地

13. 保存文件
14. `bash check-articles.sh`
15. `npm run dev`
16. `git push`
17. GSC 索引提交
18. 刷新 internal articles index 并同步项目知识

---

## Deep TOPIC SHEET 要求

必须包含：

- Title
- Country / City
- Category
- Risk Tier
- Risk Subtype: legal / financial / health / immigration / compliance / mixed
- Effective Date Sensitivity: ≤6 months / ≤12 months / ≤24 months / >24 months
- Multi-Source Conflict Expected: yes/no
- Need Official-vs-Practical Distinction: yes/no
- Primary Scope
- Adjacent Space
- Decision on Adjacent: included-full / included-brief / omitted
- Target Reader
- Core Search Intent
- Why This Needs Deep Lane
- Suggested Internal Links

---

## DEEP RESEARCH PACK 要求

必须包含：

- Reader Questions
- Recommended Angle
- Suggested Outline
- Key Claims Table
- Regulatory Source Map
- Authority Hierarchy
- Conflict Inventory
- Eligibility Matrix
- Possible Internal Links
- Affiliate / Monetization Fit
- Potential Weak Spots

Key Claims Table 每行必须包含：

- Claim
- Source URL
- Source Type: Tier 1 / Tier 2 / Tier 3 / Tier 4
- Why It Matters
- Freshness Risk
- Official / Practical / Gray-area

Regulatory Source Map 如适用必须包含：

- regulation / policy name
- number / identifier
- issuing authority
- promulgated date
- effective date
- current status
- supersedes / superseded by

未知就写 `unknown`，不得编造。

---

## Validation 双跑

Deep lane 默认使用：

1. VALIDATION PACK — STRICT
2. VALIDATION PACK — GRAY
3. VALIDATION PACK — FINAL (Merged)

高风险主题建议把 STRICT 和 GRAY 放在 Deep Draft 项目内的独立 chat 跑，降低同一上下文互相污染。

### STRICT 立场

- 假设官方规则严格执行。
- Tier 1 不足时，YMYL claim 默认 Yellow。
- 只有 Tier 4 支撑的 official-layer claim 默认 Red。
- 生效日期不清的法规 claim 默认 Yellow。

### GRAY 立场

- 主动寻找实际执行与官方规则的偏离。
- 对 practical claim 要求 Tier 2–4 支撑或明确降级。
- 对于 “rule says X” 类型的 claim，GRAY 立场必须主动尝试寻找实际操作中的偏离证据：
  - 如果 web 工具可用，主动搜索 community reports / forum discussions / expat group posts / news reports / industry commentary / service-provider notes 中是否存在实际操作差异。
  - 如果搜索后找到证据，该 claim 必须进入 Gray-Area Claim，并在 drafting 时使用 Layered Writing。
  - 如果搜索后未找到证据，必须在 `VALIDATION PACK — GRAY` 输出中明确写一行：`No practice divergence found for [claim summary] despite active search across [searched source types]. Treating as Final Green from gray-stance perspective.`
  - 如果 web 工具不可用，该 claim 默认标为 Gray-Area-Gray，理由为 `unable to verify divergence; defaulting to gray-area for safety`，并在 drafting 时使用 Layered Writing。
  - 这条规则的目的：GRAY 立场的默认状态是怀疑，不是信任；不得因为没有主动寻找证据就默认“无实践差异”。

### Merge 规则

- 两跑都 Green → Final Green
- Green + Yellow → Final Yellow + caveat
- Green + Red → Final Red / omit
- Yellow + Red → Final Red / omit
- 两 Yellow → Final Yellow + caveat
- 任一跑标 Gray-Area → Final Gray-Area Claim，必须 Layered Writing

如果 Topic Sheet 预期有 conflict，但 Final 中没有 Gray-Area Claims，必须重跑或解释。

---

## DEEP DRAFT PACKAGE 输出要求

Deep Draft 必须输出：

- Title
- Meta Title
- Meta Description
- Suggested Slug
- Frontmatter Block
- Article
- Internal Links Used
- Affiliate Mentions Used
- Source Risk Notes
- Deep Self-Audit

Article 必须从第一个 `##` 开始，无 H1，无重复 frontmatter。

Deep Self-Audit 至少覆盖：

- year_in_title
- sidebar_label_present
- first_person
- banned_words
- absolute_internal_links_only
- affiliate_limits
- affiliate_compliance
- regulatory_citation_completeness
- effective_date_check
- eligibility_scope_preserved
- layered_writing_preserved
- official_vs_practical_distinction
- unsupported_claims_omitted
- no_openai_citation_markers
- markdown_format

---

## DEEP CLAIM SHEET 要求

Draft 后必须输出 DEEP CLAIM SHEET。只列高风险 claims，不列所有句子。

必须覆盖：

- legal / regulatory conclusions
- effective dates
- eligibility or scope boundaries
- fees, penalties, thresholds, processing times
- insurance / healthcare / banking / tax / visa claims
- official vs practical distinction sentences
- gray-area conclusions
- affiliate-sensitive claims

每条使用：

```text
Claim ID:
- Sentence quote:
- Claim type: official / practical / gray-area / affiliate-sensitive / mixed
- Source basis:
- Source URL(s):
- Tier level:
- Effective date relevance: yes/no
- Eligibility / scope sensitivity: yes/no
- Volatility: low / medium / high
- Risk if wrong:
- Safe wording status: safe / needs caution / too strong / unsupported
```

---

## RISK QA HANDOFF BLOCK

Deep Draft 输出 Draft 和 Claim Sheet 后，必须额外输出完整交接包。

格式：

```text
=== RISK QA HANDOFF BLOCK START ===

--- TOPIC SHEET ---
[paste the latest accepted DEEP TOPIC SHEET]

--- DEEP RESEARCH PACK ---
[paste the latest accepted DEEP RESEARCH PACK]

--- VALIDATION PACK — FINAL ---
[paste the latest accepted VALIDATION PACK — FINAL]

--- DEEP CLAIM SHEET ---
[paste the full DEEP CLAIM SHEET]

--- DRAFT FRONTMATTER + ARTICLE ---
[paste Frontmatter Block and Article only]

--- INTERNAL LINKS USED + AFFILIATE MENTIONS USED + DEEP SELF-AUDIT ---
[paste Internal Links Used, Affiliate Mentions Used, and Deep Self-Audit]

=== RISK QA HANDOFF BLOCK END ===
```

用户只复制整段到 Deep Risk QA 项目。

---

## Deep Risk QA 要求

Deep Risk QA 项目以 `deep-risk-qa-mini-spec-v4.1.md` 为唯一细则来源。

核心要求：

- 不写稿。
- 不 patch。
- 不新增 unsupported facts。
- 必须执行 Source Spot Check。
- Source Spot Check 必须遵守 `deep-risk-qa-mini-spec-v4.1.md` 的 evidence quality rule。
- Evidence 必须是实际抓取的原文、结构化原始行、或 PDF / 图片文件标题 + 关键内容；“无法访问 / 无法验证”不构成 Evidence。
- `unable to verify` 必须解释原因。
- 核心高风险 claim 无法验证时，必须升级为 High 或 Critical，除非正文已明确写成不确定。
- `no material issues found` 必须列出高风险检查覆盖和潜在失败模式。

Risk QA 输出：`GPT QA ISSUE LIST`。

---

## Patch 规则

Deep Draft 项目拿到 `GPT QA ISSUE LIST` 后做最小 patch。

规则：

- 只修 Issue List 中的问题。
- 不重写未提及段落。
- 不引入新 unsupported facts。
- 不为了风格顺手润色。
- 不破坏 Layered Writing。
- 不删除法规 full name / number / effective date。
- 不让 affiliate 更促销。
- Patch Changelog 必须逐 Issue ID 映射。

如果 Risk QA 返回 `no material issues found`，不做正文修改，只把 Draft 包装成 Final Package。

---

## DEEP FINAL PACKAGE 输出要求

Final Package 必须包含：

- Final Frontmatter Block
- Final Article
- Patch Changelog
- Final Internal Links Used
- Final Affiliate Mentions Used
- Final Self-Audit

Patch Changelog 每个 Issue ID 必须包含：

- original sentence
- changed sentence
- change type
- meaning changed: yes/no
- why substantive
- layered writing affected: yes/no
- regulatory citation affected: yes/no
- affiliate affected: yes/no

---

## PATCH VERIFY HANDOFF BLOCK

Deep Draft 输出 Final Package 后，必须额外输出完整交接包。

格式：

```text
=== PATCH VERIFY HANDOFF BLOCK START ===

--- GPT QA ISSUE LIST ---
[paste the full GPT QA ISSUE LIST received from Risk QA]

--- PATCH CHANGELOG ---
[paste the full Patch Changelog; if no patch, state no material issues found; no patch applied]

--- FINAL FRONTMATTER BLOCK ---
[paste Final Frontmatter Block]

--- FINAL ARTICLE ---
[paste Final Article]

--- FINAL INTERNAL LINKS USED ---
[paste Final Internal Links Used]

--- FINAL AFFILIATE MENTIONS USED ---
[paste Final Affiliate Mentions Used]

--- FINAL SELF-AUDIT ---
[paste Final Self-Audit]

=== PATCH VERIFY HANDOFF BLOCK END ===
```

用户只复制整段到 Deep Patch Verify 项目。

---

## Patch Verify 要求

Patch Verify 项目以 `deep-patch-verify-mini-spec-v4.md` 为唯一细则来源。

输出 verdict：

- ready for local save
- re-patch required
- structural failure

`structural failure` 只在以下情况使用：

- 同一 Critical / High issue patch 后仍未修复；
- patch 引入新的 Critical / High issue；
- official/practical 或 gray-area 在多个关键位置反复被压平；
- Final Article 与 Validation Pack / Issue List 出现结构性冲突；
- 剩余问题需要重新起草，而不是句子级 patch。

---

## bash check errors 处理

本地 `bash check-articles.sh` 报错时：

- frontmatter / markdown / banned words / internal links / citation marker：回 Deep Draft 项目做机械修复。
- 如果修复涉及法规、生效日、eligibility、gray-area、affiliate caveat：修完后回 Patch Verify 项目小范围验证。

---

## 最终通过标准

深度文章只有同时满足以下条件，才可进入发布：

1. factual robustness 优先得到保留。
2. official vs practical 明确分层。
3. gray-area 未被压平。
4. effective date / eligibility / scope boundaries 清楚。
5. 高风险 claim 已进入 Claim Sheet。
6. Source Spot Check 有证据输出，未发现重大支撑缺口。
7. patch 与 Issue ID 一一对应。
8. Patch Verify 通过。
9. bash check 无 errors。
10. 预览正常。
11. 内链合法。
12. affiliate 合规。
13. markdown / frontmatter 合法。
14. 文章仍然像 reference page，不像个人博客或 AI 摘要。
