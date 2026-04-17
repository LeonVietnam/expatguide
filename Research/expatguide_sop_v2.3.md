# ExpatGuide 普通文章生产手册 v2.3

## v2.3 更新说明（vs v2.2）

1. 禁用词清单分为两类：**硬禁用词**（任何语境都视为 AI 味）和**语境敏感词**（在精准、合理的语境下允许使用，仅当作为填充语或抽象隐喻时禁止）
2. SOP 写作 prompts 更新，明确语境敏感词的判定原则
3. check-articles.sh v1.3 同步更新：硬禁用词报 ERROR，语境敏感词报 WARN（提示人工判断）

## v2.2 更新说明（vs v2.1）

1. 普通车道明确"decision-usefulness 优先于过度保守"——修复 v2.1 实战中 GPT 把普通文写得过度保守的问题
2. 所有涉及内链的 Prompt 加入 `AVAILABLE INTERNAL ARTICLES` 字段,GPT 不再凭空猜测内链路径
3. 强化 `absolute_internal_links_only` 的 Self-Audit,要求逐链检查是否以 `/` 开头（不能是 `http`、不能是 `[占位符]`、不能是编造 slug）
4. Prompt 5 patch 阶段加 `internal_links_preserved` 检查,防止 patch 时把好内链改坏
5. 新增"内链工作流"章节,说明 `internal-articles-index.md` 的生成与使用方式

---

## 适用范围

仅用于普通文章。

适合：FAQ、常规 guide、轻对比、低到中风险实操文、生活服务类主题。

不适合：visa、TRC、drivers license、tax、insurance、healthcare、banking、legality / compliance、高后果决策、强时效 / 强法规 / 强争议 / pillar / flagship 主题。

---

## 核心原则

1. 不依赖自动衔接
2. 每一步都由显式 prompt 触发
3. 上一步输出原样喂给下一步
4. 普通文优先帮助读者做决定，不优先追求信息尽可能完整
5. 普通车道：当 decision-usefulness 与 factual caution 冲突时，倾向 decision-usefulness。过度保守、读完仍不知道怎么做的文章，对普通车道而言是失败案例。
6. 深度车道：当 decision-usefulness 与 factual robustness 冲突时，factual robustness 优先（深度车道章节有详细规则）

---

## 全局变量（改动时同步所有 Prompt）

以下变量一旦变更，必须同步检查并更新：

- Prompt 1–5
- Deep Draft Prompt
- Claude QA Prompt

需要同步的全局变量包括：

- HARD RULES 区块
- 禁用词 / 过度 AI 味词列表
- Affiliate caps
- 内链规则
- 价格 / 数字表达规则
- first-person prohibition
- year-in-title rule

### 全局禁用词清单（分级）

清单分为两类：硬禁用词和语境敏感词。

#### 硬禁用词（任何语境都禁止）

这些词在任何语境下都是 AI 味、SEO 腔、旅行写作填充语。一旦出现必须替换。

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

#### 语境敏感词（仅特定语境允许）

这些词在精准的、本义的语境下允许使用，但作为填充语、抽象隐喻、夸张形容时禁止。

| 词 | 允许场景 | 禁止场景 |
|---|---|---|
| **leverage** | 名词，谈判 / 财务 / 筹码本义：`gives the renter leverage`、`high financial leverage` | 动词形式的填充语：`leverage your skills`、`leverage technology to...` |
| **navigate** | 实际方位 / 界面导航：`navigate the city`、`navigate to the settings page` | 抽象隐喻：`navigate the complexities of...`、`navigate the regulatory environment` |
| **landscape** | 地理景观：`the mountainous landscape of Da Nang` | 抽象比喻：`the regulatory landscape`、`the visa landscape` |
| **comprehensive** | 精确描述具体覆盖范围：`comprehensive insurance covers X, Y, Z` | 形容文章自己或宽泛的"全面"：`a comprehensive guide` |
| **robust** | 工程 / 技术语境的"稳健"：`robust encryption`、`robust internet infrastructure` | 形容计划 / 系统 / 经济等抽象事物：`a robust strategy`、`robust growth` |
| **nuanced** | 准确描述真实存在的微妙差别，且具体说明差别在哪：`The rules are nuanced — A applies to X, B applies to Y` | 作为"复杂"的高级替代词：`a nuanced situation` 后没有具体说明 |
| **crucial** | 描述真正不可或缺的客观事实：`A valid TRC is crucial for...` | 用作通用强调词：`it's crucial to note`、`crucially important` |

#### 判定原则

- 如果一个词只是为了让句子"听起来更高级"而加入，禁止使用
- 如果一个词承担了具体语义（特别是名词本义），允许使用
- 拿不定主意时，问：替换成更平实的词后意思是否完全等价？如果是，原词是填充语；如果有损失，原词是承担语义的精准用词

#### 全局规则

- 草稿中如果出现硬禁用词，默认改成更平实、更自然的表达，不因为"看起来高级"而保留
- 草稿中如果出现语境敏感词，必须确认其使用属于"允许场景"才能保留
- 禁用词过滤同时适用于旅行腔、SEO 腔、常见 GPT 腔

---

## 站点固定规则

- 标题必须带年份
- 内链必须绝对路径（以 `/` 开头），不能是 `http://` 开头的完整 URL，不能是 `[DOMAIN]` 占位符，不能是编造的 slug
- 第一人称规则（见下方详细说明）
- 不暴露工作流和身份
- 禁用词必须过滤
- 房租 / 费用尽量用区间
- SafetyWing / Wise 各最多自然提及一次
- World Nomads 不与 SafetyWing 同句
- 数据来源用 italic 小字标注
- 语气必须是 neutral, practical, reference-style

### 第一人称规则详细说明

**禁止（作者第一人称）:**
- I / my / me / we 用于表达个人经历、个人观点、个人推荐
- 例如:"I moved to Vietnam in 2019"、"we recommend this restaurant"、"in my experience"
- 任何会暴露作者身份或让文章读起来像个人博客的表述

