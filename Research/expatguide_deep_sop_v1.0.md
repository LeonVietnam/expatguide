# ExpatGuide 深度文章生产手册 v1.0

## v1.0 设计说明

本手册为深度车道独立完整执行版,与普通车道 SOP v2.52 平级、互不依赖。

### 为什么需要深度车道

普通车道 v2.52 的核心权衡是 `decision-usefulness > factual caution`。这对 Daily Life、Housing、Digital Nomad 等中低风险主题是合适的——读者读完知道怎么做就行,容许少量近似。

但当主题进入以下领域,这个权衡会反过来伤害读者:

- **YMYL 主题**(Your Money Your Life):健康、金融、法律决策。错的建议会让读者花冤枉钱、失去身份合法性、健康受损。
- **强法规主题**:Visa / TRC / 税务 / 工作许可。规则有具体编号、生效日、适用对象,模糊就是错。
- **强时效主题**:近期改革、新生效法规、刚发布的官方通知。引用旧规等同传播错误信息。
- **多源冲突主题**:官方规定 vs 实际执法 / 商家宣传 vs 实际兑现 / 不同部委说法不一。压平差异等同欺骗读者。

深度车道的核心权衡反过来:`factual robustness > decision-usefulness`。哪怕段落更长、读起来更慢,也要保留真实存在的法规条件、生效日、适用范围、灰色地带。

### 与普通车道 v2.52 的本质区别(7 个差异点)

1. **Topic Sheet** 多 3 个字段(Risk Tier / Effective Date Sensitivity / Multi-Source Conflict Expected)
2. **Research Pack** 多 4 类信息(Regulatory Source Map / Authority Hierarchy / Conflict Inventory / Eligibility Matrix)
3. **Validation 必须双跑**(严格立场跑 + 灰色立场跑,产出差异即 Gray-Area 强信号)
4. **Draft 强制 Layered Writing**(Official layer + Practical layer,禁止压平)
5. **Claude QA 阶段独有**(Tier 1 来源验证 / 生效日核查 / 对抗性双视角)
6. **Patch 后二次 Claude QA pass**(确认 patch 没引入新问题)
7. **Self-Audit 多 6 项**(regulatory_citation_completeness / effective_date_check / tier1_source_present / layered_writing_preserved / legal_safety_disclaimers / affiliate_compliance_check)

### 不变的部分

以下要素与普通车道 v2.52 完全一致,本手册原文复制保留,确保独立可执行:

- 站点固定规则(标题年份 / sidebar.label / 内链格式 / 第一人称规则 / 禁用词 / affiliate caps / 数据来源标注 / 语气定位)
- 禁用词分级清单(硬禁用 + 语境敏感)
- sidebar.label 设计原则
- 第一人称规则
- 内链工作流
- OpenAI citation marker 防泄漏规则
- Decision Data Floor(深度车道仍然适用,只是优先级低于 factual robustness)
- Affiliate balanced rules(深度车道额外加入合规检查)

---

## 适用范围

仅用于深度文章。

**强制深度车道的主题**(任何一项触发即必须深度,不允许"先用普通试试"):

- 涉及 visa / residency / TRC / work permit
- 涉及 tax / 报税 / 税务居民判定
- 涉及 insurance / 健康保险 / 商业保险
- 涉及 healthcare(具体医院推荐 / 医疗保险 / 急诊指引等具体决策,不是泛医疗常识)
- 涉及 banking 的合规层(KYC / 生物识别 / 跨境汇款 / 反洗钱规则)
- 涉及 legality / compliance(法律灰色地带、半合规操作)
- 涉及 contract / 合同 / 押金法律纠纷
- Topic Sheet 中 `Execution Risk = high`
- Topic Sheet 中 `Need Official-vs-Practical Distinction = yes` 且涉及上述任一领域
- Topic Sheet 中 `Risk Tier = YMYL`(健康、金融、法律、安全)
- 准备做 pillar / flagship 页

**不应使用深度车道的情况**:

- 文化常识、生活技巧、季节性建议(Tet 攻略、雨季准备)
- 纯产品/服务对比,且无法规风险(咖啡馆推荐、健身房选择)
- 城市概览类(社区指南、生活成本汇总)
- 主题虽然涉及健康/金融,但内容是纯介绍(例如"越南有哪些主流药店连锁"——介绍性,不指导用药)

边界判断原则:**当读者按文章建议行动后,可能产生不可逆/高代价后果(身份违法、医疗误判、金钱损失)时,走深度。否则走普通。**

---

## 核心原则

1. 不依赖自动衔接
2. 每一步都由显式 prompt 触发
3. 上一步输出原样喂给下一步
4. **深度车道核心权衡:factual robustness 优先于 decision-usefulness**
5. 当 factual robustness 与 decision-usefulness 冲突时,factual robustness 优先。即使段落更长、节奏更慢,也要保留真实存在的法规条件、适用范围、生效日、灰色地带、不确定性。
6. 不为了"流畅好读"压平 Gray-Area Claim
7. 不为了"读者一眼看懂"省略前置条件
8. **过度自信是深度车道的最大失败模式**——宁可写"this is unclear, see [official source]",不写一个看似确定但可能错的结论

---

## 全局变量(改动时同步所有 Prompt)

以下变量一旦变更,必须同步检查并更新:

- Prompt 1(Topic Proposal,深度车道版)
- Prompt 2(Deep Research Pack)
- Prompt 3-Strict(Validation,严格立场跑)
- Prompt 3-Gray(Validation,灰色立场跑)
- Prompt 3-Merge(双跑合并)
- Deep Draft Prompt
- Claude QA Prompt(初次)
- Prompt 5(Patch + Final SEO/GEO Pass)
- Claude QA Pass 2 Prompt(Patch 后二次审查)

需要同步的全局变量包括:

- HARD RULES 区块
- 禁用词 / 过度 AI 味词列表
- Affiliate caps
- 内链规则
- 价格 / 数字表达规则
- first-person prohibition
- year-in-title rule
- Tier 1 来源定义
- 法规引用格式

### 全局禁用词清单(分级)

清单分为两类:硬禁用词和语境敏感词。

#### 硬禁用词(任何语境都禁止)

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

#### 语境敏感词(仅特定语境允许)

这些词在精准的、本义的语境下允许使用,但作为填充语、抽象隐喻、夸张形容时禁止。

| 词 | 允许场景 | 禁止场景 |
|---|---|---|
| **leverage** | 名词,谈判 / 财务 / 筹码本义:`gives the renter leverage`、`high financial leverage` | 动词形式的填充语:`leverage your skills`、`leverage technology to...` |
| **navigate** | 实际方位 / 界面导航:`navigate the city`、`navigate to the settings page` | 抽象隐喻:`navigate the complexities of...`、`navigate the regulatory environment` |
| **landscape** | 地理景观:`the mountainous landscape of Da Nang` | 抽象比喻:`the regulatory landscape`、`the visa landscape` |
| **comprehensive** | 精确描述具体覆盖范围:`comprehensive insurance covers X, Y, Z` | 形容文章自己或宽泛的"全面":`a comprehensive guide` |
| **robust** | 工程 / 技术语境的"稳健":`robust encryption`、`robust internet infrastructure` | 形容计划 / 系统 / 经济等抽象事物:`a robust strategy`、`robust growth` |
| **nuanced** | 准确描述真实存在的微妙差别,且具体说明差别在哪:`The rules are nuanced — A applies to X, B applies to Y` | 作为"复杂"的高级替代词:`a nuanced situation` 后没有具体说明 |
| **crucial** | 描述真正不可或缺的客观事实:`A valid TRC is crucial for...` | 用作通用强调词:`it's crucial to note`、`crucially important` |

#### 判定原则

- 如果一个词只是为了让句子"听起来更高级"而加入,禁止使用
- 如果一个词承担了具体语义(特别是名词本义),允许使用
- 拿不定主意时,问:替换成更平实的词后意思是否完全等价?如果是,原词是填充语;如果有损失,原词是承担语义的精准用词

#### 全局规则

- 草稿中如果出现硬禁用词,默认改成更平实、更自然的表达,不因为"看起来高级"而保留
- 草稿中如果出现语境敏感词,必须确认其使用属于"允许场景"才能保留
- 禁用词过滤同时适用于旅行腔、SEO 腔、常见 GPT 腔

---

## 站点固定规则

- 标题必须带年份
- **frontmatter 必须包含 `sidebar.label`**(见下方设计原则)
- 内链必须绝对路径(以 `/` 开头),不能是 `http://` 开头的完整 URL,不能是 `[DOMAIN]` 占位符,不能是编造的 slug
- 第一人称规则(见下方详细说明)
- 不暴露工作流和身份
- 禁用词必须过滤
- 房租 / 费用 / 保费尽量用区间
- SafetyWing / Wise 各最多自然提及一次
- World Nomads 不与 SafetyWing 同句
- 数据来源用 italic 小字标注
- **法规引用必须包含**:全名 + 编号 + 生效日(例如 "Decision 2345/QĐ-NHNN, effective from January 1, 2025")
- 语气必须是 neutral, practical, reference-style
- **深度车道额外要求**:涉及法律 / 医疗 / 金融具体决策的段落,必须有适当的非个性化免责语(不是个人化的"this is not legal advice",而是站点编辑式的"For your specific situation, consult a licensed [profession]")

### sidebar.label 设计原则

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

#### 设计原则(重要性排序)

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
- ✓ "Health Insurance Choice"(明确是保险选择,非保险介绍)
- ✓ "DT Investor Visa"(类别明确)

### 第一人称规则详细说明

**禁止(作者第一人称):**
- I / my / me / we 用于表达个人经历、个人观点、个人推荐
- 例如:"I moved to Vietnam in 2019"、"we recommend this restaurant"、"in my experience"
- 任何会暴露作者身份或让文章读起来像个人博客的表述

**允许(站点编辑语气):**
- "our" + 站内文章引用,例如:"see our [Banking Guide](/...)"、"our [motorbike guide](/...) covers..."
- 这属于站点编辑语气,不是个人博客语气,且有助于阅读流畅性

**允许(读者视角 FAQ 标题):**
- FAQ 小标题使用读者第一人称,例如:"Can I convert my license?"、"What if my landlord refuses?"
- 这是搜索意图匹配,不是作者第一人称

判定原则:问"这句话读起来是某个人在说话,还是一个参考站点在引导读者?" 如果是后者,允许。

---

## 内链工作流

### 背景

GPT 不知道你站点上有哪些文章。如果让它凭空猜内链,会出现:

- 用 `[EXPATGUIDE_DOMAIN]` 这种占位符
- 编造不存在的 slug
- 完全不加内链,导致孤立页面增多

### 解决方案

维护一份 `Research/internal-articles-index.md` 文件,列出站内所有文章的 slug 和一句话描述。每次进入需要内链的步骤(Step 2 / Step 4 / Step 5)时,把这份清单的内容粘贴到 `AVAILABLE INTERNAL ARTICLES` 字段中。

### 清单生成方式

项目根目录运行:

```bash
bash generate-link-index.sh
```

脚本会扫描 `src/content/docs/vietnam/` 下所有 md / mdx 文件,从 frontmatter 自动提取 slug + description,生成最新清单。

### 清单更新时机

- 每次新发布文章后跑一次脚本
- 把更新后的 `internal-articles-index.md` 上传到 ChatGPT 的 ExpatGuide 项目知识里(覆盖旧版本)

