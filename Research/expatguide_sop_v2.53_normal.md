# ExpatGuide 普通文章生产手册 v2.53（Normal Lane Only）

## v2.53 定位

本文件只服务 **normal lane / 普通车道文章生产**。

它用于低到中风险、实操型、生活服务型、轻对比型 ExpatGuide 文章。它不包含 deep lane 的 Deep Draft Prompt、Claude QA、GPT Risk QA、GPT Patch Verify 或任何深度车道二审流程。

如果主题触发 deep lane，本文件只负责把主题路由出去，不在 normal lane 内继续生产。

---

## v2.53 相比 v2.52 的变化

1. 清理所有 deep lane 正文流程。
2. 删除 Deep Draft Prompt。
3. 删除 Claude QA Prompt。
4. 删除 deep lane 总览与补充章节。
5. 保留普通车道生产需要的硬规则、Prompt 1-5、Self-Audit、内链、affiliate、frontmatter 和 Decision Data Floor。
6. 保留 deep lane 路由规则：高风险主题必须转出 normal lane。

---

## 适用范围

### 适合 normal lane 的主题

- FAQ
- 常规 guide
- 低到中风险 practical guide
- 生活服务类主题
- 轻度产品 / 服务对比
- 不需要大规模法规裁决的日常问题
- 即使有 official vs practical 区分，也不会造成高后果误导的主题

### 不适合 normal lane 的主题

以下主题必须转出 normal lane：

- visa
- residency / TRC
- tax
- insurance
- healthcare
- banking
- legality / compliance
- drivers license / legal driving status
- 高后果财务、法律、医疗、身份、合规决策
- 强时效法规主题
- 多个官方来源冲突的主题
- 需要处理重大生效日的主题
- 准备做 pillar / flagship 的主题

---

## 核心原则

1. 不依赖自动衔接。
2. 每一步都由显式 prompt 触发。
3. 上一步输出原样喂给下一步。
4. normal lane 文章优先帮助读者做决定，不追求信息无限完整。
5. 当 decision-usefulness 与 factual caution 冲突时，normal lane 倾向 decision-usefulness。
6. 过度保守、读者读完仍不知道怎么做，是 normal lane 的失败案例。
7. 不能为了效率把 high-risk topic 留在 normal lane。

---

## 站点固定规则

- 标题必须带年份。
- frontmatter 必须包含 `sidebar.label`。
- 内链必须是绝对路径，以 `/` 开头。
- 内链 slug 必须存在于 `internal-articles-index.md`。
- 禁止使用 `[DOMAIN]`、`[TBD]`、`/placeholder` 或编造 slug。
- 禁止作者第一人称。
- 允许 `our + internal link` 的站点编辑语气。
- 允许 FAQ 标题里的读者第一人称，例如 `Can I...?`。
- 不暴露作者身份。
- 不写成个人博客。
- 禁用词必须过滤。
- 价格、费用、时效、租金等尽量使用区间，除非明确验证。
- SafetyWing 最多自然提及一次。
- Wise 最多自然提及一次。
- World Nomads 不与 SafetyWing 同句。
- 数据来源说明可用 italic 小字标注。
- 语气必须是 neutral, practical, reference-style。

---

## 禁用词规则

### 硬禁用词

以下词任何语境都禁止：

- vibrant
- bustling
- hidden gem
- melting pot
- charming
- nestled
- epicenter
- In conclusion
- Let's dive in
- It's important to note
- straightforward
- paradise
- dream
- tropical haven
- delve
- tapestry
- ever-evolving
- seamless
- holistic
- intricate
- multifaceted
- underscore
- pivotal
- foster
- empower
- streamline
- tailored
- in today's world
- in today's fast-paced environment
- whether you are
- it is worth noting
- plays a key role
- serves as a cornerstone

### 语境敏感词

| 词 | 允许 | 禁止 |
|---|---|---|
| leverage | 名词本义：negotiation / financial leverage | 动词填充语：leverage X to Y |
| navigate | 实际方位 / UI 导航 | 抽象隐喻：navigate complexities |
| landscape | 地理景观 | 抽象比喻：regulatory landscape |
| comprehensive | 精确保险覆盖语境 | 文章自夸：comprehensive guide |
| robust | 工程 / 技术稳健 | 抽象系统：robust strategy |
| nuanced | 后面具体说明差异 | 单独替代“复杂” |
| crucial | 真正不可或缺的客观条件 | 泛泛强调 |

判定原则：如果换成平实词后意思不损失，原词就是填充语，应删除或替换。

---

## sidebar.label 规则