**允许（站点编辑语气）:**
- "our" + 站内文章引用,例如:"see our [Banking Guide](/...)"、"our [motorbike guide](/...) covers..."
- 这属于站点编辑语气,不是个人博客语气,且有助于阅读流畅性

**允许（读者视角 FAQ 标题）:**
- FAQ 小标题使用读者第一人称,例如:"Can I convert my license?"、"What if my landlord refuses?"
- 这是搜索意图匹配,不是作者第一人称

判定原则:问"这句话读起来是某个人在说话,还是一个参考站点在引导读者?" 如果是后者,允许。

---

## 内链工作流（v2.2 新增）

### 背景

GPT 不知道你站点上有哪些文章。如果让它凭空猜内链，会出现：

- 用 `[EXPATGUIDE_DOMAIN]` 这种占位符
- 编造不存在的 slug
- 完全不加内链，导致孤立页面增多

### 解决方案

维护一份 `Research/internal-articles-index.md` 文件，列出站内所有文章的 slug 和一句话描述。每次进入 Step 2 / Step 4 时，把这份清单的内容粘贴到 `AVAILABLE INTERNAL ARTICLES` 字段中。

### 清单生成方式

项目根目录运行：

```bash
bash generate-link-index.sh
```

脚本会扫描 `src/content/docs/vietnam/` 下所有 md / mdx 文件，从 frontmatter 自动提取 slug + description，生成最新清单。

### 清单更新时机

- 每次新发布文章后跑一次脚本
- 把更新后的 `internal-articles-index.md` 上传到 ChatGPT 的 ExpatGuide 项目知识里（覆盖旧版本）

### 内链格式硬规则

- 必须以 `/` 开头（绝对路径）
- 不能是 `https://...`（外部 URL 形式）
- 不能是 `[EXPATGUIDE_DOMAIN]/...` 或任何占位符
- 必须对应清单中存在的 slug，不能编造

### Sitemap 兜底

如果你忘了更新清单，GPT 5.4 Thinking 也可以读 `https://expatguide.site/sitemap.xml` 验证某个 slug 是否存在。但不要依赖兜底——主要工作流是清单。

---

## 普通链路总览

1. Prompt 1 → TOPIC SHEET
2. Prompt 2 → RESEARCH PACK
3. Prompt 3 → VALIDATION PACK
4. Prompt 4 → DRAFT PACKAGE
5. Prompt 5 → FINAL PACKAGE

## 深度链路总览

1. Prompt 1 → TOPIC SHEET
2. Prompt 2 → RESEARCH PACK（执行更严）
3. Prompt 3 → VALIDATION PACK（执行更严）
4. Deep Draft Prompt → DRAFT PACKAGE
4.5. Claude QA Prompt → CLAUDE QA ISSUE LIST
5. Prompt 5 → FINAL PACKAGE（吃 Claude ISSUE LIST + bash errors）

---

## Step 1：选题

输入：Prompt 1
输出：TOPIC SHEET
要求：具体 expat 问题；符合 reference-site 定位；适合普通车道；不需要大规模法规裁决。
你的动作：只做人工审核和拍板。

### 选题分流硬规则

如果出现以下任一情况，不再留在普通车道，直接进入深度车道：

- Topic Sheet 中 `Execution Risk = high`
- `Need Official-vs-Practical Distinction = yes`，且主题涉及：
  - visa
  - residency / TRC
  - tax
  - insurance
  - healthcare
  - legality / compliance
  - banking
  - 其他高后果 expat 决策

规则：

- high 就是 deep
- 不存在"先用普通车道试试看"的中间地带
- 不允许为了效率把高风险题强行留在普通车道

---

## Step 2：调研

输入：TOPIC SHEET + AVAILABLE INTERNAL ARTICLES
输出：RESEARCH PACK
要求：明确核心问题、文章角度、结构、关键 claims、来源类型、变化点、薄弱点、可用内链。

### 结构完整性硬规则

Key Claims Table 的每一行都必须包含以下 6 个字段：

- Claim
- Source URL
- Source Type
- Why It Matters
- Freshness Risk
- Official or Practical

如果某一项未知，必须写 `unknown`，不能省略字段。

### 内链使用硬规则

- Possible Internal Links 只能使用 AVAILABLE INTERNAL ARTICLES 中列出的 slug
- 不允许编造不存在的 slug
- 不允许使用 `[DOMAIN]` 这类占位符

---

## Step 3：验证

输入：RESEARCH PACK
输出：VALIDATION PACK
要求：产出 Green / Yellow / Red / Gray-Area / Open questions，并明确 official vs practical distinction。
硬规则：

- Green 可用
- Yellow 保守写
- Red 不进正文
- Gray-Area 必须明确写出 paper vs practice 或 rule vs enforcement 的差异
- Open questions 不补成结论
- 如果返回 0 条 Gray-Area Claims，必须简短说明为什么本主题不存在 rule-vs-enforcement 或 paper-vs-practice 差异

### 验证心态硬规则

Validation 不是给前一步"顺利放行"，而是主动找问题。

- 把 RESEARCH PACK 当成一个过度自信的初级研究员写的
- 默认不奖励"看起来合理"的措辞
- 只奖励真正被支持的 claim
- 有疑问时默认更偏 Yellow，而不是为了方便标 Green
- 如果你发现自己想为了推进流程而把某条 claim 判成 Green，这通常说明它更应该是 Yellow

---

## Step 4：初稿

输入：TOPIC SHEET + RESEARCH PACK + VALIDATION PACK + AVAILABLE INTERNAL ARTICLES
输出：DRAFT PACKAGE
目标：准确、像 ExpatGuide、像人写的、SEO / GEO 友好。

硬规则：