### 内链格式硬规则

- 必须以 `/` 开头(绝对路径)
- 不能是 `https://...`(外部 URL 形式)
- 不能是 `[EXPATGUIDE_DOMAIN]/...` 或任何占位符
- 必须对应清单中存在的 slug,不能编造

### Sitemap 兜底

如果你忘了更新清单,GPT 5.4 Thinking 也可以读 `https://expatguide.site/sitemap.xml` 验证某个 slug 是否存在。但不要依赖兜底——主要工作流是清单。

---

## Tier 分级与权威层级(深度车道独有)

深度车道的所有 claim 必须明确其支撑来源的权威等级。这是后续 Validation、Claude QA、Self-Audit 的判断基础。

### 来源 Tier 定义

| Tier | 含义 | 示例 |
|---|---|---|
| **Tier 1** | 官方一手来源 | Vietnamese government .gov.vn 域名 / Bộ Y tế / Bộ Tài chính / Ngân hàng Nhà nước / 官方公告 / 法规原文 / 部委通知 |
| **Tier 2** | 主流媒体 + 大型行业机构 | VnExpress / Vietnam News Agency / Tuoi Tre / Reuters / Bloomberg / 国际四大会计师事务所(PwC, KPMG, Deloitte, EY)发布的 Vietnam tax/legal alerts |
| **Tier 3** | 行业机构 + 商业服务商 | 国际保险公司官网 / 知名律所 Vietnam practice / 商业合规咨询机构 / Chamber of Commerce |
| **Tier 4** | 社区 + 个人经验 | Facebook expat 群 / Reddit r/VietNam / 个人博客 / Forum 帖子 |

### 各 Tier 的使用规则

- **Tier 1**:可以直接作为事实依据。**任何 YMYL 主张必须有至少一条 Tier 1 支持**,否则该主张降级为 Yellow 或 Red。
- **Tier 2**:可作为辅助证据,在 Tier 1 不易获取或翻译时使用。需要 cross-check 至少一条同等 Tier 来源,或一条 Tier 1。
- **Tier 3**:仅作为 practical layer 的辅助参考,不能单独支撑 official layer claim。商业服务商的自我宣传(例如保险公司说自己 cover 什么)必须 cross-check 实际客户经验或第三方评测。
- **Tier 4**:仅作为"实际操作存在 X 现象"的弱信号,不能作为 official layer 的事实来源。引用时必须明确 framing("according to expat community reports..."),且必须配合至少一个 Tier 1-3 的对照。

### 法规引用强格式

任何法规、决议、通知、决定的引用必须三件套齐全:

- **全名**(中文越南语原名 + 英文译名,例如 "Decision 2345/QĐ-NHNN" + "biometric authentication mandate")
- **编号**(完整编号,不省略数字 / 字母后缀)
- **生效日**(年/月/日,标注是 promulgated date 还是 effective date)

错误示例:`According to recent banking regulations, biometric verification is required.`(没有具体编号,无法验证)

正确示例:`Under Decision 2345/QĐ-NHNN, effective from July 1, 2024 (with subsequent updates including ...), biometric verification is required for transfers above [amount].`

---

## 深度链路总览

```
Step 1: 选题(含 Scope Definition Check + Risk Tier 判定)
   ↓
Step 2: 深度调研
   ↓ [Key Claims Table + Regulatory Source Map + Authority Hierarchy + Conflict Inventory + Eligibility Matrix]
Step 3: 双跑验证
   ↓ Step 3a: 严格立场跑(Validation Pack — Strict)
   ↓ Step 3b: 灰色立场跑(Validation Pack — Gray)
   ↓ Step 3c: 合并(Validation Pack — Final)
Step 4: Deep Draft
   ↓ [强制 Layered Writing,不允许压平]
Step 4.5: Claude QA Pass 1
   ↓ [Tier 1 来源验证 / 生效日核查 / 对抗性双视角 / 法律安全性]
Step 5: Patch + Final SEO/GEO
   ↓ [吃 Claude ISSUE LIST + bash 错误]
Step 5.5: Claude QA Pass 2(Patch 后审查)
   ↓ [确认 patch 无新增问题 + 残留 ISSUE 处理建议]
Step 6: 保存 + 验证 + 发布(操作 SOP 流程)
```

---

## Step 1:选题

输入:Prompt 1(深度车道版)
输出:TOPIC SHEET(深度版)
要求:具体 expat 问题;符合 reference-site 定位;**已确认走深度车道**;Scope Definition Check + Risk Tier + Effective Date Sensitivity + Multi-Source Conflict Expected 全部填写。
你的动作:只做人工审核和拍板。

### 选题分流硬规则

满足以下任一条件,题目必须留在深度车道,不允许下沉到普通车道:

- Topic Sheet 中 `Execution Risk = high`
- Topic Sheet 中 `Risk Tier = YMYL` 任一子类(health-YMYL / financial-YMYL / legal-YMYL / safety-YMYL)
- `Need Official-vs-Practical Distinction = yes`,且主题涉及 visa / TRC / tax / insurance / healthcare / banking / legality / compliance
- `Effective Date Sensitivity ≤ 12 months`(规则可能在一年内变化)
- `Multi-Source Conflict Expected = yes`(预期会出现官方和实际操作的冲突)

规则:

- high 就是 deep
- YMYL 就是 deep
- 不存在"先用普通车道试试看"的中间地带
- 不允许为了效率把高风险题强行留在普通车道

### Scope Definition Check(继承 v2.52)

**背景问题**:Topic 名称如果包含具体服务商名称(例如 "Cigna" / "FV Hospital"),GPT 可能把 scope 隐性锁定在该服务商,忽略读者真实的决策空间——读者问 "how to choose health insurance" 时,决策空间包括 BHYT + 国际 expat 保险 + 旅行 nomad 保险 + 雇主保险 + cash pay,不只有某一家保险公司。

**硬规则**:每个 TOPIC SHEET 必须明确列出以下三个字段:

1. **Primary Scope**:文章核心覆盖内容
2. **Adjacent Space**:读者在决策时会对比的外部选项(竞争品、替代方案、同类服务)
3. **Decision on Adjacent**:这些 Adjacent 选项在本文怎么处理,三选一:
   - `included-full`:纳入本文完整 scope(和 Primary 并列展开)
   - `included-brief`:提及对比,但不深入(指向读者自查或未来文章)
   - `omitted`:不涉及(读者需看另一篇)

**判定原则**:

- 如果 topic 的核心问题是 "怎么选 X 类服务"(例如 "怎么选健康保险"),Adjacent 默认应该 `included-full` 或至少 `included-brief`,不能 `omitted`
- 如果 topic 的核心问题是 "某个具体服务怎么用"(例如 "怎么用 SafetyWing"),Primary 就是该服务,Adjacent 可以 `omitted` 或 `included-brief`
- 拿不定时,问:**"读者带着这个问题来,他想看到的是全部选项比较,还是某一个服务的深度指南?"**

### Risk Tier 判定(深度车道独有)

每个 TOPIC SHEET 必须明确 Risk Tier。一个主题可能同时属于多个 Tier:

- **health-YMYL**:涉及健康决策(用药、就医、急诊、手术、慢病管理)
- **financial-YMYL**:涉及金融决策(投资、税务、跨境汇款、资产配置、保险投保)
- **legal-YMYL**:涉及法律状态(身份合法性、签证状态、合同效力、诉讼风险)
- **safety-YMYL**:涉及人身/财产安全(交通、犯罪规避、自然灾害、紧急情况)
- **none-YMYL**:不属于上述任一(如果选这个,大概率应该回到普通车道判定)

Risk Tier 直接决定 Tier 1 来源的强制程度:

- 任何 health-YMYL 主张必须有至少一条 Tier 1(政府卫生部 / 医院官方 / WHO)
- 任何 financial-YMYL 主张必须有至少一条 Tier 1(财政部 / 央行 / 税务总局 / 银行监管)
- 任何 legal-YMYL 主张必须有至少一条 Tier 1(对应主管部委 / 国会 / 法规原文)
- 任何 safety-YMYL 主张必须有至少一条 Tier 1(警方 / 应急管理 / 卫生部紧急通告)

### Effective Date Sensitivity 判定

评估文章核心 claim 中,有多少比例可能在以下时间窗口内变化:

- `≤ 6 months`:极高时效(刚刚改革 / 即将改革 / 试点阶段)
- `≤ 12 months`:高时效(年度政策调整周期内)
- `≤ 24 months`:中时效(中期可能调整)
- `> 24 months`:低时效(基础规则 / 多年稳定)

时效越短,Step 2 调研阶段越要重 cross-check 最新发布日期,Step 3 验证越要更严。

### Multi-Source Conflict Expected 判定

预先判断本主题是否预期会出现官方 vs 实际的冲突。`yes` / `no`。

`yes` 的典型信号:

- 主题涉及"灰色地带"广泛存在的领域(税务 / 跨境 / 灰色就业)
- 法规和实际执法宽严不一致(摩托车头盔执法 / 商家发票合规 / 短租房法律地位)
- 商家宣传与实际兑现差距大(保险理赔实际体验 / 银行 KYC 弹性)
- 不同地区 / 不同部委说法不一致

`yes` 的主题在 Step 3 双跑验证时,Gray-Area Claims 应该多;`no` 的主题在 Step 3 双跑验证时,Gray-Area 可能为零(此时必须在 Validation Pack 中明确说明为什么 zero)。

---

## Step 2:深度调研

输入:TOPIC SHEET(深度版) + AVAILABLE INTERNAL ARTICLES
输出:DEEP RESEARCH PACK
要求:在普通调研的基础上,额外产出 4 类深度信息(Regulatory Source Map / Authority Hierarchy / Conflict Inventory / Eligibility Matrix)。

### 结构完整性硬规则

DEEP RESEARCH PACK 必须包含以下 9 个区块,任一缺失视为不合格:

1. Approved Title / Category / Country / City / Target Reader / Core Search Intent(基础信息)
2. Reader Questions To Answer
3. Recommended Article Angle
4. Suggested Outline
5. **Key Claims Table**(每行 6 字段:Claim / Source URL / Source Type / Why It Matters / Freshness Risk / Official or Practical)
6. **Regulatory Source Map**(深度独有)
7. **Authority Hierarchy**(深度独有)
8. **Conflict Inventory**(深度独有)
9. **Eligibility Matrix**(深度独有)
10. Possible Internal Links(必须使用 AVAILABLE INTERNAL ARTICLES 中的 slug)
11. Potential Weak Spots

### Regulatory Source Map(深度独有)

列出所有可能引用到的法规、决议、通知、决定。每条必须包含:

- 全名(越南语 + 英文)
- 编号
- 颁布机构
- Promulgated date
- Effective date(如果与 promulgated 不同)
- 当前状态(in force / amended by [新法规] / superseded by [新法规] / repealed)
- 替代关系(如果替代了旧法规,列出旧法规编号)

如果某项无法确认,写 `unknown — needs Claude QA verification`。**禁止**编造法规编号或日期。

### Authority Hierarchy(深度独有)

为本主题预先排出权威层级。声明:

- 哪些来源属于 Tier 1(本主题的"最高判官")
- 哪些来源属于 Tier 2-4
- 如果同主题有多个 Tier 1 部委参与,列出它们的优先级关系(例如健康保险:Bộ Y tế > Bảo hiểm Xã hội Việt Nam > Bộ Tài chính)