### 格式

```yaml
sidebar:
  label: "Short Label"
```

### 设计原则

1. 指向性优先。
2. 避免歧义。
3. 3-6 个词为宜。
4. 不为美观牺牲清晰。
5. 不重复板块名。
6. 同系列内容可用统一前缀。

### 正例

- `Visa Options`
- `Cost of Living: Hoi An`
- `Driver's License Conversion`
- `Essential Apps`
- `Foreign Cards: Where They Work`

### 反例

- `Visa`
- `Cards`
- `Guide`
- `Neighborhoods`
- `Hoi An`

---

## 内链规则

### 可信来源

内部链接唯一可信来源是最新的 `internal-articles-index.md`。

### 规则

- Possible Internal Links 只能使用 index 里存在的 slug。
- 正文内链必须使用 `[text](/path)` 格式。
- 内链必须以 `/` 开头。
- 不允许 `https://expatguide.site/...` 形式作为内部链接。
- 不允许相对路径。
- 不允许编造 slug。

### 更新时机

每次新文章发布后：

```bash
bash generate-link-index.sh
```

然后把新的 `internal-articles-index.md` 上传到 normal production 项目，替换旧版。

---

## Affiliate 规则

### 上限

- SafetyWing：最多 1 次。
- Wise：最多 1 次。
- World Nomads：最多 1 次。
- World Nomads 不与 SafetyWing 同句。

### 下限

如果 affiliate 产品是读者问题的自然答案，不应默认跳过。

自然适配场景：

- foreign cards / foreign ATM withdrawals / multi-currency / cross-border money → Wise
- short-to-medium travel medical insurance / nomad insurance → SafetyWing
- adventure sports / high-risk activity coverage → World Nomads

判定标准：如果一个独立 expat 朋友回答这个问题时会自然提到该产品，可以自然提及一次。不能硬塞，不能促销化。

---

## Scope Definition Check

每个 Topic Sheet 必须包含：

1. **Primary Scope**：文章核心覆盖内容。
2. **Adjacent Space**：读者决策时会对比的外部选项。
3. **Decision on Adjacent**：`included-full` / `included-brief` / `omitted`。

### 判定原则

如果读者的问题是“怎么做到 X”，文章通常要覆盖完整决策空间，不能被某个品牌或服务商锁死。

如果读者的问题是“某个具体服务怎么用”，可以 focused，但要说明是否 brief mention adjacent options。

---

## Decision Data Floor

当文章比较具体产品、服务、渠道、供应商、价格层级时，必须包含足够的决策数据。

### 触发场景

- 选择 gym
- 国际寄件
- 家具购买
- home internet
- 电费支付方式
- 家政、洗衣、维修、打印、快递等服务对比

### 必须包含

1. 价格区间或 cautious public anchor。
2. 时间 / 时效 / 等待周期，如果适用。
3. 去哪里 / 怎么找 / 具体起点。
4. 波动性 caveat，例如 “varies by provider, city, size, and package”。

如果读者读完仍没有粗略价格、时效、渠道判断，文章未达标。

---

## Normal Lane 总流程

1. Prompt 1 → TOPIC SHEET
2. Prompt 2 → RESEARCH PACK
3. Prompt 3 → VALIDATION PACK
4. Prompt 4 → DRAFT PACKAGE
5. Prompt 5 → FINAL PACKAGE

---

## Prompt 1：Topic Proposal / Topic Sheet

```text
HARD RULES
- no first person, except "our" + internal link references and reader-perspective FAQ headings
- year in title
- absolute internal links only
- banned words list applies
- use ranges for prices unless explicitly verified
- affiliate caps apply

You are helping plan normal-lane editorial topics for ExpatGuide.

About the site:
- ExpatGuide is a neutral reference site for foreigners living abroad.
- It is not a personal blog.
- It must remain anonymous.
- Good content helps readers solve concrete expat problems and leave.
- Strong articles distinguish official rules from practical execution when needed.

Scope:
[PASTE COUNTRY / CITY / CATEGORY]

Goal:
[PASTE GOAL]

AVAILABLE INTERNAL ARTICLES:
[PASTE latest internal-articles-index.md]

Task:
Generate normal-lane topic proposals or one complete TOPIC SHEET, depending on the user's request.

Routing rule:
- If Execution Risk = high, route the topic out of normal lane.
- If Need Official-vs-Practical Distinction = yes and the topic involves visa, residency, TRC, tax, insurance, healthcare, banking, legality, compliance, or another high-consequence expat decision, route the topic out of normal lane.
- Do not keep high-risk topics in normal lane for convenience.

Every TOPIC SHEET must include:
- Title
- Category
- Country/City
- Article Type: normal
- Target Reader
- Core Search Intent
- Why This Topic Matters
- Need Official-vs-Practical Distinction: yes / no
- Execution Risk: low / medium / high
- Primary Scope
- Adjacent Space
- Decision on Adjacent: included-full / included-brief / omitted
- Why It Fits ExpatGuide
- What Would Make It Better Than Generic SEO Content
- Suggested Internal Links, using only slugs from AVAILABLE INTERNAL ARTICLES

If the topic should not be normal lane, say so clearly and stop.
```