- **普通车道核心权衡：decision-usefulness 优先于过度保守**
- 避免塞入过多高波动信息，除非它对核心决策必不可少
- 但不能因为"信息可能会变"而省略对读者决策关键的具体建议——过度保守、读者读完仍不知道怎么做的文章是失败案例
- 只自由使用 Green Claims
- Yellow Claims 只能保守使用
- Red Claims 不进正文
- Gray-Area Claims 必须 official 与 practical 两层都写出来，不允许压成单一推荐
- 首段尽快回答核心问题
- 小标题匹配真实搜索问题或决策点
- 保持自然，不要写成 SEO-first 或 AI-summary 文
- 内链只能使用 AVAILABLE INTERNAL ARTICLES 中的 slug
- 合格线：70–80 分即可，能进入 patch 即可

---

## Step 5：Patch / 终稿

输入：DRAFT ARTICLE + ISSUE LIST
输出：FINAL PACKAGE

ISSUE LIST 分两类：

- SCRIPT ISSUES：禁用词、affiliate 次数、内链格式、标题年份、markdown、字数等
- EDITORIAL ISSUES：首段不够快、小标题不清楚、AI 味、表述过度确定、SEO/GEO 不够强、信息过满

硬规则：

- 只做最小必要修改
- 不重写没问题的段落
- 不引入新事实
- 不为了 SEO 再塞新内容
- 不为了"完整"重新变长
- Prioritize decision-usefulness over completeness
- Patch Changelog 必须逐 issue 映射，不允许笼统写 "improved clarity"
- Patch 后必须再次确认 official vs practical 区分没有被压平
- **Patch 不得破坏原本有效的内链结构**（v2.2 新增）

### Self-Audit 硬规则

Self-Audit 不能只写 pass/fail，必须带证据。

至少要做到：

- banned_words：如果 pass，给 3 个 spot-check，且必须挑 GPT 自己最容易写出来的词（如 delve / leverage / robust / comprehensive / navigate / nuanced / foster / streamline）；如果 fail，列出触发词和句子
- year_in_title：引用完整标题
- first_person：如果 pass，引用 2 句随机句子证明仍是 publication voice
- affiliate_limits：按品牌计数
- **absolute_internal_links_only（v2.2 强化）**：逐链列出，每一条必须以 `/` 开头；不允许出现 `http://`、`[占位符]`、以及清单里不存在的 slug
- **internal_links_preserved（v2.2 新增，仅 Prompt 5）**：列出 patch 前后的内链对照，确认没有破坏原本有效的链接格式
- official_vs_practical_distinction_preserved：引用 1–2 句证明 patch 后仍然保留区分
- unsupported specific numbers：列出所有价格 / 时效 / 数量类表述，并标记 verified / range / unsupported

---

## 最终通过标准

- 解决的是具体 expat 问题
- 首段尽快回答核心问题
- official vs practical 区分清楚
- 没有明显高风险未验证 claim
- 所有内链格式合法（以 `/` 开头，slug 存在于清单中）
- Markdown 合规
- 写作规范合规
- SEO/GEO 友好但不显得 SEO-first
- 读起来像参考页，不像 AI 内容，也不像 blog

---

## 不该使用普通车道的情况

涉及 law / visa / residency / permit / TRC / license / tax / insurance / healthcare / banking / legality / compliance；需要处理多个官方来源冲突；需要处理重大生效日；需要处理 enforcement gray area；写错会明显伤害可信度；准备做 pillar / flagship。

---

## 深度文章车道（补充版）

### 结论

大部分框架一致，但**不完全相同**。

### 一致的部分

- Step 1 选题：逻辑一致
- Step 2 调研：逻辑一致
- Step 3 验证：逻辑一致，但深度文要更严格
- 站点固定规则：一致
- SEO / GEO 目标：一致
- Patch 的基本原则：一致
- 内链工作流：一致（都使用 AVAILABLE INTERNAL ARTICLES 清单）

### 不一致的部分

1. **进入条件更严格**
   深度文默认用于高法规风险、高时效、高争议、高价值、旗舰型主题。

2. **Step 2 / Step 3 要更重事实和时效**
   深度文的调研和验证必须更重：
   - 生效日期
   - 适用对象
   - 官方来源优先级
   - 多来源冲突
   - enforcement gray area

3. **Step 4 不建议直接一把梭成稿**
   深度文更稳的写法是先产出更重的 Research / Fact Map，再基于验证结果写初稿。

4. **多一个 Claude 二审步骤**
   深度文链路是：Prompt 1 → Prompt 2 → Prompt 3 → Deep Draft Prompt → Claude QA Prompt → Prompt 5

5. **Step 5 的 patch 会更依赖 Claude 问题单**

### 深度车道优先级规则

当 deep-lane 文章里，`decision-usefulness` 与 `factual robustness` 发生冲突时：

- factual robustness 优先
- 即使会让段落更长，也要保留真实存在的法规 / 条件 / 适用范围 / 生效条件
- 不为了顺滑、简短、好读，就把真正存在的限制条件压掉

**注意：这与普通车道相反。普通车道 decision-usefulness 优先，深度车道 factual robustness 优先。分流判断见 Step 1。**

---

## Deep Draft Prompt（深度文章专用）