这个层级会在 Validation 阶段用来判断 claim 的支撑强度。

### Conflict Inventory(深度独有)

预先列出本主题预期会出现的冲突类型。每条必须包含:

- 冲突点(例如 "BHYT 名义覆盖范围 vs 实际报销可获得性")
- Official 立场(例如 "BHYT 覆盖 80% 公立医院常见病")
- Practical 立场(例如 "expat 反映:语言 / 流程 / 实际报销率显著低于 80%")
- 处理方向(在 Draft 阶段如何呈现:include-full / include-brief / acknowledge-only)

如果调研阶段看不到任何冲突点,必须写 `Conflict Inventory: none identified — explain why this topic does not have official-vs-practical divergence`。

### Eligibility Matrix(深度独有)

涉及"谁能用 / 谁不能用 / 什么条件 / 什么排除"类内容时,必须用矩阵呈现,**禁止**用模糊表述代替矩阵。

矩阵必须明确:

- 适用对象(国籍 / 签证类型 / 年龄 / 既往病史 / 居住时长 / 收入 / 其他)
- 各对象对应的:
  - Eligibility(是否符合条件)
  - 条件细则(例如必须满足的前置)
  - 排除项(明确不覆盖的情况)
  - 来源(对应到 Key Claims Table 或 Regulatory Source Map)

不涉及 eligibility 的主题,可以省略此矩阵,但必须在 RESEARCH PACK 末尾明确说明 `Eligibility Matrix not applicable for this topic`。

### 内链使用硬规则

- Possible Internal Links 只能使用 AVAILABLE INTERNAL ARTICLES 中列出的 slug
- 不允许编造不存在的 slug
- 不允许使用 `[DOMAIN]` 这类占位符

### Affiliate 识别(继承 v2.5)

调研阶段必须主动识别本主题与 affiliate 产品的相关性。**深度车道额外要求**:必须评估 affiliate 提及的合规风险(例如保险产品的提及是否触发当地金融广告法规),写在 RESEARCH PACK 的 `Potential Weak Spots` 中。

---

## Step 3:双跑验证

深度车道的 Validation 与普通车道根本不同。普通车道是单跑 adversarial review,深度车道是**双跑对抗**:

- **Step 3a**:Strict 立场跑(假设规则被严格执行,所有"灰色"实际都是违法)
- **Step 3b**:Gray 立场跑(假设广泛存在灰色地带,实际操作显著偏离规则)
- **Step 3c**:合并两跑结果,产出最终 VALIDATION PACK

为什么这样设计:**两个立场对同一个 claim 的判断差异本身就是 Gray-Area 的最强信号**。如果 Strict 跑把某 claim 判 Green,Gray 跑判 Yellow / Red,这条 claim 就是真正的 Gray-Area,不能在 Draft 中压平。

### Step 3a:Strict 立场跑

输入:DEEP RESEARCH PACK
输出:VALIDATION PACK — Strict
要求:用"政府执法严格"的立场审视。所有 claim 必须经得起严格法规执行的检验。任何"实际操作中可以"的论据都被视为不可靠。

### Step 3b:Gray 立场跑

输入:DEEP RESEARCH PACK(同一份)
输出:VALIDATION PACK — Gray
要求:用"实际操作广泛偏离规则"的立场审视。所有 claim 必须考虑"如果灰色操作被突然清理,这个建议会不会害到读者"。任何"官方说法"的论据都不能掩盖实际操作的不确定性。

### Step 3c:合并

输入:VALIDATION PACK — Strict + VALIDATION PACK — Gray
输出:VALIDATION PACK — Final

合并规则:

- 两跑都判 Green 的 claim → Final Green
- 一跑 Green / 一跑 Yellow 的 claim → Final Yellow,且**强制识别为 Gray-Area Claim**(必须在 Draft 中两层呈现)
- 一跑 Green / 一跑 Red 的 claim → Final Red,**禁止进入 Draft**
- 一跑 Yellow / 一跑 Red 的 claim → Final Red,禁止进入 Draft
- 两跑都 Yellow 的 claim → Final Yellow,需要 Drafting 时配合 caveat
- 两跑都 Red 的 claim → omit

### Validation 心态硬规则

- 把 RESEARCH PACK 当成一个过度自信的初级研究员写的
- 默认不奖励"看起来合理"的措辞
- 只奖励真正被支持的 claim
- 有疑问时默认更偏 Yellow,而不是为了方便标 Green
- 如果你发现自己想为了推进流程而把某条 claim 判成 Green,这通常说明它更应该是 Yellow
- **深度车道额外**:任何 YMYL 主张如果没有 Tier 1 来源支持,自动降级为 Yellow,不允许 Green
- **深度车道额外**:任何引用法规如果生效日 > 24 个月前且未确认仍在 force,自动降级为 Yellow

### Gray-Area 完整性硬规则

- Validation 必须主动找 Gray-Area Claims
- 如果 Final 合并后零 Gray-Area Claims,且 TOPIC SHEET 中 `Multi-Source Conflict Expected = yes`,**回到 Step 3a 和 3b 重跑**——这是失败信号,不是成功信号
- 只有当 TOPIC SHEET 中 `Multi-Source Conflict Expected = no` 时,零 Gray-Area 才可接受,且必须在 VALIDATION PACK — Final 中简短说明为什么本主题不存在 rule-vs-enforcement 或 paper-vs-practice 差异

---

## Step 4:Deep Draft

输入:TOPIC SHEET + DEEP RESEARCH PACK + VALIDATION PACK — Final + AVAILABLE INTERNAL ARTICLES
输出:DEEP DRAFT PACKAGE
目标:准确、像 ExpatGuide、像人写的、SEO / GEO 友好,**且强制 Layered Writing**。

### 硬规则

- **深度车道核心权衡:factual robustness 优先于 decision-usefulness**
- 倾向于完整保留法规条件 / 适用范围 / 生效日,即使段落更长
- 只自由使用 Final Green Claims
- Final Yellow Claims 必须配合 caveat wording
- Final Red Claims **禁止**进入正文(即使加 caveat 也不行)
- **Gray-Area Claims 必须 Layered Writing 两层呈现**:
  - Official layer:`According to [法规全名 + 编号 + 生效日], the rule is X.`
  - Practical layer:`In practice, [实际经验 / 灰色操作 / 执法变化] means Y.`
  - **禁止压平为单一推荐**(例如 "通常 OK" 这种语言把 official 和 practical 模糊到一起)
- 首段尽快回答核心问题,但**深度车道可以接受首段比普通车道更长**(用一段而非一句话)
- 小标题匹配真实搜索问题或决策点
- 保持自然,不要写成 SEO-first 或 AI-summary 文
- 内链只能使用 AVAILABLE INTERNAL ARTICLES 中的 slug
- 任何 Tier 1 来源主张必须可追溯到 RESEARCH PACK 的 Key Claims Table
- **法规引用必须三件套齐全**(全名 + 编号 + 生效日)
- 涉及高风险决策的段落必须有非个性化免责语
- 合格线:**85+ 分**(普通车道是 70-80 即可,深度车道更严)

### Layered Writing 详细说明

普通车道允许"通常情况下,X 可以做到 Y"这种压平表述。深度车道**禁止**这种压平。

每个 Gray-Area Claim 必须显式呈现两层:

**反例(压平,深度车道禁止):**

> Foreign expats can usually use BHYT at public hospitals.

**正例(Layered,深度车道要求):**

> Under [BHYT 法规全名 + 编号 + 生效日], foreign workers with valid LD/DT visa and an employment contract are mandatory BHYT participants and entitled to use BHYT-covered services at designated public hospitals. In practice, expat patient experience varies significantly: language barriers at counter, non-acceptance of BHYT at certain wards, and partial reimbursement disputes are commonly reported [link to community discussion or evidence]. For a smoother experience, many expats supplement BHYT with international expat insurance — see our [Health Insurance Choice](/...) guide.

### Decision Data Floor(继承 v2.52)

深度车道仍然适用 Decision Data Floor,但**优先级低于 factual robustness**:

- 当 decision data 与 factual robustness 冲突时,以 factual robustness 优先
- 例如:某保险产品的官方价格列表已经过期,且没有最新公开数据 → 不写一个看似具体的过时价格,改写"price tier varies — request a current quote from the provider, see [authority] for indicative ranges"

但只要 Tier 1-3 来源能支持当前数据,Decision Data Floor 仍然适用,要给:

- 价格区间(保费 / 医疗费用 / 法规规定费率)
- 时效区间(申请处理时间 / 报销周期 / 等待期)
- 落地信息(具体机构 / 部门 / 申请入口 / URL)
- 强制波动 caveat("approximate, varies by..."、"as of [month] 2026")

### Affiliate 平衡策略(继承 v2.5,深度车道额外)

Upper caps(硬上限):

- SafetyWing 最多自然出现一次
- Wise 最多自然出现一次
- World Nomads 不与 SafetyWing 同句

Lower floor(同等重要):

- 不要在自然适配的话题上漏掉 affiliate 提及
- 自然适配场景:跨境汇款 → Wise / 短期医疗保险 → SafetyWing / 冒险运动保险 → World Nomads

**深度车道额外**:

- 涉及保险 / 金融服务的 affiliate 提及,必须有合规 caveat(例如"this is not personalized financial advice; insurance suitability depends on age, health status, length of stay")
- 不允许把 affiliate 产品写成"the best option" 而不展示替代方案——这在深度车道触发"single-vendor lock"失败
- 高风险主题(例如 expat hospitals 推荐)如果只能想到一个 affiliate fit,且该产品是 SafetyWing,**仍然必须先充分展示 BHYT 和其他商业保险选项**,然后在 SafetyWing 自然适配的子场景(短期 / nomad / 冒险)再提及

### Self-Audit(深度车道完整版)

DEEP DRAFT PACKAGE 输出末尾必须包含完整 Self-Audit,**带证据**。Self-Audit 比普通车道多 6 项检查:

```
- year_in_title: pass/fail
  - Title quoted: ...
- sidebar_label_present: pass/fail
  - Sidebar label quoted: "..."
  - Confirm label meets design principles
- scope_completeness: pass/fail
  - Primary Scope in Topic Sheet: "..."
  - Adjacent Space listed in Topic Sheet: "..."
  - Decision on Adjacent: included-full / included-brief / omitted
  - Does the final article's actual coverage match the declared decision?
- decision_data_present: pass/fail
  - Trigger applies? Yes / No
  - If Yes: confirm price ranges / time anchors / where-how-to-access / volatility caveats
- regulatory_citation_completeness: pass/fail (深度独有)
  - List EVERY regulatory reference in the article
  - For each: confirm 全名 + 编号 + 生效日 三件套齐全
  - If any reference missing one or more of these, mark fail and quote the incomplete reference
- effective_date_check: pass/fail (深度独有)
  - For each cited regulation: state the effective date used in the article
  - Confirm: is this regulation still in force as of [draft date]? (yes / unknown — needs Claude QA)
  - If unknown, mark as needing Claude QA verification
- tier1_source_present: pass/fail (深度独有)
  - For each YMYL claim in the article: list the Tier 1 source supporting it
  - If a YMYL claim has no Tier 1 source: mark fail and quote the claim
- layered_writing_preserved: pass/fail (深度独有)
  - For each Gray-Area Claim from VALIDATION PACK — Final: confirm both Official and Practical layers are present in the article
  - Quote the official layer sentence and the practical layer sentence
  - If any Gray-Area Claim is collapsed into a single recommendation: mark fail and quote the collapsed sentence
- legal_safety_disclaimers: pass/fail (深度独有)
  - For each high-stakes decision section (legal status / medical / financial): confirm a non-personal editorial disclaimer is present
  - Quote one example
- affiliate_compliance_check: pass/fail (深度独有)
  - For each affiliate mention: confirm it does not present the affiliate as "the best" without showing alternatives
  - Confirm any insurance/financial affiliate mention has appropriate caveat
- first_person: pass/fail
- banned_words: pass/fail
  - 3 spot-checks (delve / leverage / robust / comprehensive / navigate / nuanced)
- affiliate_limits: pass/fail
- affiliate_opportunity_check: pass/fail
- absolute_internal_links_only: pass/fail
  - List EVERY internal link in markdown source format [text](/path)
  - For each: confirm starts with "/", slug exists in AVAILABLE INTERNAL ARTICLES
- official_vs_practical_distinction: pass/fail
- unsupported_claims_omitted: pass/fail
- no_openai_citation_markers: pass/fail
- markdown_format: pass/fail
- decision_usefulness: pass/fail
  - Even though factual robustness > decision-usefulness in the deep lane, confirm reader still has actionable next step
```

---

## Step 4.5:Claude QA Pass 1

输入:TOPIC SHEET + DEEP RESEARCH PACK + VALIDATION PACK — Final + DEEP DRAFT PACKAGE
输出:CLAUDE QA ISSUE LIST(初次)
工具:Claude with web_fetch enabled

Claude 的 QA 不是普通的语法编辑,是深度车道独有的 4 类对抗性审查。

### Claude QA 的 4 类工作

**1. Tier 1 来源活体验证**

Claude 实际跑 web_fetch 验证每个 Tier 1 来源 URL:

- 该 URL 是否仍然可访问?
- 该 URL 内容是否仍然支持文章中的 claim?
- 该 URL 上的最近更新日期是什么?

不允许"看起来权威就接受"。每个 Tier 1 引用必须用 web_fetch 实际抓一次。

**2. 法规生效日核查**

对每个引用的法规:

- 用 web search / web_fetch 确认该法规当前是否仍在 force
- 是否被新法规替代 / 修订 / 废止?
- 如果有更新版本,新版本的 effective date 是什么?

任何"已被替代但文章引用旧版本"的情况,必须在 ISSUE LIST 中标 Critical。

**3. 对抗性双视角检查**

Claude 必须用两个对立视角分别审视文章:

- **政府发言人视角**:"如果我是相关部委发言人,这篇文章哪些表述会让我觉得不准确 / 误导 / 应该澄清?"
- **被误导读者视角**:"如果我按这篇文章的建议行动,结果违法 / 损失金钱 / 健康受损,我会指出文章哪里害了我?"

两个视角各自产出至少 3 条潜在问题,如果其中任一视角找不到 3 条,Claude 必须明确说明 "no [视角] issues found because [具体原因]",不能简单跳过。

**4. Affiliate 合规审查**

对每个 affiliate 提及:

- 是否触发当地金融 / 医疗 / 保险广告法规?
- 是否在没有完整对比的情况下,把 affiliate 描述为 "the best" / "the safest" / "the most recommended"?
- 是否有适当的合规 caveat?

### Claude QA Prompt 输入要求

为了让 Claude 高效审查,所有输入必须**完整且结构清晰**地粘贴:

- TOPIC SHEET(含 Risk Tier、Adjacent Space、Multi-Source Conflict Expected)
- DEEP RESEARCH PACK(含 Regulatory Source Map、Authority Hierarchy、Conflict Inventory、Eligibility Matrix)
- VALIDATION PACK — Final(含 Gray-Area Claims、双跑差异点)
- DEEP DRAFT PACKAGE(完整 article + Self-Audit)

不允许只粘贴 article 本身。Claude 需要看到 RESEARCH 和 VALIDATION 才能判断 article 是否在"声称的依据"上自洽。

### Claude QA ISSUE LIST 输出格式

每条 ISSUE 必须包含:

- Issue ID(用 CQA-01 / CQA-02 编号)
- Quote(article 原文引用,精确到句)
- Category:`tier1_unverifiable` / `regulation_outdated` / `regulation_superseded` / `gov_pov_overstatement` / `reader_pov_misleading` / `affiliate_compliance` / `layered_writing_collapsed` / `eligibility_ambiguous` / `effective_date_missing` / `other`
- Severity:`Critical` / `High` / `Medium` / `Low`
- Why risky
- Verification source(如果适用,贴 web_fetch 验证的 URL 和发现)
- Minimal fix(具体到改哪个词 / 加哪句话)

如果 Claude 审查后认为没有实质问题,返回:

```
CLAUDE QA ISSUE LIST — Pass 1
- no material issues found
- Verification summary: [简述 Claude 实际跑了哪些 web_fetch 验证 + 结果]
```

但 Claude 必须列出至少 3 个"已检查无问题"的项目作为证据,不允许空头通过。

---

## Step 5:Patch + Final SEO/GEO Pass

输入:DEEP DRAFT PACKAGE + CLAUDE QA ISSUE LIST + (如有)bash check-articles.sh 错误
输出:DEEP FINAL PACKAGE

ISSUE LIST 分两类:

- **CLAUDE QA ISSUES**:深度车道核心修复来源
- **SCRIPT ISSUES**:禁用词、affiliate 次数、内链格式、标题年份、markdown、OpenAI citation marker 等机械检测

### Patch 硬规则

- 只做最小必要修改
- 不重写没问题的段落
- 不引入新 unsupported facts
- 不为了 SEO 再塞新内容
- 不为了"完整"重新变长
- **优先 factual robustness over decision-usefulness**(深度车道反向)
- Patch Changelog 必须逐 issue 映射,不允许笼统写 "improved clarity"
- Patch 后必须再次确认 official vs practical 区分没有被压平
- **Patch 不得破坏原本有效的内链结构**
- **Patch 不得删除 Layered Writing 的两层结构**——如果某个 Gray-Area Claim 在 patch 后只剩单层,patch 失败
- **Patch 必须保留所有法规三件套**(全名 + 编号 + 生效日),不允许为简洁而省略

### Final SEO / GEO Pass

- 改进首段(如果核心答案出现得太晚)
- 收紧小标题(如果模糊或泛化)
- 删除削弱搜索可用性的 filler
- 提升 AI 检索友好性(extractable summary 句)
- 不加关键词堆砌
- 不让文章听起来像模板化内容

但 SEO/GEO pass **不允许删减以下内容**:

- 法规三件套
- Layered Writing 的两层
- Eligibility Matrix 中的具体条件
- 任何免责语

### Final Self-Audit

输出末尾必须包含完整 Final Self-Audit,与 Step 4 同结构,**且新增**:

- `internal_links_preserved`:列出 patch 前后内链对照,确认无破坏
- `gray_area_layered_preserved`:列出 patch 前后所有 Gray-Area Claim 的两层结构对照
- `regulatory_citations_preserved`:列出 patch 前后所有法规引用对照
- `claude_qa_issues_resolved`:逐 ISSUE 标注是否已修复 / 部分修复 / 未修复(并解释理由)

---

## Step 5.5:Claude QA Pass 2

输入:DEEP FINAL PACKAGE + CLAUDE QA ISSUE LIST(Pass 1)
输出:CLAUDE QA ISSUE LIST(Pass 2)

Pass 2 的目标**不是重新审查全文**,而是**确认 patch 没引入新问题** + 处理 Pass 1 残留 ISSUE。

### Pass 2 工作范围

- 对照 Pass 1 的每个 ISSUE,确认 patch 是否真的修复
- 检查 patch 是否引入了新问题(常见模式:为了修一个问题而压平了 Gray-Area / 修内链时改坏了别的内链 / 加 caveat 时引入新 unsupported claim)
- 检查 Pass 1 没覆盖的关键检查项(因为 Pass 1 主要看 article,Pass 2 看 article + patch changelog 配对)

### Pass 2 不做的事

- 不重新跑全文 Tier 1 来源验证(Pass 1 已经做过)
- 不重新做完整双视角审查(Pass 1 已做)
- 不引入 Pass 1 没发现但 Pass 2 才"想到"的新质疑(那应该回到 Pass 1 重做)

### Pass 2 输出格式

```
CLAUDE QA ISSUE LIST — Pass 2

Pass 1 ISSUE Resolution Audit:
- CQA-01: resolved / partial / unresolved + reason
- CQA-02: resolved / partial / unresolved + reason
- ...

New Issues Introduced by Patch (if any):
- Issue ID: CQA-P2-01
- Quote
- Category
- Severity
- Why risky
- Minimal fix

If no new issues:
- "No new issues introduced by patch."
- Final verdict: ready for publication / needs additional patch round
```

如果 Pass 2 出现了 Critical 或 High Severity 的新问题,**回到 Step 5 重新 patch**,然后再跑 Pass 2(直到无 Critical / High 新问题为止)。

如果 Pass 2 反复 ≥ 3 轮还在出新问题,这是 Drafting 阶段结构性失败的信号,应该回到 Step 4 重新 Draft,而不是继续 patch。

---

## 最终通过标准

- 解决的是具体 expat 问题
- 首段尽快回答核心问题(深度车道允许首段比普通车道稍长)
- official vs practical 区分清楚,**Gray-Area Claims 全部 Layered Writing 呈现**
- 所有法规引用三件套齐全(全名 + 编号 + 生效日)
- 每个 YMYL 主张有 Tier 1 来源支持
- 所有 Tier 1 来源经 Claude QA web_fetch 验证
- 没有引用已废止 / 已替代 / 已修订的过期法规
- 所有内链格式合法(以 `/` 开头,slug 存在于清单中)
- Markdown 合规
- 写作规范合规
- SEO/GEO 友好但不显得 SEO-first
- 读起来像参考页,不像 AI 内容,也不像 blog
- Affiliate 合规检查通过
- Claude QA Pass 2 无 Critical / High 新问题

---

## 不该使用深度车道的情况

| 主题特征 | 应走哪条车道 |
|---|---|
| 文化常识、生活技巧、季节建议 | 普通 |
| 纯产品/服务对比,无法规风险 | 普通 |
| 城市概览、生活成本汇总 | 普通 |
| 介绍性内容(介绍越南有什么药店连锁) | 普通 |
| 指导性内容(如何选购特定药品) | 深度 |
| 介绍性内容(越南医疗体系概览) | 普通(但 healthcare 板块谨慎边界) |
| 指导性内容(具体医院推荐 / 急诊处理) | 深度 |

边界判断原则:**当读者按文章建议行动后,可能产生不可逆/高代价后果(身份违法、医疗误判、金钱损失)时,走深度。否则走普通。**

---

## Prompt 1:Topic Proposal(深度车道)