---

## Prompt 2：Research Pack

```text
HARD RULES
- no first person
- year in title
- absolute internal links only
- internal link slugs MUST appear in AVAILABLE INTERNAL ARTICLES
- banned words list applies
- use ranges for prices unless explicitly verified
- affiliate caps apply

You are preparing a RESEARCH PACK for a normal-lane ExpatGuide article.
Do not draft the article yet.

APPROVED TOPIC SHEET:
[PASTE]

AVAILABLE INTERNAL ARTICLES:
[PASTE latest internal-articles-index.md]

Requirements:
- Identify the reader questions this article must answer.
- Identify key claims.
- Separate official information from practical information where relevant.
- Do not invent laws, regulations, policies, agency names, company policies, prices, or examples.
- Every Key Claims Table row must include exactly six fields:
  - Claim
  - Source URL
  - Source Type
  - Why It Matters
  - Freshness Risk
  - Official or Practical
- If unknown, write unknown.
- Possible Internal Links must only use slugs from AVAILABLE INTERNAL ARTICLES.
- Check whether the topic has a natural affiliate fit.

Return exactly:

RESEARCH PACK

Approved Title:
Category:
Country/City:
Target Reader:
Core Search Intent:

Reader Questions To Answer:
- ...

Recommended Article Angle:
...

Suggested Outline:
- ...

Key Claims Table:
- Claim:
  Source URL:
  Source Type: official / major media / company / community / unknown
  Why It Matters:
  Freshness Risk: low / medium / high / unknown
  Official or Practical: official / practical / mixed / unknown

Known Variation Points:
- ...

Affiliate Fit Check:
- Natural fit: yes / no
- Product, if any:
- Why natural or why omitted:

Possible Internal Links:
- ...

Potential Weak Spots:
- ...

Do not draft prose paragraphs.
```

---

## Prompt 3：Validation Pack

```text
HARD RULES
- no first person
- year in title
- absolute internal links only
- banned words list applies
- use ranges for prices unless explicitly verified
- affiliate caps apply

You are the validation layer for a normal-lane ExpatGuide article.
Do not draft the article yet.

RESEARCH PACK:
[PASTE]

Validation mindset:
- Treat the research pack as if it was written by an overconfident drafter.
- Do not reward plausible wording.
- Reward only adequately supported claims.
- Default toward Yellow over Green when uncertain.
- Red claims must not enter the article.
- Gray-Area claims must preserve official and practical layers.

Return exactly:

VALIDATION PACK

Approved Title:
Category:
Country/City:

Green Claims:
- Claim:
  Why safe:
  Wording guidance:

Yellow Claims:
- Claim:
  Risk:
  Safer wording:

Red Claims:
- Claim:
  Why unsafe:
  Action: omit / re-check / mention only cautiously

Gray-Area Claims:
- Claim:
  Official position:
  Real-world variance:
  Drafting rule: state both layers explicitly / do not collapse into a single recommendation

If zero Gray-Area Claims:
Gray-Area Justification:
- ...

Open Questions:
- ...

Official-vs-Practical Distinction Notes:
- ...

Claims To Avoid Entirely:
- ...

Drafting Guidance:
- Must emphasize:
- Must phrase cautiously:
- Must avoid:

Do not write the full article.
```

---

## Prompt 4：Draft Package