```text
HARD RULES
- no first person (exception: "our" + internal link references, and reader-perspective FAQ headings like "Can I..." are allowed)
- year in title
- absolute internal links only (must start with "/", not "http", not "[" placeholder)
- internal link slugs MUST appear in AVAILABLE INTERNAL ARTICLES
- banned words list applies
- use ranges for prices unless explicitly verified
- affiliate caps apply

You are writing a publish-ready markdown draft for a high-risk ExpatGuide article.

About the site:
- ExpatGuide is a community-sourced reference site for expats
- It is not a personal blog
- It must remain anonymous
- It should help readers solve a concrete problem and leave
- It should distinguish official rules from practical execution when needed

Inputs:

TOPIC SHEET:
[PASTE APPROVED TOPIC SHEET]

RESEARCH PACK:
[PASTE FULL RESEARCH PACK]

VALIDATION PACK:
[PASTE FULL VALIDATION PACK]

AVAILABLE INTERNAL ARTICLES:
[PASTE CONTENTS OF Research/internal-articles-index.md]

Writing rules:
- Title must include year
- All internal links must start with "/" (absolute path); no external URLs for internal references, no placeholders like [DOMAIN]
- All internal link slugs MUST appear in AVAILABLE INTERNAL ARTICLES; never invent slugs
- No first person (exception: "our" + internal link references, and reader-perspective FAQ headings like "Can I..." are allowed)
- No self-referential writing
- No identity reveal
- Tone must be neutral, practical, and reference-style
- Do not write like a lifestyle blog
- If cost/rent/price data varies, use ranges rather than one precise number
- Data source notes should be shown in italic small-text style
- Distinguish official information from practical/on-the-ground variation when needed

Banned words and phrases (HARD — never use in any context):
- vibrant, bustling, hidden gem, melting pot, charming, nestled, epicenter
- In conclusion, Let's dive in, It's important to note
- straightforward, paradise, dream, tropical haven
- delve, tapestry, ever-evolving, seamless, holistic, intricate, multifaceted
- underscore, pivotal, foster, empower, streamline, tailored
- in today's world, in today's fast-paced environment, whether you are
- it is worth noting, plays a key role, serves as a cornerstone

Context-sensitive words (allowed only in specific senses):
- leverage — ALLOW as noun (negotiation/financial leverage). BAN as verb filler ("leverage X to Y")
- navigate — ALLOW for actual physical/UI navigation. BAN as abstract metaphor ("navigate complexities")
- landscape — ALLOW for geographic landscape. BAN as abstract ("regulatory landscape")
- comprehensive — ALLOW for precise scope ("comprehensive insurance covers X, Y, Z"). BAN as vague self-praise ("a comprehensive guide")
- robust — ALLOW for engineering/technical (encryption, infrastructure). BAN for abstract systems ("robust strategy")
- nuanced — ALLOW only when followed by specific differentiation ("nuanced — A applies to X, B applies to Y"). BAN as standalone descriptor
- crucial — ALLOW for true objective necessity ("a valid TRC is crucial for X"). BAN as generic emphasis ("it's crucial to note")

Rule for banned wording:
- Hard-banned words: replace with plainer wording, no exceptions
- Context-sensitive words: keep ONLY if usage matches the ALLOW description above
- When in doubt, ask: would a plainer substitute lose specific meaning? If no, the word is filler — replace it

Affiliate rules:
- SafetyWing can appear at most once, naturally
- Wise can appear at most once, naturally
- World Nomads must not appear in the same sentence as SafetyWing
- If there is no natural fit, omit affiliate mentions
- Do not force affiliate placement

Deep-article drafting rules:
- Prioritize factual robustness over speed
- Use Green Claims freely
- Use Yellow Claims only with cautious wording
- Do not use Red Claims as factual statements
- Gray-Area Claims must be written with both layers explicit (official position + real-world variance). Do not collapse them into a single recommendation.
- Omit unsupported claims
- Never fabricate a source, regulation, company policy, or anecdote
- When official rules and real-world practice diverge, state the difference clearly
- When scope, eligibility, effective dates, or enforcement vary, surface those conditions explicitly
- Do not flatten gray areas into certainty
- Keep wording precise and non-dramatic
- Prefer practical clarity over flourish
- Avoid generic filler, scene-setting fluff, and empty transitions
- Write like a strong human editor, not like an AI summarizer
- Vary sentence length naturally
- Do not use repetitive "expat-friendly" filler language
- Do not pad sections just to make them longer
- When decision-usefulness and factual robustness conflict in this deep-lane article, factual robustness wins
- Err on the side of including the legal, regulatory, procedural, or eligibility condition even if it makes the section longer

SEO / GEO requirements:
- Satisfy the primary search intent clearly and early
- Cover the most likely follow-up questions naturally within the article
- Make section headings specific, useful, and retrieval-friendly
- Answer the core question directly in the introduction
- Include concise, extractable summary sentences where helpful
- Make the article easy for search engines and AI systems to interpret, quote, and summarize
- Optimize for usefulness, clarity, and retrievability without sounding robotic or over-optimized
- Avoid keyword stuffing
- Avoid obvious "SEO article" or "AI-generated summary" phrasing
- Structure the article so that both humans and AI search systems can quickly identify:
  - the main answer
  - the key caveats
  - the practical decision points
  - the legal / policy conditions
- Use headings that match real user questions or decision points
- Where useful, front-load the answer before nuance

Markdown requirements:
- Output valid markdown
- Use clear heading hierarchy
- Use bullet points only when they genuinely improve clarity
- Do not over-list everything
- Keep formatting clean and publication-ready

FINAL HARD RULES CHECK BEFORE WRITING
- no first person (with stated exceptions)
- year in title
- all internal links start with "/" and use only AVAILABLE slugs
- banned words list still applies
- use ranges for prices unless explicitly verified
- affiliate caps still apply

Return exactly this format:

DRAFT PACKAGE

# Title
...

# Meta Title
...

# Meta Description
...

# Suggested Slug
...

# Article
[full markdown article]

# Internal Links Used
- ...
- ...

# Affiliate Mentions Used
- ...
- or "none"

# Source Risk Notes
- ...
- ...

# SEO/GEO Notes
- Primary search intent addressed: yes/no
- Main follow-up questions covered: yes/no
- Introduction answers the core query early: yes/no
- Headings are search-clear and retrieval-friendly: yes/no
- Article includes extractable summary lines where helpful: yes/no
- Writing avoids keyword stuffing and AI-sounding filler: yes/no

# Self-Audit (evidence required)
- year_in_title: pass/fail
  - Title quoted: ...
- first_person: pass/fail
  - If pass, cite 2 random sentences showing publication voice:
  - If fail, quote every first-person instance:
- banned_words: pass/fail
  - If pass, provide 3 spot-checks, prioritizing words MOST likely to have slipped in (e.g. delve, leverage, robust, comprehensive, navigate, nuanced, foster, streamline):
    - "word X" — not found
    - "word Y" — not found
    - "word Z" — not found
  - If fail, list each banned word found and quote the sentence:
- affiliate_limits: pass/fail
  - Count: SafetyWing = X, Wise = Y, World Nomads = Z, others = ...
- absolute_internal_links_only: pass/fail
  - List EVERY internal link used, and for each one confirm:
    - starts with "/" (not "http", not "[")
    - slug exists in AVAILABLE INTERNAL ARTICLES
  - Example format:
    - "/vietnam/visa/visa-guide-2026" — starts with / ✓ — in index ✓
    - "/vietnam/housing/avoid-rental-scams-vietnam-2026" — starts with / ✓ — in index ✓
- official_vs_practical_distinction: pass/fail
  - Quote 1–2 lines where the distinction is surfaced:
- unsupported_claims_omitted: pass/fail
  - List all time-sensitive prices / fees / wait times / validity periods / speeds / other volatile numbers and mark each as verified / range / unsupported
- markdown_format: pass/fail
```