```text
HARD RULES
- no first person (exception: "our" + internal link references, and reader-perspective FAQ headings, are allowed)
- year in title
- absolute internal links only
- banned words list applies
- use ranges for prices unless explicitly verified
- affiliate caps apply
- regulatory references must include 全名 + 编号 + effective date

You are helping plan editorial topics for ExpatGuide's deep lane.

About the site:
- ExpatGuide is a community-sourced reference site for expats
- It is not a personal blog
- It must remain anonymous
- Good content helps readers solve concrete expat problems and leave
- Strong articles distinguish:
  1) what official rules say (with regulation 全名 + 编号 + effective date)
  2) how things are actually executed on the ground

About the deep lane:
- Reserved for high-stakes topics: visa / TRC / tax / insurance / healthcare / banking compliance / legality
- factual robustness > decision-usefulness when conflict
- Every YMYL claim must trace to a Tier 1 source
- Multi-source conflicts (official vs practice) must be surfaced, not collapsed

Task:
Generate topic proposals for the deep lane scope below.

Scope:
[PASTE COUNTRY / CITY / CATEGORY / BOARD]

Goal:
[PASTE YOUR GOAL, e.g. find 5 high-priority deep lane topics for the Healthcare board, prioritize 2026 reform-affected topics]

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
- For deep lane: prefer topics where regulatory references are well-defined and traceable

Routing rule (for deep lane confirmation):
- This proposal is intended for the deep lane
- All proposed topics must satisfy at least ONE of:
  - Execution Risk = high
  - Risk Tier = YMYL (any subtype)
  - Need Official-vs-Practical Distinction = yes AND involves visa/TRC/tax/insurance/healthcare/banking/legality
  - Effective Date Sensitivity ≤ 12 months
  - Multi-Source Conflict Expected = yes
- If a proposed topic does not meet any of these, flag it as "should be normal lane" and skip

Return exactly this format for each proposal:

TOPIC SHEET (Deep)
Title:
Category:
Country/City:
Article Type: deep
Target Reader:
Core Search Intent:
Why This Topic Matters:
Need Official-vs-Practical Distinction: yes / no
Execution Risk: low / medium / high
Risk Tier: health-YMYL / financial-YMYL / legal-YMYL / safety-YMYL / multiple ([list]) / none-YMYL
Effective Date Sensitivity: ≤6 months / ≤12 months / ≤24 months / >24 months
Multi-Source Conflict Expected: yes / no
Why It Fits ExpatGuide Deep Lane:
What Would Make It Better Than Generic SEO Content:

Scope Definition Check:
Primary Scope:
Adjacent Space:
Decision on Adjacent: included-full / included-brief / omitted

Suggested Internal Links (must use only slugs from AVAILABLE INTERNAL ARTICLES):
- ...
- ...

At the end, include:
1. Best 3 must-write deep topics (highest reader stakes)
2. Best 3 reform-sensitive topics (high effective-date sensitivity)
3. Best 3 conflict-rich topics (highest multi-source conflict expected — best stress test for deep lane)
```

---

## Prompt 2:Deep Research Pack

```text
HARD RULES
- no first person (exception: "our" + internal link references, and reader-perspective FAQ headings, are allowed)
- year in title
- absolute internal links only (must start with "/", not "http", not "[" placeholder)
- internal link slugs MUST appear in AVAILABLE INTERNAL ARTICLES
- banned words list applies
- use ranges for prices unless explicitly verified
- affiliate caps apply
- every regulatory reference must include 全名 + 编号 + effective date

You are preparing a DEEP research pack for an ExpatGuide deep lane article.

About the site:
- ExpatGuide is a neutral reference site for expats
- It is not a personal blog
- It must remain anonymous
- Content should help readers solve concrete expat problems
- It should distinguish official information from real-world execution

About the deep lane:
- Reserved for high-stakes / YMYL topics
- factual robustness > decision-usefulness
- Every YMYL claim must have at least one Tier 1 source
- Multi-source conflicts must be surfaced, not collapsed

Tier definitions (use these throughout):
- Tier 1: Official one-source (.gov.vn / Bộ Y tế / Bộ Tài chính / Ngân hàng Nhà nước / 官方公告 / 法规原文)
- Tier 2: Major media + large industry institutions (VnExpress, VNA, Tuoi Tre, Reuters, Bloomberg, Big 4 Vietnam tax/legal alerts)
- Tier 3: Industry institutions + commercial providers (insurance company sites, large law firms, Chamber of Commerce)
- Tier 4: Community + individual experience (Facebook, Reddit, blogs, forums)

Task:
Build a DEEP research pack for the approved topic below.
Do not draft the article yet.

APPROVED TOPIC SHEET:
[PASTE ONE SELECTED TOPIC SHEET]

AVAILABLE INTERNAL ARTICLES:
[PASTE CONTENTS OF Research/internal-articles-index.md]

Requirements:
- Identify the main user questions this article must answer
- Identify the main claims the article would need
- Separate official information from practical/on-the-ground information
- Be careful with stale, unsupported, or anecdotal claims
- Do not invent laws, regulations, case examples, dates, agencies, or provider claims
- If pricing/costs vary, treat them cautiously
- For affiliate: identify any natural fit and add it as a Key Claim or note it under Known Variation Points

Mandatory deep-lane sections (must all appear, marked unknown if data missing — never omit a section):

1. Approved Title / Category / Country / City / Target Reader / Core Search Intent
2. Reader Questions To Answer
3. Recommended Article Angle
4. Suggested Outline
5. Key Claims Table (each row 6 fields: Claim / Source URL / Source Type / Why It Matters / Freshness Risk / Official or Practical)
6. Regulatory Source Map (every relevant regulation: 全名 / 编号 / 颁布机构 / promulgated date / effective date / current status / supersedes-relationship)
7. Authority Hierarchy (declare which sources are Tier 1/2/3/4 for this specific topic; if multiple Tier 1 ministries are involved, declare priority)
8. Conflict Inventory (predicted official-vs-practical conflicts; for each: official position / practical position / handling direction)
9. Eligibility Matrix (if topic involves who-can-use / conditions / exclusions; mandatory matrix not prose; if not applicable, state "not applicable for this topic")
10. Possible Internal Links (must match slugs in AVAILABLE INTERNAL ARTICLES)
11. Potential Weak Spots (include affiliate compliance risk if applicable)

Return exactly this format:

DEEP RESEARCH PACK

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
  Source Type: Tier 1 / Tier 2 / Tier 3 / Tier 4 / unknown
  Why It Matters:
  Freshness Risk: low / medium / high / unknown
  Official or Practical: official / practical / mixed / unknown

Regulatory Source Map:
- 全名 (English):
  全名 (Vietnamese original):
  编号:
  颁布机构:
  Promulgated date:
  Effective date:
  Current status: in force / amended by [...] / superseded by [...] / repealed / unknown
  Supersedes: [previous regulation if applicable]
- ... (more as needed)

Authority Hierarchy (for this topic):
- Tier 1 (highest authority):
  - ...
  - ... (priority order if multiple)
- Tier 2:
  - ...
- Tier 3:
  - ...
- Tier 4 (use only as practical-layer signal):
  - ...

Conflict Inventory:
- Conflict point:
  Official position:
  Practical position:
  Handling direction: include-full / include-brief / acknowledge-only

(If zero conflicts identified:)
Conflict Inventory: none identified
- Justification for zero conflicts: ...

Eligibility Matrix:
| Subject | Eligibility | Conditions | Exclusions | Source |
|---|---|---|---|---|
| ... | ... | ... | ... | ... |

(If not applicable:)
Eligibility Matrix: not applicable for this topic
- Reason: ...

Possible Internal Links (must match slugs in AVAILABLE INTERNAL ARTICLES):
- ...
- ...

Potential Weak Spots:
- ...
- ... (include affiliate compliance risk if applicable)

Do not draft prose paragraphs.
Do not write the final article.
```

---

## Prompt 3a:Validation Strict 立场跑

```text
HARD RULES
- no first person (exception: "our" + internal link references, and reader-perspective FAQ headings, are allowed)
- year in title
- absolute internal links only
- banned words list applies
- use ranges for prices unless explicitly verified
- affiliate caps apply

You are the validation layer for an ExpatGuide DEEP lane article.
This is the STRICT-stance pass.

Stance: assume regulations are strictly enforced. Any "in practice it's flexible" reasoning is unreliable. Every claim must withstand strict regulatory enforcement.

Task:
Audit the DEEP research pack below from the strict-stance perspective.
Do not draft the final article yet.

DEEP RESEARCH PACK:
[PASTE FULL DEEP RESEARCH PACK]

Strict-stance validation rules:
- Adversarial mindset required
- Treat the research pack as if it was written by an overconfident drafter
- Do not reward plausible wording; reward only adequately supported claims
- Default-bias toward Yellow over Green when in doubt
- If you find yourself wanting to mark something Green out of convenience, that is a signal to mark it Yellow
- Your job is not to preserve draft momentum; your job is to catch overclaiming
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
  - any "usually OK" language for regulatory matters

Strict-stance hard rules (deep lane):
- Any YMYL claim without a Tier 1 source: automatic Yellow (cannot be Green under strict stance)
- Any regulation cited without 全名 + 编号 + effective date: automatic Yellow
- Any regulation with effective date > 24 months ago and not confirmed still in force: automatic Yellow
- Any "in practice [readers can / authorities don't enforce]" reasoning: under strict stance, this is Yellow at best, Red if it's the only support for a YMYL claim
- Tier 4 sources alone (community / forum) cannot support an Official-layer claim under strict stance: automatic Red

Gray-Area completeness rule:
- Actively look for claims where official rule and on-the-ground execution diverge
- Under strict stance, default to "official rule applies" — if the article tries to lean on practical leniency, mark Gray-Area-Strict

Return exactly this format:

VALIDATION PACK — STRICT

Approved Title:
Category:
Stance: Strict (regulations strictly enforced)

Green Claims (under strict stance):
- Claim:
  Why safe under strict stance:
  Wording guidance:

Yellow Claims (under strict stance):
- Claim:
  Risk under strict stance:
  Safer wording:

Red Claims (under strict stance):
- Claim:
  Why unsafe under strict stance:
  Action: omit / re-check / mention only cautiously

Gray-Area-Strict Claims (where strict stance reveals official-vs-practical divergence):
- Claim:
  Official position (strict reading):
  Where the article currently relies on practical leniency:
  Drafting guidance under strict stance:

(If zero Gray-Area-Strict identified:)
Gray-Area-Strict: none — justify why this topic doesn't require strict-stance flagging

Strict-stance specific concerns:
- Tier 1 source gaps: list every YMYL claim missing Tier 1 support
- Regulatory citation incomplete: list every regulation missing 全名/编号/effective date
- Outdated regulation risk: list every regulation needing effective-date verification

Open Questions (strict stance):
- ...

Do not write the full article.
Do not produce the merged Validation Pack — that's Step 3c.
```

---

## Prompt 3b:Validation Gray 立场跑

