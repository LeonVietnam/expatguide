# ExpatGuide 普通文章生产手册 v2.52

## v2.52 更新说明（vs v2.51）

基于 postal-courier 文章实战暴露的两个问题升级:

1. **新增 Scope Definition Check**(解决 scope 隐性锁定问题)
   - 原问题: Topic 名称包含服务商名(如"Vietnam Post")会让 GPT 把 scope 锁在单一公司,忽略读者真实的决策空间
   - 解决: Topic Sheet 必须明确 Primary Scope + Adjacent Space,写前强制认领整个决策空间

2. **新增 Decision Data Floor**(解决普通车道过度避开数字的问题)
   - 原问题: GPT 写普通车道文章时,为了"安全",系统性地避开价格、时效、具体地点等决策数据,导致文章缺少实操价值
   - 解决: 涉及产品/服务对比的普通车道文章,必须包含参考价格区间、时效区间、落地信息("去哪/怎么找"),不能全程避开数字

3. **Prompt 4 / Deep Draft 输出结构升级**
   - 原"# Sidebar Label"单字段 → 升级为"# Frontmatter Block"完整块
   - 输出直接是 `---/title/description/sidebar.label/---` 结构,可整块复制粘贴到文件顶部,不用再手动组装

4. Self-Audit 新增 `scope_completeness` 和 `decision_data_present` 两项检查

## v2.51 更新说明（vs v2.5）

1. **新增 `sidebar.label` 强制要求**——所有新文章的 frontmatter 必须包含 `sidebar.label` 字段,用于侧边栏显示。原因:SEO 优化的长标题(60-80 字符)直接作为侧边栏显示文字会造成视觉杂乱,长标题挤压在窄侧栏里会换行成 3-4 行,严重损害导航体验。`sidebar.label` 解决此问题而**不影响 SEO**(Google 不读侧边栏导航文字)。
2. Prompt 4 / Deep Draft Prompt 的 frontmatter 输出要求明确加入 `sidebar.label`
3. Self-Audit 新增 `sidebar_label_present` 检查项
4. 给出 `sidebar.label` 设计原则:**指向性优先于美观**,不能为简短而牺牲用户对内容的准确预期

## v2.5 更新说明（vs v2.4）

1. 新增 **Affiliate 平衡策略**——原 SOP 只有"不要硬塞"的防御性规则,导致 GPT 在明显适合植入的话题上也回避,漏掉自然推广机会。v2.5 加入对称条款:当产品是读者问题的**自然答案**时,必须考虑植入。
2. Prompt 2（Research Pack）加入规则:调研阶段必须主动识别与主题相关的 affiliate 产品,不能在调研层面直接跳过。
3. Prompt 4 / Deep Draft Prompt 的 Affiliate rules 从"只防止硬塞"升级为"平衡策略",给出具体场景清单:什么时候应该自然提及、什么时候应该省略。
4. Self-Audit 新增 `affiliate_opportunity_check` 项,让 GPT 在审查时思考"这篇是否漏掉了自然的 affiliate 机会"。

## v2.4 更新说明（vs v2.3）

1. 新增**禁止 OpenAI 内部引用标记泄漏**规则（`:contentReference[oaicite:...]{index=...}`、`oaicite`、`{index=` 等),此类标记在 GPT 联网搜索后输出到 markdown 代码块时会原样泄漏,必须拦截
2. Prompt 4 / Deep Draft Prompt / Prompt 5 都加入"输出前扫描并移除此类标记"的硬规则
3. Self-Audit 新增 `no_openai_citation_markers` 检查项
4. check-articles.sh v1.4 同步加入机械检测,作为兜底

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
- **frontmatter 必须包含 `sidebar.label`**（见下方设计原则）
- 内链必须绝对路径（以 `/` 开头），不能是 `http://` 开头的完整 URL，不能是 `[DOMAIN]` 占位符，不能是编造的 slug
- 第一人称规则（见下方详细说明）
- 不暴露工作流和身份
- 禁用词必须过滤
- 房租 / 费用尽量用区间
- SafetyWing / Wise 各最多自然提及一次
- World Nomads 不与 SafetyWing 同句
- 数据来源用 italic 小字标注
- 语气必须是 neutral, practical, reference-style