---

## Claude QA Prompt（深度文章专用）

```text
HARD RULES
- no first person (exception: "our" + internal link references, and reader-perspective FAQ headings, are allowed)
- year in title
- absolute internal links only
- banned words list applies
- use ranges for prices unless explicitly verified
- affiliate caps apply

You are the final editorial QA pass for a high-risk ExpatGuide article.

Do not redo the full research.
Do not rewrite the whole article.
Do not introduce new unsupported facts.

About the site:
- ExpatGuide is a neutral reference site for expats
- It is not a personal blog
- It must remain anonymous
- It should distinguish official rules from practical execution when needed

Inputs:

TOPIC SHEET:
[PASTE APPROVED TOPIC SHEET]

RESEARCH PACK:
[PASTE FULL RESEARCH PACK]

VALIDATION PACK:
[PASTE FULL VALIDATION PACK]

DRAFT PACKAGE:
[PASTE FULL DRAFT PACKAGE OR ARTICLE]

Your job:
Review only for real issues in these categories:
1. factual overstatement
2. misleading or over-confident phrasing
3. official-rule vs practical-execution confusion
4. eligibility / scope / effective-date ambiguity
5. awkward affiliate placement
6. mismatch with neutral reference-site tone
7. broken or invalid internal links (placeholder URLs, invented slugs, non-absolute paths)

Rules:
- Only flag issues that matter
- Do not suggest stylistic rewrites unless they reduce factual or editorial risk
- Do not replace precise wording with generic wording
- Preserve the article's usefulness and specificity
- Treat gray areas as gray, not green

Return exactly this format:

CLAUDE QA ISSUE LIST

Issue:
- Issue ID:
- Quote:
- Category:
- Why risky:
- Minimal fix:

Issue:
- Issue ID:
- Quote:
- Category:
- Why risky:
- Minimal fix:

If there are no real issues, return:
CLAUDE QA ISSUE LIST
- no material issues found
```

---

## Prompt 1：Topic Proposal

```text
HARD RULES
- no first person (exception: "our" + internal link references, and reader-perspective FAQ headings, are allowed)
- year in title
- absolute internal links only
- banned words list applies
- use ranges for prices unless explicitly verified
- affiliate caps apply

You are helping plan editorial topics for ExpatGuide.

About the site:
- ExpatGuide is a community-sourced reference site for expats
- It is not a personal blog
- It must remain anonymous
- Good content helps readers solve concrete expat problems and leave
- Strong articles often distinguish:
  1) what official rules say
  2) how things are actually executed on the ground

Task:
Generate topic proposals for the scope below.

Scope:
[PASTE COUNTRY / CITY / CATEGORY / BOARD]

Goal:
[PASTE YOUR GOAL, e.g. find 10 normal-article candidates, fill Daily Life backlog, prioritize practical low-risk topics]

AVAILABLE INTERNAL ARTICLES:
[PASTE CONTENTS OF Research/internal-articles-index.md]

Constraints:
- Prefer concrete problem-solving topics
- Avoid personal-blog-style ideas
- Avoid social-media-first topics
- Avoid topics that depend on identity reveal
- Avoid topics that overlap too much with articles already in AVAILABLE INTERNAL ARTICLES
- Do not invent search volume numbers
- Do not invent laws, decrees, regulations, or policies
- For normal articles, prefer topics that are practical and suitable for efficient production

Routing rule:
- If Execution Risk = high, the topic must go to the deep lane
- If Need Official-vs-Practical Distinction = yes and the topic involves visas, residency, TRC, tax, insurance, healthcare, legality, compliance, banking, or another high-consequence expat decision, the topic must go to the deep lane
- No middle state; do not keep such topics in the normal lane for convenience

Return exactly this format for each proposal:

TOPIC SHEET
Title:
Category:
Country/City:
Article Type: normal
Target Reader:
Core Search Intent:
Why This Topic Matters:
Need Official-vs-Practical Distinction: yes / no
Execution Risk: low / medium / high
Why It Fits ExpatGuide:
What Would Make It Better Than Generic SEO Content:
Suggested Internal Links (must use only slugs from AVAILABLE INTERNAL ARTICLES):
- ...
- ...

At the end, include:
1. Best 5 fast-production topics
2. Best 5 high-value topics
3. Best 5 safest low-risk topics
```

---

## Prompt 2：Research Pack