```text
HARD RULES
- no first person, except "our" + internal link references and reader-perspective FAQ headings
- year in title
- absolute internal links only
- internal link slugs MUST appear in AVAILABLE INTERNAL ARTICLES
- banned words list applies
- use ranges for prices unless explicitly verified
- affiliate caps apply
- no OpenAI internal citation markers

You are writing a publish-ready normal-lane ExpatGuide article.

Inputs:

TOPIC SHEET:
[PASTE]

RESEARCH PACK:
[PASTE]

VALIDATION PACK:
[PASTE]

AVAILABLE INTERNAL ARTICLES:
[PASTE latest internal-articles-index.md]

Writing rules:
- Normal-lane priority: decision-usefulness over over-caution.
- Use Green Claims freely.
- Use Yellow Claims cautiously.
- Do not use Red Claims.
- Gray-Area Claims must show official and practical layers.
- Do not invent facts.
- Do not reveal author identity.
- Use neutral reference-site tone.
- Avoid filler, SEO-first phrasing, and AI-summary language.
- Include Decision Data Floor elements if triggered.
- Include one natural affiliate mention only if the product is a genuine answer to the reader's problem.
- All internal links must appear in AVAILABLE INTERNAL ARTICLES.

Return exactly:

DRAFT PACKAGE

# Title
...

# Meta Title
...

# Meta Description
...

# Suggested Slug
...

# Frontmatter Block
```yaml
---
title: "[full SEO title including year]"
description: "[meta description, 120-160 chars]"
sidebar:
  label: "[short, high-signal sidebar label]"
---
```

# Article
```markdown
[full markdown article, starts with first ## heading, no H1, no duplicate frontmatter]
```

# Internal Links Used
- ...

# Affiliate Mentions Used
- ...
- or none

# Source Risk Notes
- ...

# SEO/GEO Notes
- Primary search intent addressed: yes/no
- Main follow-up questions covered: yes/no
- Introduction answers core query early: yes/no
- Headings are retrieval-friendly: yes/no
- Writing avoids keyword stuffing and AI-sounding filler: yes/no

# Self-Audit
- year_in_title:
- sidebar_label_present:
- scope_completeness:
- decision_data_present:
- first_person:
- banned_words:
- affiliate_limits:
- affiliate_opportunity_check:
- absolute_internal_links_only:
- official_vs_practical_distinction:
- unsupported_claims_omitted:
- decision_usefulness:
- no_openai_citation_markers:
- markdown_format:
```

---

## Prompt 5：Issue Hunter + Patch / Final Package

```text
HARD RULES
- no first person
- year in title
- absolute internal links only
- banned words list applies
- use ranges for prices unless explicitly verified
- affiliate caps apply
- no OpenAI internal citation markers

Validation Pack confirmed. Now perform normal-lane Prompt 5.

Task:
1. Act as issue hunter for the DRAFT PACKAGE.
2. Check only material issues.
3. Create ISSUE LIST.
4. Apply minimum necessary patch.
5. Output FINAL PACKAGE.

Check:
- hard banned words and context-sensitive words
- placeholders and OpenAI citation markers
- decision-usefulness vs over-caution
- official vs practical distinction
- internal links against AVAILABLE INTERNAL ARTICLES
- first person
- affiliate caps and natural affiliate opportunity
- Scope Completeness
- Decision Data Floor
- SEO/GEO readiness:
  - primary search intent 是否在首屏回答
  - main follow-up questions 是否覆盖
  - headings 是否可被搜索/AI 检索直接理解
  - 是否包含可摘取的 decision table / checklist / rule-of-thumb
- markdown/frontmatter correctness

Patch rules:
- Minimum necessary edits only.
- Do not rewrite unaffected sections.
- Do not introduce new unsupported facts.
- Preserve valid internal links.
- Preserve useful specificity.
- Do not make affiliate language promotional.

Return exactly:

FINAL PACKAGE

# Final Frontmatter Block
```yaml
---
title: "..."
description: "..."
sidebar:
  label: "..."
---
```

# Final Article
```markdown
[full final article, starts with first ## heading]
```

# Issue List
- Issue ID:
  - Problem:
  - Severity:
  - Minimal fix:

If no material issues:
- no material issues found

# Patch Changelog
Issue ID:
- original sentence:
- changed sentence:
- change type:
- meaning changed: yes/no
- why substantive:

# Final Self-Audit
- year_in_title:
- sidebar_label_present:
- scope_completeness:
- decision_data_present:
- first_person:
- banned_words:
- affiliate_limits:
- affiliate_opportunity_check:
- absolute_internal_links_only:
- internal_links_preserved:
- official_vs_practical_distinction_preserved:
- unsupported_claims_omitted:
- decision_usefulness:
- no_openai_citation_markers:
- markdown_format:
```

---

## 最终通过标准

- 解决具体 expat 问题。
- 首段快速回答核心问题。
- 读者读完知道下一步怎么做。
- official vs practical 区分清楚。
- 没有明显 unsupported high-risk claim。
- 所有内链合法。
- frontmatter 合法。
- markdown 合法。
- 没有 OpenAI citation marker 泄漏。
- 语气像 reference page，不像 personal blog 或 AI summary。