### sidebar.label 设计原则（v2.51 新增）

#### 为什么需要这个字段

- 文章 `title` 为 SEO 优化,通常 60-80 字符(必须包含关键词、年份、"for Expats"、"Guide" 等)
- 这样的长标题直接作为侧边栏显示文字会导致视觉杂乱,多行换行挤压导航体验
- `sidebar.label` 只影响左侧导航显示,**不影响 SEO**(Google 不读侧边栏,只读 `<h1>`、`<title>`、`<meta>`)
- Astro Starlight 原生支持此字段,格式见下

#### 格式

```yaml
sidebar:
  label: "Short Label"
```

#### 设计原则（重要性排序）

1. **指向性第一**:读者扫一眼 label 就能准确预期文章内容。宁可稍长也不要模糊。
2. **避免歧义**:如果不加限定词会和其他文章混淆,必须加限定词。
   - 例:"Driver's License" 可能被误解为考驾照,应改为 "Driver's License Conversion"
   - 例:"Motorbike" 可能是买车指南,应改为 "Motorbike Driving"
3. **善用系列前缀**:同类文章用统一前缀形成系列感。
   - 例:"Cost of Living: Vietnam" 和 "Cost of Living: Hoi An"
   - 例:"Hanoi: Where to Live"、"Saigon: Where to Live"、"Da Nang: Where to Live"
4. **用动词开头**(如果自然):
   - 例:"Open a Bank Account"(比 "Bank Account" 指向性更强)
   - 例:"Foreign Cards: Where They Work"(直接回应用户问题)
5. **长度控制**:3-5 个词最佳,最多不超过 6 个词。超过 6 个词侧边栏仍会换行,失去意义。
6. **不能为美观牺牲清晰**:如果短名让读者不知道是什么,必须加回关键词。

#### 反例

- ❌ "Visa"(板块名已经是 Visa,label 重复无信息)
- ❌ "Cards"(不知道是本地卡、外国卡、信用卡、借记卡)
- ❌ "Hoi An"(不知道是生活成本、房产、签证还是攻略)
- ❌ "Guide"(完全无信息)
- ❌ "Neighborhoods"(不知道哪个城市)

#### 正例

- ✓ "Visa Options"(明确是 visa 类型对比)
- ✓ "Cost of Living: Hoi An"(系列 + 城市 + 主题都齐全)
- ✓ "TRC Application"(用 expat 圈共识缩写,明确是申请流程)
- ✓ "Essential Apps"(覆盖范围清晰)
- ✓ "Driver's License Conversion"(加 Conversion 避免和考证混淆)

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

### Scope Definition Check (v2.52)

**背景问题**: Topic 名称如果包含具体服务商名称(例如"Vietnam Post / Winmart / California Fitness"),GPT 可能把 scope 隐性锁定在该服务商,忽略读者真实的决策空间——读者问"how to send items internationally"时,决策空间包括 Vietnam Post + DHL + FedEx + SF Express + J&T 等,不只有 Vietnam Post 一家。

**硬规则**: 每个 TOPIC SHEET 必须明确列出以下三个字段:

1. **Primary Scope**: 文章核心覆盖内容
2. **Adjacent Space**: 读者在决策时会对比的外部选项(竞争品、替代方案、同类服务)
3. **Decision on Adjacent**: 这些 Adjacent 选项在本文怎么处理,三选一:
   - `included-full`: 纳入本文完整 scope(和 Primary 并列展开)
   - `included-brief`: 提及对比,但不深入(指向读者自查或未来文章)
   - `omitted`: 不涉及(读者需看另一篇)

**判定原则**:

- 如果 topic 的核心问题是"怎么做到 X"(例如"怎么国际寄件"),Adjacent 默认应该 `included-full` 或至少 `included-brief`,不能 `omitted`
- 如果 topic 的核心问题是"某个具体服务怎么用"(例如"怎么用 Wise"),Primary 就是该服务,Adjacent 可以 `omitted` 或 `included-brief`
- 拿不定时,问: **"读者带着这个问题来,他想看到的是全部选项比较,还是某一个服务的深度指南?"**

**反例 vs 正例**:

❌ 反例:
```
Topic: Vietnam Post / 国际寄送 guide
Primary Scope: Vietnam Post 的各项国际寄件服务
(没有 Adjacent Space 字段,或写成"其他快递"模糊带过)
```

结果: 文章只讲 Vietnam Post,漏掉 DHL / FedEx / SF Express,读者读完仍然不知道完整决策空间。

✓ 正例:
```
Topic: 从越南国际寄件的完整决策指南
Primary Scope: 四类主流国际寄件服务的对比与选择(Vietnam Post / 国际快递 / 区域快递 / 本地民营)
Adjacent Space:
  - 国际快递: DHL, FedEx, UPS
  - 区域快递: SF Express, J&T, Ninja Van
  - 本地民营: Giao Hàng Nhanh, Viettel Post
Decision on Adjacent: included-full (文章必须覆盖完整决策空间)
```

**失败信号**: Self-Audit 时,如果一个 topic 看起来只讲了一家服务的内部产品,问自己: "读者实际在决策什么?" 如果他在做跨品牌选择,而文章只讲了一家,就是 scope 锁定失败。

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

CRITICAL: No OpenAI internal citation markers in output
- NEVER leave OpenAI internal citation markers in the final article
- These include but are not limited to:
  - `:contentReference[oaicite:XX]{index=XX}` style markers
  - Anything containing `oaicite`
  - Anything containing `{index=`
  - `【...】` source-tag brackets auto-generated by search tools
- These markers appear when GPT uses web search and then wraps output in a markdown code block; they are internal tool artifacts that must be stripped
- Before outputting the Final Article inside a markdown code block, manually scan the entire article for these patterns and remove them
- If a sentence relied on such a marker for attribution, either:
  (a) convert to a plain inline link like `[source name](https://real-url)` if the URL is real and useful, or
  (b) simply remove the marker and keep the surrounding prose (preferred for brevity)
- Never leave placeholder citations that render as raw code to the reader

Decision Data Floor (v2.52 — applies when article compares products/services):

Trigger: this rule activates when the article's core question is "which option to choose" or "how to do X", and the answer involves comparing concrete products, services, vendors, or price tiers.

Examples that TRIGGER this rule:
- How to choose a gym (comparing chains / local / hotel options)
- How to ship internationally (comparing postal / DHL / SF Express)
- How to buy furniture (comparing malls / online / secondhand)
- How to get home internet (comparing ISPs)
- How to pay electricity bills (comparing direct EVN / landlord rebill / bundled)

Examples that DO NOT trigger this rule:
- Cultural etiquette guides
- Seasonal survival tips (Tet, monsoon)
- Health awareness content (dengue prevention, air quality)
- Pure how-to procedures with no product comparison

When the rule triggers, the article MUST include:

1. Price ranges (not exact numbers — ranges are fine and preferred for volatility)
   - For each main option, give a practical range: "约 X-Y VND" or "$X-$Y range"
   - If a true range is hard to pin down, give a "typical starting point" with a caveat ("from approximately X, varies by destination/size/tier")
   - Never write the article with zero price anchors — readers cannot decide without them

2. Time/duration anchors (if applicable)
   - Processing times, delivery times, wait times, appointment lead times
   - Ranges preferred ("3-7 business days")

3. Where/how to access
   - Name specific places, chains, apps, URLs, or office types
   - "A larger city branch" without specifying which = insufficient
   - Give at least one concrete starting point per option (e.g., "Vietnam Post main office on Dinh Tien Hoang in Hanoi" or "DHL Express has offices in D1 HCMC — check dhl.com.vn for current locations")

4. Mandatory caveat on volatile data
   - All prices and times should be marked as "approximate, varies by..." or "as of [month] 2026"
   - This protects accuracy while still giving decision data