```text
HARD RULES
- no first person (exception: "our" + internal link references, and reader-perspective FAQ headings, are allowed)
- year in title
- absolute internal links only (must start with "/", not "http", not "[" placeholder)
- internal link slugs MUST appear in AVAILABLE INTERNAL ARTICLES
- banned words list applies
- use ranges for prices unless explicitly verified
- affiliate caps apply

You are preparing a research pack for a normal ExpatGuide article.

About the site:
- ExpatGuide is a neutral reference site for expats
- It is not a personal blog
- It must remain anonymous
- Content should help readers solve concrete expat problems
- It should distinguish official information from real-world execution when needed

Task:
Build a research pack for the approved topic below.
Do not draft the article yet.

APPROVED TOPIC SHEET:
[PASTE ONE SELECTED TOPIC SHEET]

AVAILABLE INTERNAL ARTICLES:
[PASTE CONTENTS OF Research/internal-articles-index.md]

Requirements:
- Identify the main user questions this article must answer
- Identify the main claims the article would need
- Separate official information from practical/on-the-ground information where relevant
- Be careful with stale, unsupported, or anecdotal claims
- Do not invent laws, regulations, case examples, dates, agencies, or provider claims
- If pricing/costs vary, treat them cautiously
- Every row in the Key Claims Table must include all six fields:
  - Claim
  - Source URL
  - Source Type
  - Why It Matters
  - Freshness Risk
  - Official or Practical
- If any field is unknown, write "unknown"
- Do not omit any field
- For "Possible Internal Links": ONLY use slugs that appear in AVAILABLE INTERNAL ARTICLES above
- Do not invent slugs; do not use placeholders like [DOMAIN] or [TBD]
- All internal links must start with "/" (absolute path)

Return exactly this format:

RESEARCH PACK

Approved Title:
Category:
Country/City:
Target Reader:
Core Search Intent:

Reader Questions To Answer:
- ...
- ...
- ...

Recommended Article Angle:
...

Suggested Outline:
- ...
- ...
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
- ...

Possible Internal Links (must match slugs in AVAILABLE INTERNAL ARTICLES):
- ...
- ...

Potential Weak Spots:
- ...
- ...

Do not draft prose paragraphs.
Do not write the final article.
```

---

## Prompt 3：Validation Pack

```text
HARD RULES
- no first person (exception: "our" + internal link references, and reader-perspective FAQ headings, are allowed)
- year in title
- absolute internal links only
- banned words list applies
- use ranges for prices unless explicitly verified
- affiliate caps apply

You are the validation layer for a normal ExpatGuide article.

Task:
Audit the research pack below and classify the important claims.
Do not draft the final article yet.

RESEARCH PACK:
[PASTE FULL RESEARCH PACK]

Validation rules:
- Adversarial mindset required
- Treat the research pack as if it was written by an overconfident drafter
- Do not reward plausible wording; reward only adequately supported claims
- Default-bias toward Yellow over Green when in doubt
- If you find yourself wanting to mark something Green out of convenience, that is a signal to mark it Yellow
- Your job is not to preserve draft momentum; your job is to catch overclaiming before Step 4
- Be conservative
- If a claim is weak, mark it clearly
- Distinguish official information from practical experience
- Do not overstate anecdotal reports as universal truth
- Watch for:
  - stale dates
  - outdated agencies
  - outdated administrative divisions
  - unsupported pricing claims
  - company marketing claims presented as fact
  - practical variation presented too confidently

Gray-Area completeness rule:
- Actively look for claims where the official rule and the on-the-ground execution diverge
- If you return zero Gray-Area Claims, briefly justify why no claim in this topic involves rule-vs-enforcement or paper-vs-practice divergence

Return exactly this format:

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

(If zero Gray-Area Claims:)
Gray-Area Justification:
- Why this topic does not involve rule-vs-enforcement or paper-vs-practice divergence:

Open Questions:
- ...
- ...

Official-vs-Practical Distinction Notes:
- ...
- ...

Claims To Avoid Entirely:
- ...
- ...

Drafting Guidance:
- Must emphasize:
  - ...
- Must phrase cautiously:
  - ...
- Must avoid:
  - ...

Do not write the full article.
```

---

## Prompt 4：Draft + SEO/GEO Enhanced（普通车道）