```text
HARD RULES
- no first person (exception: "our" + internal link references, and reader-perspective FAQ headings, are allowed)
- year in title
- absolute internal links only
- banned words list applies
- use ranges for prices unless explicitly verified
- affiliate caps apply

You are the validation layer for an ExpatGuide DEEP lane article.
This is the GRAY-stance pass.

Stance: assume widespread practical deviation from official rules. "Official rule says X" is necessary but not sufficient — readers will encounter actual operations that may differ significantly. Any "the official rule is [X], so the answer is [X]" reasoning is unreliable without addressing what actually happens.

Task:
Audit the DEEP research pack below from the gray-stance perspective.
Do not draft the final article yet.

DEEP RESEARCH PACK:
[PASTE FULL DEEP RESEARCH PACK — same input as Prompt 3a]

Gray-stance validation rules:
- Adversarial mindset required (different from strict — here you're suspicious of clean official narratives)
- Treat the research pack as if a strict reader wrote it and forgot real-world execution
- Default-bias toward Yellow when official claim is not corroborated by practical evidence
- If a claim sounds clean and official without any practical layer support: this is a signal it might be Gray-Area
- Watch for:
  - claims that hold "on paper" but unclear in execution
  - regulations that are routinely under-enforced
  - regulations that are routinely over-enforced (against expats specifically)
  - business marketing / official claims of coverage that don't match user experience
  - regional variance not surfaced
  - sub-population variance not surfaced (e.g., rules different for foreign-passport vs Vietnamese)

Gray-stance hard rules (deep lane):
- Any official claim not corroborated by at least one practical-layer source (Tier 2-4): mark Gray-Area-Gray
- Any "the rule says X" without addressing "in practice readers will encounter Y": mark Gray-Area-Gray
- Any single-Tier-1 claim where Tier 2-4 sources contradict: mark Yellow at minimum
- If practical sources (Tier 4) report consistent deviation from official rule: this is Gray-Area, not "anecdotal noise"

Gray-Area completeness rule (gray stance):
- Actively look for claims where the article would mislead by presenting only the official side
- Under gray stance, the question is "would a reader following this article be surprised by reality?"
- If yes: Gray-Area-Gray

Return exactly this format:

VALIDATION PACK — GRAY

Approved Title:
Category:
Stance: Gray (widespread practical deviation assumed)

Green Claims (under gray stance):
- Claim:
  Why safe under gray stance (i.e., official AND practical aligned):
  Wording guidance:

Yellow Claims (under gray stance):
- Claim:
  Risk under gray stance:
  Safer wording:

Red Claims (under gray stance):
- Claim:
  Why unsafe under gray stance:
  Action: omit / re-check / mention only cautiously

Gray-Area-Gray Claims (where gray stance reveals practical-side risk the article underweights):
- Claim:
  Official position (as currently in research pack):
  Practical reality (gray-stance reading):
  Drafting guidance under gray stance:

(If zero Gray-Area-Gray identified:)
Gray-Area-Gray: none — justify why this topic doesn't have practical-side under-coverage

Gray-stance specific concerns:
- Practical evidence gaps: list every claim that lacks Tier 2-4 corroboration
- Regional variance not surfaced: list any topic where region matters but research pack treats Vietnam as uniform
- Sub-population variance: list any topic where foreign-passport readers face different reality

Open Questions (gray stance):
- ...

Do not write the full article.
Do not produce the merged Validation Pack — that's Step 3c.
```

---

## Prompt 3c:Validation 双跑合并

```text
HARD RULES
- no first person (exception: "our" + internal link references, and reader-perspective FAQ headings, are allowed)
- year in title
- absolute internal links only
- banned words list applies
- use ranges for prices unless explicitly verified
- affiliate caps apply

You are merging two stance-validation passes for an ExpatGuide deep-lane article.

Inputs:

VALIDATION PACK — STRICT:
[PASTE FULL STRICT PACK]

VALIDATION PACK — GRAY:
[PASTE FULL GRAY PACK]

Merge rules:
- Both Green → Final Green
- One Green / one Yellow → Final Yellow, AND mark as Gray-Area Claim (must be layered in Draft)
- One Green / one Red → Final Red, OMIT from Draft
- One Yellow / one Red → Final Red, OMIT from Draft
- Both Yellow → Final Yellow, requires careful caveat in Draft
- Both Red → omit
- Either pass marks Gray-Area (Strict or Gray) → Final Gray-Area Claim, MUST be Layered Writing in Draft

Why this merge logic exists:
- Two stances disagreeing IS the strongest signal of true Gray-Area
- The disagreement is the value, not noise
- Do not "average" the two stances — preserve the disagreement explicitly

Return exactly this format:

VALIDATION PACK — FINAL (Merged)

Approved Title:
Category:
Merge basis: VALIDATION PACK — STRICT + VALIDATION PACK — GRAY

Final Green Claims (both stances Green):
- Claim:
  Why safe in both stances:
  Wording guidance:

Final Yellow Claims (one Green / one Yellow OR both Yellow):
- Claim:
  Risk pattern:
  Source of Yellow:  strict-stance / gray-stance / both
  Safer wording:
  Is this also a Gray-Area Claim? yes / no

Final Red Claims (any Red trigger):
- Claim:
  Why Red:
  Source of Red: strict-stance / gray-stance / both
  Action: omit from Draft entirely

Final Gray-Area Claims (REQUIRED layered writing in Draft):
- Claim:
  Official layer (from strict stance):
  Practical layer (from gray stance):
  Why this is true Gray-Area:
  Drafting requirement: Both layers MUST appear in Draft. NOT to be collapsed.

(If zero Final Gray-Area Claims AND TOPIC SHEET says Multi-Source Conflict Expected = yes:)
ESCALATION: zero Gray-Area Claims after both stance passes contradicts Topic Sheet expectation.
Recommend: re-run Strict and Gray passes with explicit attention to [list specific conflict types from Topic Sheet].
DO NOT proceed to Draft until Gray-Area inventory matches Topic Sheet expectation OR Topic Sheet is revised.

(If zero Final Gray-Area Claims AND TOPIC SHEET says Multi-Source Conflict Expected = no:)
Final Gray-Area Claims: none — confirmed consistent with Topic Sheet
- Justification: ...

Open Questions (merged):
- ...

Drafting Guidance (synthesized):
- Must emphasize:
  - ...
- Must phrase cautiously:
  - ...
- Must avoid:
  - ...
- Layered writing required for these specific claims:
  - ...

Do not write the full article.
```

---

## Deep Draft Prompt(深度文章起草)