Why this exists: reference sites earn their value by giving decision-ready data. An article that says "EMS is faster than ordinary mail" without time/price anchors fails the decision-usefulness test — the reader cannot act on it. Over-caution on numbers is the opposite of helpful.

Rule of thumb: if the reader finishes the article and still doesn't have rough numbers to compare options, the article has failed the Decision Data Floor.

Affiliate rules (v2.5 balanced):

Upper caps (hard limits — never exceed):
- SafetyWing can appear at most once, naturally
- Wise can appear at most once, naturally
- World Nomads must not appear in the same sentence as SafetyWing

Lower floor (equally important — do not under-promote):
- DO NOT omit an affiliate mention when the product is a genuinely natural, useful answer to the article's core reader question
- The test: "If an independent expat friend were answering this question, would they naturally mention this product?" If yes, include it once, naturally.
- Typical scenarios where mention is EXPECTED (natural fit):
  - Cross-border money, multi-currency, foreign ATM withdrawals, foreign cards in Vietnam → Wise is a natural fit
  - Travel medical insurance for stays under 1 year, nomad insurance, short-to-medium term coverage → SafetyWing is a natural fit
  - Adventure sports, high-risk activity coverage → World Nomads is a natural fit
- Scenarios where omission is correct:
  - The article is about a topic these products don't help with
  - Mention would be clearly forced, off-topic, or interrupt the reader's decision flow

Calibration:
- "Natural" means the mention serves the reader, not the site
- If the mention has to be shoehorned in with awkward transition phrasing, it's forced — omit it
- If the mention would actually save the reader time or money in the scenario being discussed, it's natural — include it once
- When in doubt, lean toward inclusion (one natural mention) rather than omission, because omitting a useful product is also a disservice to the reader
- Do not force affiliate placement; equally, do not under-promote by default

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

# Frontmatter Block
```yaml
---
title: "[full SEO title including year]"
description: "[meta description, 120-160 chars, decision-focused]"
sidebar:
  label: "[short, high-signal sidebar label — see sidebar.label design rules]"
---
```
Output the above as a single complete YAML block, exactly in this structure, with the triple-dashes (---). This block will be copied directly as the first lines of the article file. Do NOT include this block again at the start of the # Article section below — the article markdown starts with the first ## heading, not with a second frontmatter.