```text
HARD RULES
- no first person (exception: "our" + internal link references, and reader-perspective FAQ headings like "Can I..." are allowed)
- year in title
- absolute internal links only (must start with "/", not "http", not "[" placeholder)
- internal link slugs MUST appear in AVAILABLE INTERNAL ARTICLES
- banned words list applies
- use ranges for prices unless explicitly verified
- affiliate caps apply

You are writing a publish-ready markdown draft for ExpatGuide.

About the site:
- ExpatGuide is a community-sourced reference site for expats
- It is not a personal blog
- It must remain anonymous
- It should help readers solve a concrete problem and leave
- It should distinguish official rules from practical execution when needed

Inputs:

TOPIC SHEET:
[PASTE APPROVED TOPIC SHEET]

RESEARCH PACK:
[PASTE FULL RESEARCH PACK]

VALIDATION PACK:
[PASTE FULL VALIDATION PACK]

AVAILABLE INTERNAL ARTICLES:
[PASTE CONTENTS OF Research/internal-articles-index.md]

Writing rules:
- Title must include year
- All internal links must start with "/" (absolute path); no external URLs for internal references, no placeholders like [DOMAIN]
- All internal link slugs MUST appear in AVAILABLE INTERNAL ARTICLES; never invent slugs
- No first person (exception: "our" + internal link references, and reader-perspective FAQ headings like "Can I..." are allowed)
- No self-referential writing
- No identity reveal
- Tone must be neutral, practical, and reference-style
- Do not write like a lifestyle blog
- If cost/rent/price data varies, use ranges rather than one precise number
- Data source notes should be shown in italic small-text style
- Distinguish official information from practical/on-the-ground variation when needed

Banned words and phrases (HARD — never use in any context):
- vibrant, bustling, hidden gem, melting pot, charming, nestled, epicenter
- In conclusion, Let's dive in, It's important to note
- straightforward, paradise, dream, tropical haven
- delve, tapestry, ever-evolving, seamless, holistic, intricate, multifaceted
- underscore, pivotal, foster, empower, streamline, tailored
- in today's world, in today's fast-paced environment, whether you are
- it is worth noting, plays a key role, serves as a cornerstone

Context-sensitive words (allowed only in specific senses):
- leverage — ALLOW as noun (negotiation/financial leverage). BAN as verb filler ("leverage X to Y")
- navigate — ALLOW for actual physical/UI navigation. BAN as abstract metaphor ("navigate complexities")
- landscape — ALLOW for geographic landscape. BAN as abstract ("regulatory landscape")
- comprehensive — ALLOW for precise scope ("comprehensive insurance covers X, Y, Z"). BAN as vague self-praise ("a comprehensive guide")
- robust — ALLOW for engineering/technical (encryption, infrastructure). BAN for abstract systems ("robust strategy")
- nuanced — ALLOW only when followed by specific differentiation ("nuanced — A applies to X, B applies to Y"). BAN as standalone descriptor
- crucial — ALLOW for true objective necessity ("a valid TRC is crucial for X"). BAN as generic emphasis ("it's crucial to note")

Rule for banned wording:
- Hard-banned words: replace with plainer wording, no exceptions
- Context-sensitive words: keep ONLY if usage matches the ALLOW description above
- When in doubt, ask: would a plainer substitute lose specific meaning? If no, the word is filler — replace it

Affiliate rules:
- SafetyWing can appear at most once, naturally
- Wise can appear at most once, naturally
- World Nomads must not appear in the same sentence as SafetyWing
- If there is no natural fit, omit affiliate mentions
- Do not force affiliate placement

Drafting rules (normal lane):
- Use Green Claims freely
- Use Yellow Claims only with cautious wording
- Do not use Red Claims unless clearly marked as uncertain and truly necessary
- Gray-Area Claims must be written with both layers explicit (official position + real-world variance). Do not collapse them into a single recommendation.
- Omit unsupported claims
- Never fabricate a source, regulation, company policy, or anecdote
- Keep wording precise and non-dramatic
- Prefer practical clarity over flourish
- Avoid generic filler, scene-setting fluff, and empty transitions
- Write like a strong human editor, not like an AI summarizer
- Vary sentence length naturally
- Do not use repetitive "expat-friendly" filler language
- Do not pad sections just to make them longer
- **Normal-lane priority: decision-usefulness over exhaustive caution**
- For normal articles, when decision-usefulness and factual caution conflict, lean toward decision-usefulness
- Over-caution that leaves the reader unable to act is a failure mode for normal-lane articles
- Keep volatile details (pricing, specific regulations) out unless they are essential — but do not strip the article of actionable specificity

SEO / GEO requirements:
- Satisfy the primary search intent clearly and early
- Cover the most likely follow-up questions naturally within the article
- Make section headings specific, useful, and retrieval-friendly
- Answer the core question directly in the introduction
- Include concise, extractable summary sentences where helpful
- Make the article easy for search engines and AI systems to interpret, quote, and summarize
- Optimize for usefulness, clarity, and retrievability without sounding robotic or over-optimized
- Avoid keyword stuffing
- Avoid obvious "SEO article" or "AI-generated summary" phrasing
- Structure the article so that both humans and AI search systems can quickly identify:
  - the main answer
  - the key caveats
  - the practical decision points
- Use headings that match real user questions or decision points
- Where useful, front-load the answer before nuance
- Where official rules and real-world practice differ, state that difference clearly

Markdown requirements:
- Output valid markdown
- Use clear heading hierarchy
- Use bullet points only when they genuinely improve clarity
- Do not over-list everything
- Keep formatting clean and publication-ready

FINAL HARD RULES CHECK BEFORE WRITING
- no first person (with stated exceptions)
- year in title
- all internal links start with "/" and use only AVAILABLE slugs
- banned words list still applies
- use ranges for prices unless explicitly verified
- affiliate caps still apply
- decision-usefulness over over-caution

Return exactly this format:

DRAFT PACKAGE

# Title
...

# Meta Title
...

# Meta Description
...

# Suggested Slug
...

# Article
[full markdown article]

# Internal Links Used
- ...
- ...

# Affiliate Mentions Used
- ...
- or "none"

# Source Risk Notes
- ...
- ...

# SEO/GEO Notes
- Primary search intent addressed: yes/no
- Main follow-up questions covered: yes/no
- Introduction answers the core query early: yes/no
- Headings are search-clear and retrieval-friendly: yes/no
- Article includes extractable summary lines where helpful: yes/no
- Writing avoids keyword stuffing and AI-sounding filler: yes/no

# Self-Audit (evidence required)
- year_in_title: pass/fail
  - Title quoted: ...
- first_person: pass/fail
  - If pass, cite 2 random sentences showing publication voice:
  - If fail, quote every first-person instance:
- banned_words: pass/fail
  - If pass, provide 3 spot-checks, prioritizing words MOST likely to have slipped in (e.g. delve, leverage, robust, comprehensive, navigate, nuanced, foster, streamline):
    - "word X" — not found
    - "word Y" — not found
    - "word Z" — not found
  - If fail, list each banned word found and quote the sentence:
- affiliate_limits: pass/fail
  - Count: SafetyWing = X, Wise = Y, World Nomads = Z, others = ...
- absolute_internal_links_only: pass/fail
  - List EVERY internal link used, and for each one confirm:
    - starts with "/" (not "http", not "[")
    - slug exists in AVAILABLE INTERNAL ARTICLES
  - Example format:
    - "/vietnam/visa/visa-guide-2026" — starts with / ✓ — in index ✓
- official_vs_practical_distinction: pass/fail
  - Quote 1–2 lines where the distinction is surfaced:
- unsupported_claims_omitted: pass/fail
  - List all time-sensitive prices / fees / wait times / validity periods / speeds / other volatile numbers and mark each as verified / range / unsupported
- decision_usefulness: pass/fail
  - Confirm: a reader finishing this article knows what to do next
  - If fail, identify where the article gets too cautious to be useful
- markdown_format: pass/fail
```