```text
HARD RULES
- no first person (exception: "our" + internal link references, and reader-perspective FAQ headings like "Can I..." are allowed)
- year in title
- absolute internal links only (must start with "/", not "http", not "[" placeholder)
- internal link slugs MUST appear in AVAILABLE INTERNAL ARTICLES
- banned words list applies
- use ranges for prices unless explicitly verified
- affiliate caps apply
- regulatory references must include 全名 + 编号 + effective date
- factual robustness > decision-usefulness when conflict
- Layered Writing required for all Final Gray-Area Claims (Official layer + Practical layer, never collapsed)

You are writing a publish-ready markdown draft for a high-stakes ExpatGuide deep-lane article.

About the site:
- ExpatGuide is a community-sourced reference site for expats
- It is not a personal blog
- It must remain anonymous
- It should help readers solve a concrete problem
- It distinguishes official rules from practical execution

About the deep lane:
- factual robustness > decision-usefulness
- Every YMYL claim has a Tier 1 source
- All Final Gray-Area Claims are Layered Writing (Official + Practical, both visible)
- Regulatory references include 全名 + 编号 + effective date

Inputs:

TOPIC SHEET:
[PASTE APPROVED TOPIC SHEET — Deep version with Risk Tier / Effective Date Sensitivity / Multi-Source Conflict / Scope Definition Check]

DEEP RESEARCH PACK:
[PASTE FULL DEEP RESEARCH PACK including Regulatory Source Map / Authority Hierarchy / Conflict Inventory / Eligibility Matrix]

VALIDATION PACK — FINAL (Merged):
[PASTE FULL MERGED VALIDATION PACK]

AVAILABLE INTERNAL ARTICLES:
[PASTE CONTENTS OF Research/internal-articles-index.md]

Writing rules:
- Title must include year
- All internal links must start with "/" (absolute path); no external URLs for internal references, no placeholders
- All internal link slugs MUST appear in AVAILABLE INTERNAL ARTICLES
- No first person (with stated exceptions)
- No self-referential writing
- No identity reveal
- Tone must be neutral, practical, reference-style
- Do not write like a lifestyle blog
- If cost/rent/price data varies, use ranges
- Data source notes in italic small-text style
- Distinguish official information from practical/on-the-ground variation

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
- comprehensive — ALLOW for precise scope ("comprehensive insurance covers X, Y, Z"). BAN as vague self-praise
- robust — ALLOW for engineering/technical (encryption, infrastructure). BAN for abstract systems
- nuanced — ALLOW only when followed by specific differentiation. BAN as standalone descriptor
- crucial — ALLOW for true objective necessity. BAN as generic emphasis

Rule for banned wording:
- Hard-banned words: replace with plainer wording, no exceptions
- Context-sensitive words: keep ONLY if usage matches the ALLOW description
- When in doubt, ask: would a plainer substitute lose specific meaning? If no, the word is filler — replace it

CRITICAL: No OpenAI internal citation markers in output
- NEVER leave OpenAI internal citation markers in the final article
- These include but are not limited to:
  - `:contentReference[oaicite:XX]{index=XX}` style markers
  - Anything containing `oaicite`
  - Anything containing `{index=`
  - `【...】` source-tag brackets auto-generated by search tools
- These markers appear when GPT uses web search and then wraps output in a markdown code block
- Before outputting the Final Article inside a markdown code block, manually scan and remove
- If a sentence relied on such a marker for attribution: convert to a plain inline link OR remove the marker and keep prose

Layered Writing Rule (HARD — deep lane core):

For every Final Gray-Area Claim from VALIDATION PACK — FINAL, the article MUST present BOTH layers:

1. Official layer:
   - State what the rule says
   - Cite the regulation: 全名 + 编号 + effective date
   - Use phrasing like: "Under [regulation], the rule is X."
   - Or: "According to [authority], [official position]."

2. Practical layer:
   - State what readers actually encounter
   - Use phrasing like: "In practice, [actual experience/variance/enforcement pattern]."
   - Or: "On the ground, [practical reality]."
   - If practical layer is supported only by Tier 4 (community), explicitly frame: "Expat community reports indicate..."

DO NOT collapse the two layers into a single recommendation. Examples:

❌ "Foreign expats can usually use BHYT at public hospitals." (collapsed — single statement that hides the divergence)

✓ "Under [BHYT 法规 + 编号 + effective date], foreign workers with valid LD/DT visa and an employment contract are mandatory BHYT participants. In practice, expat patient experience varies: language barriers at counter, non-acceptance of BHYT at certain wards, and partial reimbursement disputes are commonly reported in expat communities. For a smoother experience, many expats supplement BHYT with international expat insurance — see our [Health Insurance Choice](/...)." (layered — both visible, not collapsed)

Decision Data Floor (deep lane — applies but lower priority than factual robustness):

Trigger: this rule activates when the article's core question involves choosing between concrete options.

When triggered, include:
1. Price ranges (not exact numbers)
2. Time/duration anchors
3. Where/how to access (specific names, locations, URLs)
4. Mandatory caveat on volatile data ("approximate, varies by..." or "as of [month] 2026")

Deep-lane override: if Tier 1 source for current pricing/timing data is unavailable or expired, do NOT invent a number. Replace specific number with: "current [price/time] requires direct quote from [provider]; indicative range based on [last available source, dated]."

Affiliate rules (v2.5 balanced + deep-lane compliance):

Upper caps:
- SafetyWing max one natural mention
- Wise max one natural mention
- World Nomads not in same sentence as SafetyWing

Lower floor:
- Do not omit when product is a natural answer to the reader's question
- Natural-fit scenarios: cross-border money → Wise; short-stay nomad medical → SafetyWing; adventure/high-risk → World Nomads

Deep-lane affiliate compliance additions:
- Do NOT present any single affiliate product as "the best" / "the safest" / "the most recommended" without showing alternatives
- Insurance / financial affiliate mentions MUST include a non-personal editorial caveat: e.g., "Suitability depends on age, health status, length of stay; consult a licensed insurance professional for your specific situation."
- For high-stakes topics (e.g., expat hospital recommendations), even if SafetyWing is a natural fit, the article must FIRST fully present BHYT and other commercial insurance options, THEN mention SafetyWing in its specific natural sub-context (short-term / nomad / adventure)
- Affiliate mentions cannot satisfy the YMYL Tier 1 source requirement — affiliate provider claims about their own coverage do not count as Tier 1

Deep-article drafting rules (priority — factual robustness):
- Use Final Green Claims freely
- Use Final Yellow Claims only with cautious wording
- Do NOT use Final Red Claims as factual statements
- Final Gray-Area Claims MUST be Layered Writing (Official + Practical, both visible)
- Omit unsupported claims
- Never fabricate a source, regulation, company policy, or anecdote
- When official rules and real-world practice diverge, surface the difference clearly via Layered Writing
- When scope, eligibility, effective dates, or enforcement vary, surface those conditions explicitly
- Do not flatten gray areas into certainty
- Keep wording precise and non-dramatic
- Prefer practical clarity over flourish
- Avoid generic filler, scene-setting fluff, empty transitions
- Write like a strong human editor, not like an AI summarizer
- Vary sentence length naturally
- Do not use repetitive "expat-friendly" filler language
- Do not pad sections to make them longer
- Err on the side of including the legal, regulatory, procedural, or eligibility condition even if it makes the section longer
- Include non-personal editorial disclaimers in high-stakes decision sections (legal status / medical / financial)

SEO / GEO requirements:
- Satisfy the primary search intent clearly and early
- Cover the most likely follow-up questions naturally
- Make section headings specific, useful, retrieval-friendly
- Answer the core question directly in the introduction (deep lane: intro can be a paragraph, not just one sentence)
- Include concise, extractable summary sentences where helpful
- Make article easy for search engines and AI systems to interpret, quote, summarize
- Optimize for usefulness, clarity, retrievability without sounding robotic
- Avoid keyword stuffing
- Avoid obvious "SEO article" or "AI-generated summary" phrasing
- Structure article so both humans and AI systems can identify:
  - the main answer
  - the key caveats
  - the practical decision points
  - the legal/policy conditions
- Use headings that match real user questions or decision points
- Where useful, front-load the answer before nuance
- Where official rules and real-world practice differ, state the difference clearly

Markdown requirements:
- Output valid markdown
- Use clear heading hierarchy
- Use bullet points only when they genuinely improve clarity
- Do not over-list everything
- Keep formatting clean and publication-ready

FINAL HARD RULES CHECK BEFORE WRITING:
- no first person (with stated exceptions)
- year in title
- all internal links start with "/" and use only AVAILABLE slugs
- banned words list applies
- use ranges for prices unless explicitly verified
- affiliate caps apply
- regulatory references include 全名 + 编号 + effective date
- Layered Writing for all Gray-Area Claims (no collapse)
- factual robustness over decision-usefulness when conflict
- Tier 1 source for every YMYL claim

Return exactly this format:

DEEP DRAFT PACKAGE

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

# Article
[full markdown article — starts directly with first ## heading, no H1, no duplicate frontmatter]

# Internal Links Used
- ...
- ...

# Affiliate Mentions Used
- ...
- or "none"

# Regulatory References Used
- 全名 (English) | 编号 | Effective Date | Where cited in article (section name)
- ...

# Tier 1 Sources Cited
- Source URL | Supporting which YMYL claim
- ...

# Layered Writing Inventory (Final Gray-Area Claims)
- Gray-Area Claim:
  Official layer location in article: [section name]
  Practical layer location in article: [section name]
- ...

# Source Risk Notes
- ...
- ...

# SEO/GEO Notes
- Primary search intent addressed: yes/no
- Main follow-up questions covered: yes/no
- Introduction answers the core query: yes/no
- Headings are search-clear and retrieval-friendly: yes/no
- Article includes extractable summary lines where helpful: yes/no
- Writing avoids keyword stuffing and AI-sounding filler: yes/no

# Self-Audit (evidence required)
- year_in_title: pass/fail
  - Title quoted: ...
- sidebar_label_present: pass/fail
  - Sidebar label quoted: "..."
  - Confirm label meets design principles
- scope_completeness: pass/fail
  - Primary Scope in Topic Sheet: "..."
  - Adjacent Space listed: "..."
  - Decision on Adjacent: included-full / included-brief / omitted
  - Match between Topic Sheet declaration and article actual coverage: pass/fail with evidence
- decision_data_present: pass/fail
  - Trigger applies? Yes / No
  - If Yes: confirm price ranges / time anchors / access info / volatility caveats with one quote each
- regulatory_citation_completeness: pass/fail
  - List EVERY regulatory reference in article
  - For each: quote 全名 + 编号 + effective date
  - If any missing one or more: mark fail and quote the incomplete reference
- effective_date_check: pass/fail
  - For each cited regulation: state effective date
  - State whether still in force (yes / unknown — needs Claude QA verification)
- tier1_source_present: pass/fail
  - For each YMYL claim: list the supporting Tier 1 source URL
  - If any YMYL claim lacks Tier 1: mark fail and quote the claim
- layered_writing_preserved: pass/fail
  - For each Final Gray-Area Claim from VALIDATION PACK: confirm both layers present
  - Quote the Official layer sentence and Practical layer sentence
  - If any collapsed: mark fail and quote the collapsed sentence
- legal_safety_disclaimers: pass/fail
  - For each high-stakes decision section: quote the disclaimer
- affiliate_compliance_check: pass/fail
  - For each affiliate mention: confirm not "the best" without alternatives
  - Confirm insurance/financial mention has caveat
- first_person: pass/fail
  - If pass: quote 2 random sentences showing publication voice
  - If fail: quote every first-person instance
- banned_words: pass/fail
  - 3 spot-checks (delve / leverage / robust / comprehensive / navigate / nuanced)
- affiliate_limits: pass/fail
  - Count: SafetyWing = X, Wise = Y, World Nomads = Z, others = ...
- affiliate_opportunity_check: pass/fail
  - Natural fit exists? yes/no
  - If yes and not included: state which affiliate, why fit, where it would go
- absolute_internal_links_only: pass/fail
  - List EVERY internal link with the FULL markdown source format [text](/path)
  - For each: confirm starts with "/", slug exists in AVAILABLE INTERNAL ARTICLES
  - If you cannot quote the [text](/path) source for a link, that means the link was not actually written into the article — that is a fail
- official_vs_practical_distinction: pass/fail
  - Quote 1-2 lines where the distinction is surfaced
- unsupported_claims_omitted: pass/fail
  - List all time-sensitive prices / fees / wait times / validity periods / volatile numbers
  - Mark each as verified / range / unsupported
- no_openai_citation_markers: pass/fail
  - Scan for: :contentReference / oaicite / {index= / unreplaced 【...】
- markdown_format: pass/fail
- decision_usefulness: pass/fail
  - Even though factual robustness > decision-usefulness in deep lane, confirm reader has actionable next step
```

---

## Claude QA Prompt — Pass 1

```text
You are the deep-lane Claude QA Pass 1 for an ExpatGuide article.

Your role is NOT to copyedit. It is to:
1. Verify Tier 1 sources are real and still support the cited claims (use web_fetch)
2. Verify regulatory effective dates and current status (use web search / web_fetch)
3. Apply adversarial dual-perspective review (government spokesperson + misled reader)
4. Audit affiliate placements for compliance risk

Do not redo the full research.
Do not rewrite the article.
Do not introduce new unsupported facts.

About the site:
- ExpatGuide is a neutral reference site for expats
- It is not a personal blog
- It must remain anonymous
- It distinguishes official rules from practical execution
- Deep lane prioritizes factual robustness over decision-usefulness

Inputs:

TOPIC SHEET (Deep):
[PASTE APPROVED TOPIC SHEET]

DEEP RESEARCH PACK:
[PASTE FULL DEEP RESEARCH PACK]

VALIDATION PACK — FINAL:
[PASTE FULL MERGED VALIDATION PACK]

DEEP DRAFT PACKAGE:
[PASTE FULL DRAFT PACKAGE INCLUDING SELF-AUDIT]

Your 4 work areas:

1. Tier 1 Source Live Verification
   - For every Tier 1 source cited in the article: actually run web_fetch on the URL
   - For each: confirm URL still accessible, content still supports the claim, last update date
   - Do NOT accept "looks authoritative" — must verify live
   - Flag any URL that 404s, has been moved, or whose content no longer supports the claim

2. Regulatory Effective Date Check
   - For each regulation cited: confirm whether still in force as of today
   - Use web search / web_fetch to find latest status
   - Flag any regulation that has been: amended / superseded / repealed / under review
   - If amended, identify the new effective date and the changes

3. Adversarial Dual-Perspective Review
   - Government Spokesperson Perspective: "If I represented [relevant ministry], which sentences in this article would I find inaccurate, misleading, or in need of clarification?"
   - Misled Reader Perspective: "If I followed this article's advice and ended up violating regulations, losing money, or harming my health, which sentences would I point to as having misled me?"
   - Each perspective must produce at least 3 candidate issues
   - If a perspective genuinely produces zero issues, explicitly state: "no [perspective] issues found because [specific reason]"
   - Do not skip a perspective without justification

4. Affiliate Compliance Audit
   - For each affiliate mention: does it trigger any local financial/medical/insurance advertising regulations?
   - Is the affiliate presented as "the best" / "the safest" / "the most recommended" without alternatives?
   - Is appropriate caveat present?

Verification source disclosure:
- For every flagged issue, disclose the verification source (web_fetch URL, search result, etc.)
- If you did not verify externally, say so explicitly

Severity levels:
- Critical: factual error / outdated regulation cited as current / Tier 1 source unverifiable / YMYL misdirection
- High: Layered Writing collapse / affiliate compliance risk / significant overstatement
- Medium: phrasing that overstates without changing core meaning / minor source-strength issue
- Low: stylistic clarity that affects but doesn't break factual robustness

Return exactly this format:

CLAUDE QA ISSUE LIST — Pass 1

Verification Summary:
- Tier 1 URLs verified: [count] / [total]
- Regulations checked for current status: [count] / [total]
- Government perspective issues found: [count]
- Reader perspective issues found: [count]
- Affiliate mentions audited: [count]

Issues:

Issue:
- Issue ID: CQA-01
- Quote: [exact sentence from article]
- Category: tier1_unverifiable / regulation_outdated / regulation_superseded / gov_pov_overstatement / reader_pov_misleading / affiliate_compliance / layered_writing_collapsed / eligibility_ambiguous / effective_date_missing / other
- Severity: Critical / High / Medium / Low
- Why risky:
- Verification source: [URL fetched / search performed / N/A with reason]
- Minimal fix:

Issue:
- Issue ID: CQA-02
- ... (same format)

If no material issues found:
CLAUDE QA ISSUE LIST — Pass 1
- no material issues found
- Verification summary: [as above, with at least 3 example "checked and OK" items as evidence]
- Final verdict: ready for Pass 5 (final SEO/GEO + minimal patch)
```

---

## Prompt 5:Patch + Final SEO/GEO Pass(深度车道)

```text
HARD RULES
- no first person (exception: "our" + internal link references, and reader-perspective FAQ headings, are allowed)
- year in title
- absolute internal links only
- banned words list applies
- use ranges for prices unless explicitly verified
- affiliate caps apply
- regulatory references must include 全名 + 编号 + effective date
- factual robustness > decision-usefulness when conflict
- Layered Writing preserved (no collapse during patch)

You are patching and finalizing an ExpatGuide DEEP-lane markdown article.

Task:
Patch the draft below based only on the issue list.
Make the minimum necessary edits.
Do not rewrite unaffected sections.
Do not introduce new unsupported facts.
Do not break existing valid internal links.
Do not collapse Layered Writing during patch.
Do not remove regulatory three-piece citations during patch.

DRAFT ARTICLE:
[PASTE DEEP DRAFT PACKAGE — full]

ISSUE LIST:
[PASTE CLAUDE QA ISSUE LIST — Pass 1, OR + bash check-articles.sh errors]

AVAILABLE INTERNAL ARTICLES:
[PASTE CONTENTS OF Research/internal-articles-index.md]

Rules:
- Preserve the structure unless a listed issue requires structural change
- Preserve internal links unless a listed issue requires change
- Preserve affiliate placement unless a listed issue requires change
- Preserve Layered Writing unless a listed issue requires change (and even then, the patched version must remain Layered)
- Preserve regulatory three-piece citations unless a listed issue requires change (and the new version must still include 全名 + 编号 + effective date)
- Do not add new unsupported claims
- Keep the article in markdown
- Keep the title with year
- Keep tone neutral and reference-style
- No first person (with stated exceptions)
- No banned words
- All internal links must start with "/" and use AVAILABLE INTERNAL ARTICLES slugs
- Keep the article natural, useful, publication-ready
- Do not introduce SEO filler
- Do not make the article sound robotic
- Do not over-compress useful nuance
- Do not replace specific practical guidance with generic summaries
- Prioritize factual robustness over decision-usefulness (deep lane reverse)
- Patch must NOT collapse any Gray-Area Claim's Layered Writing
- Patch must NOT introduce affiliate compliance risk
- Patch must NOT change regulatory effective dates without explicit verification source

Final SEO / GEO pass:
- Improve introduction if main answer comes too late (deep lane: intro can be a paragraph, not just one sentence)
- Tighten section headings if vague or generic
- Remove filler that weakens search usefulness
- Improve retrieval-friendliness for AI systems
- Add or sharpen concise summary lines only when they genuinely improve clarity
- Preserve human readability and editorial quality
- Do not add keyword stuffing
- Do not make article sound templated or over-optimized
- Check article serves: main search intent, key follow-up questions, AI-search extractability
- Check article still reads like a strong human-written reference page
- Prefer precision and usefulness over "content marketing" language

Final quality bar (deep lane):
- Article should feel publish-ready
- It should not feel like SEO-first
- It should not feel like AI-generated
- It should be easy to scan, quote, summarize, act on
- It should preserve ExpatGuide reference-site tone
- Every YMYL claim retains Tier 1 backing
- Every Gray-Area Claim retains Layered Writing
- Every regulatory citation retains 三件套

FINAL HARD RULES CHECK BEFORE RETURNING:
- no first person (with stated exceptions)
- year in title
- all internal links start with "/" and use only AVAILABLE slugs
- banned words list still applies
- regulatory three-piece preserved
- Layered Writing preserved (no collapse)
- factual robustness preserved (no over-flattening)
- affiliate caps unchanged
- Tier 1 backing preserved for every YMYL claim

Return exactly this format:

DEEP FINAL PACKAGE

# Final Title
...

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
[patched markdown article — starts at first ## heading]

# Final Internal Links Used
- ...

# Final Affiliate Mentions Used
- ...
- or "none"

# Final Regulatory References Used
- 全名 | 编号 | Effective Date | Section
- ...

# Patch Changelog
- Issue ID:
  Original sentence:
  Patched sentence:
  Change type: cosmetic / scope narrowed / condition added / claim downgraded / claim removed / source-risk disclosed / regulation reference updated / layered writing strengthened
  Meaning changed: yes/no
  Why this is substantive:
  Layered Writing affected: yes/no (if yes: confirm both layers still present)
  Regulatory citation affected: yes/no (if yes: confirm 三件套 still complete)

# Final SEO/GEO Check
- primary_search_intent_clear: pass/fail
- followup_questions_covered: pass/fail
- intro_answers_core_query_early: pass/fail
- headings_search_clear: pass/fail
- geo_friendly_but_natural: pass/fail
- no_keyword_stuffing: pass/fail
- no_ai_sounding_filler: pass/fail

# Final Self-Audit (evidence required)
[Same structure as Deep Draft Self-Audit, plus the following deep-lane patch-specific items:]

- internal_links_preserved: pass/fail
  - For each internal link in the original draft: still exists and syntactically valid in final?
  - If a link was removed/changed by an ISSUE entry: note which Issue ID authorized the change
- gray_area_layered_preserved: pass/fail (deep lane critical)
  - For each Final Gray-Area Claim from VALIDATION PACK: confirm Official layer + Practical layer both still present in final article
  - Quote one Official-layer sentence and one Practical-layer sentence per Gray-Area Claim
  - If any Gray-Area Claim was collapsed during patch: this is a fail, must re-patch
- regulatory_citations_preserved: pass/fail (deep lane critical)
  - For each regulatory reference in original draft: still includes 全名 + 编号 + effective date in final?
  - If any reference lost a piece during patch: note which and why
- claude_qa_issues_resolved: per-issue audit
  - CQA-01: resolved / partial / unresolved + reason
  - CQA-02: resolved / partial / unresolved + reason
  - ... (all Pass 1 issues)

[All other Self-Audit items same as Deep Draft]
```

---

## Claude QA Prompt — Pass 2(Patch 后审查)

```text
You are the deep-lane Claude QA Pass 2 for an ExpatGuide article.

Pass 2 is NOT a re-do of Pass 1. Your job is:
1. Confirm whether each Pass 1 issue was actually fixed by the patch
2. Detect new issues INTRODUCED by the patch
3. Audit specific patch-vulnerability patterns (Layered Writing collapse, regulatory citation loss, affiliate compliance drift)

Do NOT:
- Re-run full Tier 1 source verification (Pass 1 already did this)
- Re-run full dual-perspective review (Pass 1 already did this)
- Introduce new concerns that Pass 1 didn't catch (those should be re-Pass-1, not Pass 2)
- Rewrite the article

Inputs:

DEEP FINAL PACKAGE:
[PASTE FULL FINAL PACKAGE INCLUDING ARTICLE + PATCH CHANGELOG + FINAL SELF-AUDIT]

CLAUDE QA ISSUE LIST — Pass 1:
[PASTE FULL PASS 1 ISSUE LIST]

Your work areas:

1. Pass 1 Issue Resolution Audit
   - For each Pass 1 issue: did the patch actually fix it?
   - Verify by reading the patched section, not just trusting the Patch Changelog
   - Flag: resolved / partial / unresolved
   - For partial/unresolved: explain what's still missing

2. Patch-Introduced New Issue Detection
   - Common patch-vulnerability patterns to check:
     a. Layered Writing collapse: did the patch flatten any Gray-Area Claim into a single statement?
     b. Regulatory citation loss: did the patch drop 全名/编号/effective date from any reference?
     c. Affiliate compliance drift: did the patch make any affiliate mention more "promotional"?
     d. Internal link breakage: did the patch break any working markdown link?
     e. New unsupported claim: did the patch insert any factual claim not present in original draft?
     f. Tier 1 source loss: did the patch remove a Tier 1 citation that originally supported a YMYL claim?

3. Final Verdict
   - If no Pass 1 issues remain unresolved AND no new Critical/High issues introduced: ready for publication
   - If any Pass 1 issue is unresolved (regardless of severity): note it, but only require re-patch if Critical/High
   - If any new Critical/High issue introduced: re-patch required (back to Step 5)
   - If 3+ rounds of patch have failed to resolve: structural Drafting failure, recommend back to Step 4

Return exactly this format:

CLAUDE QA ISSUE LIST — Pass 2

Pass 1 Issue Resolution Audit:
- CQA-01: resolved / partial / unresolved
  Evidence: [quote from final article showing resolution OR what's still missing]
- CQA-02: ...
- ... (all Pass 1 issues)

Patch-Introduced New Issues (if any):

Issue:
- Issue ID: CQA-P2-01
- Quote (from final article):
- Category: layered_writing_collapsed_during_patch / regulation_citation_lost / affiliate_compliance_drift / internal_link_broken_during_patch / new_unsupported_claim / tier1_source_lost / other
- Severity: Critical / High / Medium / Low
- Why risky:
- Minimal fix:

Issue:
- Issue ID: CQA-P2-02
- ... (same format)

If no new issues:
"No new issues introduced by patch."

Patch Vulnerability Pattern Audit:
- Layered Writing collapse during patch: pass/fail (with evidence)
- Regulatory citation loss during patch: pass/fail (with evidence)
- Affiliate compliance drift during patch: pass/fail (with evidence)
- Internal link breakage during patch: pass/fail (with evidence)
- New unsupported claims introduced: pass/fail (with evidence)
- Tier 1 source loss during patch: pass/fail (with evidence)

Final Verdict:
- All Pass 1 issues resolved or downgraded acceptably: yes/no
- No new Critical/High issues introduced: yes/no
- Decision: ready for publication / re-patch required / structural Drafting failure (back to Step 4)
```

---

## 一句话版本

深度文优先确保每个 YMYL 主张有 Tier 1 来源、每个法规引用三件套齐全、每个 Gray-Area Claim 两层呈现,即使因此牺牲流畅性与简洁性。

---

## 与普通车道 v2.52 的快速对照表

| 维度 | 普通车道 v2.52 | 深度车道 v1.0 |
|---|---|---|
| 核心权衡 | decision-usefulness > factual caution | factual robustness > decision-usefulness |
| Topic Sheet 字段 | 标准 + Scope Definition Check | + Risk Tier + Effective Date Sensitivity + Multi-Source Conflict Expected |
| Research Pack | Key Claims Table + Possible Internal Links | + Regulatory Source Map + Authority Hierarchy + Conflict Inventory + Eligibility Matrix |
| Validation | 单跑 adversarial | 双跑(Strict + Gray)+ 合并 |
| Drafting | 自由组合 | 强制 Layered Writing(Gray-Area Claims 不允许压平) |
| 法规引用 | 适用即可 | 必须三件套(全名 + 编号 + 生效日) |
| Tier 1 来源 | 不强制 | YMYL 主张必须有 Tier 1 |
| QA | GPT 自审 | + Claude QA Pass 1(web_fetch 验证 + 双视角)+ Claude QA Pass 2(Patch 后审查) |
| Self-Audit 检查项数 | 标准 | + 6 项(regulatory_citation_completeness / effective_date_check / tier1_source_present / layered_writing_preserved / legal_safety_disclaimers / affiliate_compliance_check) |
| 合格分 | 70-80 | 85+ |
| 适用 | Daily Life / Housing / Digital Nomad 等中低风险 | Visa / TRC / Tax / Insurance / Healthcare / Banking 合规 / Legal |