# Article
[full markdown article — starts directly with first ## heading, no H1, no duplicate frontmatter]

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
- sidebar_label_present: pass/fail (v2.51)
  - Sidebar label quoted: "..."
  - Confirm label meets design principles:
    - Has indicative signal (reader can predict article content from label alone)
    - Avoids ambiguity (adds qualifier if needed to prevent confusion with sibling articles)
    - 3-6 words maximum
    - Does not duplicate the category name (e.g., not "Visa" when under Visa category)
  - If fail, explain what's missing or wrong
- scope_completeness: pass/fail (v2.52)
  - Primary Scope in Topic Sheet: "..."
  - Adjacent Space listed in Topic Sheet: "..."
  - Decision on Adjacent: included-full / included-brief / omitted
  - Does the final article's actual coverage match the declared decision?
    - If "included-full": confirm all Adjacent options are covered with real information (not just named)
    - If "included-brief": confirm Adjacent is mentioned in a comparison frame, with reader pointed to further action
    - If "omitted": confirm that omission is defensible (readers for this specific topic don't need Adjacent options here)
  - Failure pattern to check: if the article could be rewritten with "Actually, you should consider X instead" and that rewrite would significantly change reader decisions, scope was locked too narrowly — mark fail
- decision_data_present: pass/fail (v2.52)
  - Does this article compare products/services (triggering Decision Data Floor)? Yes / No
  - If No: mark pass with note "Decision Data Floor not applicable for this topic"
  - If Yes, confirm each element:
    - Price ranges present for each main option: pass/fail + quote one example
    - Time/duration anchors present where applicable: pass/fail + quote one example
    - Where/how to access (specific names, locations, URLs): pass/fail + quote one example
    - Volatility caveats ("approximate", "varies by...", "as of 2026"): pass/fail
  - If any element fails, the article fails this check and must be revised before publication
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
- affiliate_opportunity_check: pass/fail (v2.5)
  - Check whether the article topic has a natural affiliate fit (see Affiliate rules scenarios list)
  - If natural fit exists AND the article currently includes the product → pass
  - If no natural fit exists → pass (correct to omit)
  - If natural fit exists BUT the article does not mention the product → fail, and state:
    - Which product was missed (Wise / SafetyWing / World Nomads)
    - Why the fit is natural for this topic
    - Where in the article it would fit most naturally (section name or nearby paragraph)
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
- no_openai_citation_markers: pass/fail
  - Scan the entire final article for any occurrence of:
    - `:contentReference`
    - `oaicite`
    - `{index=`
    - unreplaced `【...】` source-tag brackets
  - If pass, confirm none of the above patterns appear anywhere in the output
  - If fail, list each occurrence and its line context (must be cleaned before publication)
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
- Affiliate product identification (v2.5): at the research stage, actively check whether the topic has a natural fit with any of the site's affiliate products. This is NOT about pushing products; it is about surfacing whether the product is a genuinely common practical answer to the reader's problem:
  - Cross-border money / multi-currency / foreign ATM withdrawals / foreign cards in Vietnam → likely Wise fit
  - Travel medical insurance / nomad insurance for stays under 1 year / short-to-medium expat coverage → likely SafetyWing fit
  - Adventure or high-risk activity coverage → likely World Nomads fit
- If a fit exists, add it as a Key Claim (or note it under "Known Variation Points") so the Draft stage has the option to mention naturally. The Validation and Draft stages decide whether to include. Research must not pre-hide the option.

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

CRITICAL: No OpenAI internal citation markers in output
- NEVER leave OpenAI internal citation markers in the final article
- These include but are not limited to:
  - `:contentReference[oaicite:XX]{index=XX}` style markers
  - Anything containing `oaicite`
  - Anything containing `{index=`
  - `【...】` source-tag brackets auto-generated by search tools
- These markers appear when GPT uses web search and then wraps output in a markdown code block; they are internal tool artifacts that must be stripped
- Before outputting the Final Article inside a markdown code block, manually scan the entire article for these patterns and remove them
- If a sentence relied on such a marker for attribution, either:
  (a) convert to a plain inline link like `[source name](https://real-url)` if the URL is real and useful, or
  (b) simply remove the marker and keep the surrounding prose (preferred for brevity)
- Never leave placeholder citations that render as raw code to the reader

Decision Data Floor (v2.52 — applies when article compares products/services):

Trigger: this rule activates when the article's core question is "which option to choose" or "how to do X", and the answer involves comparing concrete products, services, vendors, or price tiers.

Examples that TRIGGER this rule:
- How to choose a gym (comparing chains / local / hotel options)
- How to ship internationally (comparing postal / DHL / SF Express)
- How to buy furniture (comparing malls / online / secondhand)
- How to get home internet (comparing ISPs)
- How to pay electricity bills (comparing direct EVN / landlord rebill / bundled)

Examples that DO NOT trigger this rule:
- Cultural etiquette guides
- Seasonal survival tips (Tet, monsoon)
- Health awareness content (dengue prevention, air quality)
- Pure how-to procedures with no product comparison

When the rule triggers, the article MUST include:

1. Price ranges (not exact numbers — ranges are fine and preferred for volatility)
   - For each main option, give a practical range: "约 X-Y VND" or "$X-$Y range"
   - If a true range is hard to pin down, give a "typical starting point" with a caveat ("from approximately X, varies by destination/size/tier")
   - Never write the article with zero price anchors — readers cannot decide without them

2. Time/duration anchors (if applicable)
   - Processing times, delivery times, wait times, appointment lead times
   - Ranges preferred ("3-7 business days")

3. Where/how to access
   - Name specific places, chains, apps, URLs, or office types
   - "A larger city branch" without specifying which = insufficient
   - Give at least one concrete starting point per option (e.g., "Vietnam Post main office on Dinh Tien Hoang in Hanoi" or "DHL Express has offices in D1 HCMC — check dhl.com.vn for current locations")

4. Mandatory caveat on volatile data
   - All prices and times should be marked as "approximate, varies by..." or "as of [month] 2026"
   - This protects accuracy while still giving decision data

Why this exists: reference sites earn their value by giving decision-ready data. An article that says "EMS is faster than ordinary mail" without time/price anchors fails the decision-usefulness test — the reader cannot act on it. Over-caution on numbers is the opposite of helpful.

Rule of thumb: if the reader finishes the article and still doesn't have rough numbers to compare options, the article has failed the Decision Data Floor.

Affiliate rules (v2.5 balanced):

Upper caps (hard limits — never exceed):
- SafetyWing can appear at most once, naturally
- Wise can appear at most once, naturally
- World Nomads must not appear in the same sentence as SafetyWing

Lower floor (equally important — do not under-promote):
- DO NOT omit an affiliate mention when the product is a genuinely natural, useful answer to the article's core reader question
- The test: "If an independent expat friend were answering this question, would they naturally mention this product?" If yes, include it once, naturally.
- Typical scenarios where mention is EXPECTED (natural fit):
  - Cross-border money, multi-currency, foreign ATM withdrawals, foreign cards in Vietnam → Wise is a natural fit
  - Travel medical insurance for stays under 1 year, nomad insurance, short-to-medium term coverage → SafetyWing is a natural fit
  - Adventure sports, high-risk activity coverage → World Nomads is a natural fit
- Scenarios where omission is correct:
  - The article is about a topic these products don't help with
  - Mention would be clearly forced, off-topic, or interrupt the reader's decision flow

Calibration:
- "Natural" means the mention serves the reader, not the site
- If the mention has to be shoehorned in with awkward transition phrasing, it's forced — omit it
- If the mention would actually save the reader time or money in the scenario being discussed, it's natural — include it once
- When in doubt, lean toward inclusion (one natural mention) rather than omission, because omitting a useful product is also a disservice to the reader
- Do not force affiliate placement; equally, do not under-promote by default

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

# Frontmatter Block
```yaml
---
title: "[full SEO title including year]"
description: "[meta description, 120-160 chars, decision-focused]"
sidebar:
  label: "[short, high-signal sidebar label — see sidebar.label design rules]"
---
```
Output the above as a single complete YAML block, exactly in this structure, with the triple-dashes (---). This block will be copied directly as the first lines of the article file. Do NOT include this block again at the start of the # Article section below — the article markdown starts with the first ## heading, not with a second frontmatter.

# Article
[full markdown article — starts directly with first ## heading, no H1, no duplicate frontmatter]

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
- sidebar_label_present: pass/fail (v2.51)
  - Sidebar label quoted: "..."
  - Confirm label meets design principles:
    - Has indicative signal (reader can predict article content from label alone)
    - Avoids ambiguity (adds qualifier if needed to prevent confusion with sibling articles)
    - 3-6 words maximum
    - Does not duplicate the category name (e.g., not "Visa" when under Visa category)
  - If fail, explain what's missing or wrong
- scope_completeness: pass/fail (v2.52)
  - Primary Scope in Topic Sheet: "..."
  - Adjacent Space listed in Topic Sheet: "..."
  - Decision on Adjacent: included-full / included-brief / omitted
  - Does the final article's actual coverage match the declared decision?
    - If "included-full": confirm all Adjacent options are covered with real information (not just named)
    - If "included-brief": confirm Adjacent is mentioned in a comparison frame, with reader pointed to further action
    - If "omitted": confirm that omission is defensible (readers for this specific topic don't need Adjacent options here)
  - Failure pattern to check: if the article could be rewritten with "Actually, you should consider X instead" and that rewrite would significantly change reader decisions, scope was locked too narrowly — mark fail
- decision_data_present: pass/fail (v2.52)
  - Does this article compare products/services (triggering Decision Data Floor)? Yes / No
  - If No: mark pass with note "Decision Data Floor not applicable for this topic"
  - If Yes, confirm each element:
    - Price ranges present for each main option: pass/fail + quote one example
    - Time/duration anchors present where applicable: pass/fail + quote one example
    - Where/how to access (specific names, locations, URLs): pass/fail + quote one example
    - Volatility caveats ("approximate", "varies by...", "as of 2026"): pass/fail
  - If any element fails, the article fails this check and must be revised before publication
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
- affiliate_opportunity_check: pass/fail (v2.5)
  - Check whether the article topic has a natural affiliate fit (see Affiliate rules scenarios list)
  - If natural fit exists AND the article currently includes the product → pass
  - If no natural fit exists → pass (correct to omit)
  - If natural fit exists BUT the article does not mention the product → fail, and state:
    - Which product was missed (Wise / SafetyWing / World Nomads)
    - Why the fit is natural for this topic
    - Where in the article it would fit most naturally (section name or nearby paragraph)
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
- no_openai_citation_markers: pass/fail
  - Scan the entire final article for any occurrence of:
    - `:contentReference`
    - `oaicite`
    - `{index=`
    - unreplaced `【...】` source-tag brackets
  - If pass, confirm none of the above patterns appear anywhere in the output
  - If fail, list each occurrence and its line context (must be cleaned before publication)
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
- sidebar_label_present: pass/fail (v2.51)
  - Sidebar label quoted: "..."
  - Confirm label meets design principles:
    - Has indicative signal (reader can predict article content from label alone)
    - Avoids ambiguity (adds qualifier if needed to prevent confusion with sibling articles)
    - 3-6 words maximum
    - Does not duplicate the category name (e.g., not "Visa" when under Visa category)
  - If fail, explain what's missing or wrong
- scope_completeness: pass/fail (v2.52)
  - Primary Scope in Topic Sheet: "..."
  - Adjacent Space listed in Topic Sheet: "..."
  - Decision on Adjacent: included-full / included-brief / omitted
  - Does the final article's actual coverage match the declared decision?
    - If "included-full": confirm all Adjacent options are covered with real information (not just named)
    - If "included-brief": confirm Adjacent is mentioned in a comparison frame, with reader pointed to further action
    - If "omitted": confirm that omission is defensible (readers for this specific topic don't need Adjacent options here)
  - Failure pattern to check: if the article could be rewritten with "Actually, you should consider X instead" and that rewrite would significantly change reader decisions, scope was locked too narrowly — mark fail
- decision_data_present: pass/fail (v2.52)
  - Does this article compare products/services (triggering Decision Data Floor)? Yes / No
  - If No: mark pass with note "Decision Data Floor not applicable for this topic"
  - If Yes, confirm each element:
    - Price ranges present for each main option: pass/fail + quote one example
    - Time/duration anchors present where applicable: pass/fail + quote one example
    - Where/how to access (specific names, locations, URLs): pass/fail + quote one example
    - Volatility caveats ("approximate", "varies by...", "as of 2026"): pass/fail
  - If any element fails, the article fails this check and must be revised before publication
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
- affiliate_opportunity_check: pass/fail (v2.5)
  - Check whether the article topic has a natural affiliate fit (see Affiliate rules scenarios list)
  - If natural fit exists AND the article currently includes the product → pass
  - If no natural fit exists → pass (correct to omit)
  - If natural fit exists BUT the article does not mention the product → fail, and state:
    - Which product was missed (Wise / SafetyWing / World Nomads)
    - Why the fit is natural for this topic
    - Where in the article it would fit most naturally (section name or nearby paragraph)
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
- no_openai_citation_markers: pass/fail
  - Scan the entire final article for any occurrence of:
    - `:contentReference`
    - `oaicite`
    - `{index=`
    - unreplaced `【...】` source-tag brackets
  - If pass, confirm none of the above patterns appear anywhere in the output
  - If fail, list each occurrence and its line context (must be cleaned before publication)
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