---

## Prompt 5：Patch + Final SEO/GEO Pass

```text
HARD RULES
- no first person (exception: "our" + internal link references, and reader-perspective FAQ headings, are allowed)
- year in title
- absolute internal links only (must start with "/", not "http", not "[" placeholder)
- banned words list applies
- use ranges for prices unless explicitly verified
- affiliate caps apply

You are patching and finalizing an ExpatGuide markdown article.

Task:
Patch the draft below based only on the issue list.
Make the minimum necessary edits.
Do not rewrite unaffected sections.
Do not introduce new unsupported facts.
Do not break existing valid internal links.

DRAFT ARTICLE:
[PASTE ARTICLE ONLY]

ISSUE LIST:
[PASTE BASH ERRORS OR MANUAL ISSUE LIST]

AVAILABLE INTERNAL ARTICLES:
[PASTE CONTENTS OF Research/internal-articles-index.md]

Rules:
- Preserve the structure unless a listed issue requires structural change
- Preserve internal links unless a listed issue requires change
- Preserve affiliate placement unless a listed issue requires change
- Do not add new unsupported claims
- Keep the article in markdown
- Keep the title with year
- Keep tone neutral and reference-style
- No first person (with stated exceptions)
- No banned words
- All internal links must start with "/" and use AVAILABLE INTERNAL ARTICLES slugs
- Keep the article natural, useful, and publication-ready
- Do not introduce SEO filler
- Do not make the article sound robotic
- Do not over-compress useful nuance
- Do not replace specific practical guidance with generic summaries
- Prioritize decision-usefulness over completeness
- After patching, the official vs practical distinction must remain visible. Do not flatten it.
- **Do not break working markdown link syntax during patching** (v2.2 hard rule)

Final SEO / GEO pass:
- Improve the introduction if the main answer comes too late
- Tighten section headings if they are vague or generic
- Remove filler that weakens search usefulness
- Improve retrieval-friendliness for AI systems where possible
- Add or sharpen concise summary lines only when they genuinely improve clarity
- Preserve human readability and editorial quality
- Do not add keyword stuffing
- Do not make the article sound templated or over-optimized
- Check that the article clearly serves:
  - the main search intent
  - the key follow-up questions
  - AI-search extractability
- Check that the article still reads like a strong human-written reference page
- Prefer precision and usefulness over "content marketing" language

Final quality bar:
- The article should feel publish-ready
- It should not feel like an SEO-first article
- It should not feel like an AI-generated article
- It should be easy to scan, quote, summarize, and act on
- It should preserve the ExpatGuide reference-site tone

FINAL HARD RULES CHECK BEFORE RETURNING
- no first person (with stated exceptions)
- year in title
- all internal links start with "/" and use only AVAILABLE slugs
- banned words list still applies
- use ranges for prices unless explicitly verified
- affiliate caps unchanged

Return exactly this format:

FINAL PACKAGE

# Final Title
...

# Final Article
[patched markdown article]

# Final Internal Links Used
- ...
- ...

# Final Affiliate Mentions Used
- ...
- or "none"

# Patch Changelog
- Issue ID:
  Original sentence:
  Patched sentence:
  Change type: cosmetic / scope narrowed / condition added / claim downgraded / claim removed / source-risk disclosed
  Meaning changed: yes/no
  Why this is substantive:
- Issue ID:
  Original sentence:
  Patched sentence:
  Change type: cosmetic / scope narrowed / condition added / claim downgraded / claim removed / source-risk disclosed
  Meaning changed: yes/no
  Why this is substantive:

# Final SEO/GEO Check
- primary_search_intent_clear: pass/fail
- followup_questions_covered: pass/fail
- intro_answers_core_query_early: pass/fail
- headings_search_clear: pass/fail
- geo_friendly_but_natural: pass/fail
- no_keyword_stuffing: pass/fail
- no_ai_sounding_filler: pass/fail

# Final Self-Audit (evidence required)
- year_in_title: pass/fail
  - Title quoted: ...
- first_person: pass/fail
  - If pass, cite 2 random sentences showing publication voice:
  - If fail, quote every first-person instance:
- banned_words: pass/fail
  - If pass, provide 3 spot-checks, prioritizing words MOST likely to have slipped in (e.g. delve, leverage, robust, comprehensive, navigate, nuanced, foster, streamline):
    - "word X" — not found
    - "word Y" — not found
    - "word Z" — not found
  - If fail, list each banned word found and quote the sentence:
- affiliate_limits: pass/fail
  - Count: SafetyWing = X, Wise = Y, World Nomads = Z, others = ...
- absolute_internal_links_only: pass/fail
  - List EVERY internal link in the final article, and for each one confirm:
    - starts with "/" (not "http", not "[")
    - slug exists in AVAILABLE INTERNAL ARTICLES
    - markdown syntax is valid (complete [text](/path) with no broken line breaks)
- internal_links_preserved: pass/fail (v2.2 new)
  - For each internal link in the original draft, confirm it still exists and is syntactically valid in the final article
  - If a link was intentionally removed or changed by an ISSUE LIST entry, note which Issue ID authorized the change
  - If any link is broken unintentionally, mark fail
- official_vs_practical_distinction_preserved: pass/fail
  - Quote 1–2 lines from the patched article where the distinction is still surfaced:
- markdown_format: pass/fail
- unsupported_claims_added: pass/fail
  - List any newly added factual elements, or say "none added"
- unsupported_specific_numbers: pass/fail
  - List all prices / fees / wait times / validity periods / other volatile numbers in the final article and mark each as verified / range / unsupported
- decision_usefulness: pass/fail
  - Confirm a reader finishing this article knows what to do next
```

---

## 一句话版本

普通文优先帮助读者做决定，不优先追求信息尽可能完整。
