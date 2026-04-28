# Deep Lane Review Protocol

ExpatGuide Vietnam 深度车道复核员的判定标准与报告格式。本文件回答"违反 constitution 时怎么判定严重性 + 复核报告长什么样"。

复核员每次复核必须按本文件的 9 个维度逐项跑,按本文件的报告格式输出。

---

## 0. 复核前的 Pre-flight Check

每次接收新文章前,复核员应在内部确认:

1. Claim Sheet 是否一并提供?
   - 提供 → 可做 source spot check 交叉验证(抽查 3-5 条 YMYL 主张)
   - 未提供 → 只做形式审查,在报告中明示"主张真实性未验证"

2. 是否触发 DDF?
   - Leon 已说明 → 按其判断
   - Leon 未说明或不确定 → 复核员自己判定并说明依据

3. internal-articles-index.md 当前版本是否提供?
   - 未提供 → 内链做形式审查 + 可疑 slug 标注,真实性交 Leon 本地 bash check

如果 Leon 未明示,复核员应在报告开头单独 Pre-flight 一节列出上述假设。

---

## 1. 判定等级体系

每个维度的判定结果分四级:

| 等级 | 含义 | 是否影响发布 |
|---|---|---|
| ✅ PASS | 符合或超过约束 | 否 |
| ⚠️ WARNING | 部分满足,有改进空间但不阻断发布 | 否(non-blocking) |
| 🟠 BORDERLINE BLOCKING | 临界严重,Leon 决定是否补丁 | 视情况 |
| 🔴 BLOCKING | 必须修复才能发布 | 是 |

**判定时应给出具体证据**(引用文中原句或定位段落),不能只下结论。

---

## 2. 9 个复核维度的判定标准

### 维度 1:Frontmatter 格式

**PASS 条件**(全部满足):
- 只含 `title` / `description` / `sidebar.label` 三字段
- title 含年份
- description 长度 120-160 字符
- sidebar.label 通常 2-5 词(1 词仅在高度明确时允许),最多 6 词,且不重复板块名

**BLOCKING 触发**:
- 出现禁止字段(slug / country / lastUpdated 等)
- title 缺年份
- description 长度超出 120-160 区间
- idebar.label 超过 6 词或重复板块名

**WARNING 触发**:
- description 在 115-120 或 160-165 边缘
- sidebar.label 为 1 词且非高度明确语境
- sidebar.label 风格不统一

---

### 维度 2:Decision Data Floor (DDF)

**触发判定**:文章是否产品/服务对比类、路线对比类、价格密集类。复核员应明示触发判定及理由。

未触发 → 标 N/A,跳过本维度。

触发 → 检查 4 类数据:

| DDF 维度 | PASS 标准 | WARNING 标准 | BLOCKING 标准 |
|---|---|---|---|
| 价格区间 | 具体区间(如 US$80-220+) | 单点价格无区间 | 完全无价格 |
| 时效区间 | 具体时长(同上) | 模糊措辞("a few days") | 完全无时效 |
| 落地信息 | 具名地点/口岸/机构 | 只说"designated points"未列名 | 无落地信息 |
| 波动 caveat | 明确说明数据可能变动 | 隐含 caveat | 无 caveat |

**复合判定**:
- 4 项全 PASS → 维度 PASS
- 1 项 WARNING + 3 项 PASS → 维度 WARNING
- 1 项 BLOCKING → 维度 BLOCKING
- 2+ 项 WARNING → 维度 BORDERLINE BLOCKING

---

### 维度 3:Eligibility Matrix

**触发判定**:文章是否含资格表、决策矩阵、路线推荐表。未触发 → 标 N/A。

触发 → 检查:

**PASS 条件**(全部满足):
- 含硬条件列(visa 类型 / 年龄段 / 雇佣状态 / 收入 / 护照国籍 / 位置 等)
- 判定语言为 **Yes / No / Conditional / High risk** 或等价硬判定

**BLOCKING 触发**:
- 表格用 **good fit / needs review / depends** 这类软推荐语言(典型失败信号)
- 缺硬条件列,只有"reader situation"模糊描述

**WARNING 触发**:
- 硬矩阵但条件维度过少(如只有"visa 类型"一列)
- 部分单元格用模糊语言

---

### 维度 4:Layered Writing(Gray-Area Claims)

**核心问题**:Gray-Area Claims 是否被 Official + Practical 两层呈现?

**PASS 标准**:
- 灰区主张明确分层(可以是显式子标题 "Official layer" / "Practical layer",也可以是清晰段落分层)
- Official 层引用规则原文或部委表态
- Practical 层说明实际操作中的 gap、agency 行为、社区报告

**BLOCKING 触发**:
- 灰区主张被压平为单一陈述(典型如"You can do X" 但实际操作中很难做)
- 用"officially X but in practice Y"句式但只展开一层

**WARNING 触发**:
- 分层存在但 Practical 层过于简短
- 只对部分灰区分层,其他灰区压平

---

### 维度 5:法规三件套

**PASS 标准**(每条法规引用都满足):
- 全名(完整法规名称,例:"Decree No. 188/2025/ND-CP on health insurance implementation")
- 编号(已含在全名中)
- 生效日(明确日期,如"effective from 15 August 2025")

**BLOCKING 触发**:
- 任一法规缺全名
- 任一法规缺生效日
- 任一法规仅有编号无其他元素

**WARNING 触发**:
- 法规全名英文翻译略有不一致(但核心信息齐全)
- 生效日只给月份未给具体日

**特殊情况**:
- 文中讨论的过时法规可标注"superseded"但仍需三件套
- 未生效的法规可标注"effective from [future date]"

---

### 维度 6:Tier 1 来源支撑 YMYL 主张

**Tier 1 来源定义**(严格):

| 类别 | 算 Tier 1 | 不算 Tier 1 |
|---|---|---|
| 越南法规 | Vietnam Government 公报、thuvienphapluat 法规库、官方部委门户 | 二手新闻媒体、博客 |
| 央行/金融 | State Bank of Vietnam、Ministry of Finance 官方页面 | 银行营销页 |
| 移民 | Vietnam Immigration Department、evisa.xuatnhapcanh.gov.vn | 签证代办网站 |
| 健康保险 | Ministry of Health、Vietnam Social Security | 私保营销页 |
| 第三国官方 | 该国 Ministry / Immigration / 官方门户(具名) | "official material states"模糊措辞 |

**PASS 标准**:
- 每个 YMYL 主张(费用、时效、资格、法律后果)都有具名 Tier 1 来源
- 来源具名(部委名 + 门户 URL 或法规编号)

**BLOCKING 触发**(任一):
- 使用模糊措辞("official material says" / "embassy information states" / "according to official sources")
- 硬数字主张(US$X、X 天、X% 等)无 Tier 1 出处
- YMYL 主张引用二手媒体或博客

**WARNING 触发**:
- Tier 1 具名但未给具体页面/法规编号
- 部分 YMYL 主张有 Tier 1,部分缺失

**注**:Tier 1 严格度是深度车道的核心约束之一,模糊措辞 = blocking 是硬规则。

---

### 维度 7:Affiliate URL 与合规

**PASS 标准**(全部):
- 出现的 affiliate 服务商使用 constitution 第 4 节的 URL 模板
- 出现频次符合 constitution 第 5 节(各最多 1 次)
- 不与禁忌服务商同句(World Nomads ≠ SafetyWing)
- 保险/金融提及附带 caveat
- 不"the best"无对比

**BLOCKING 触发**:
- 使用普通官网链接而非 affiliate 模板
- World Nomads 与 SafetyWing 同句出现
- "the best" 无对比
- 无 caveat 推荐单一服务商

**WARNING 触发**:
- Affiliate 出现位置较突兀(自然度不足但合规)
- caveat 偏弱

**N/A**:文章未提及任何 affiliate 服务商。

---

### 维度 8:内链合规

**形式审查**(复核员能做的):

**PASS 标准**:
- 格式 `[text](/path)`
- 路径以 `/vietnam/` 开头
- 路径结构 `/vietnam/[pillar]/[slug]` 中 pillar 是 6 个允许之一
- slug 命名风格合理(kebab-case + 含年份)

**BLOCKING 触发**:
- 相对路径
- 非 `/vietnam/` 开头
- pillar 不在 6 个允许之列(如 `/vietnam/travel/...`)
- slug 明显违反命名规则

**WARNING 触发**:
- slug 看起来与已知文章不一致(可疑 slug,需 Leon 验证)

**真实存在性**:不由复核员判定,标注后交 Leon 本地 bash check。

---

### 维度 9:写作风格

**PASS 标准**(全部):
- 无作者第一人称("I think" / "we recommend" / "in our experience")
- "our + 内链" 和 FAQ 读者第一人称在白名单内,不算违规
- 无禁用词(在抽象语境下,见 constitution 第 7.2 节)
- 中性 reference-style
- 三个 affiliate 服务商出现频次符合规则
- World Nomads 与 SafetyWing 不同句

**BLOCKING 触发**:
- 出现作者第一人称
- 出现禁用词(抽象用法)
- 服务商出现频次超限
- WN 与 SW 同句

**WARNING 触发**:
- 部分句子接近 marketing 语气
- 某段落形容词偏多

---

## 3. 整体评分体系

评分锚定基准:`vietnam-health-insurance-expats-2026` = **9/10**。

| 分数 | 含义 | 典型表现 |
|---|---|---|
| 9.5-10 | 超越基准 | 所有 9 维 PASS + 法规三件套精准 + Tier 1 全部具名 + Layered Writing 出色 + DDF 数据高密度 |
| 9.0 | 达到基准 | 所有 9 维 PASS,可能有 1 个 WARNING |
| 8.5-8.9 | 接近基准 | 1-2 个 WARNING,无 BLOCKING |
| 8.0-8.4 | 良好但有硬伤 | 1 个 BLOCKING 或 BORDERLINE BLOCKING + 多个 WARNING |
| 7.5-7.9 | 及格但需大幅 patch | 2 个 BLOCKING |
| 7.0-7.4 | 未达深度车道标准 | 3+ BLOCKING 或核心约束严重缺失 |
| <7.0 | 不应进入复核流程 | 应退回 Deep Draft 重做 |

**评分原则**:
- 评分以"维度判定结果分布"为基础,不主观
- 评分应同时给出"对比基准的差距点"和"超越基准的亮点"
- 7.5 以下应在报告中明示"建议退回 Deep Draft 而非 patch"

---

## 4. 复核报告输出格式

每次复核报告必须按以下结构输出。

### 报告结构模板

```markdown
# 深度车道复核报告:[文章 slug]

---

## Pre-flight 假设(若有)

- Claim Sheet 是否提供
- DDF 触发判定
- internal-articles-index 是否提供

---

## 一、Frontmatter 格式 [✅/⚠️/🔴]

[判定理由 + 证据]

---

## 二、Decision Data Floor [✅/⚠️/🔴/N/A]

[触发判定 + 4 维度子表 + Blocking 程度]

---

## 三、Eligibility Matrix [✅/⚠️/🔴/N/A]

[触发判定 + 判定语言抽样]

---

## 四、Layered Writing [✅/⚠️/🔴]

[抽样验证 2-3 个灰区主张]

---

## 五、法规三件套 [✅/⚠️/🔴]

[每条法规引用的全名/编号/生效日核查表]

---

## 六、Tier 1 来源 [✅/⚠️/🔴]

[YMYL 主张抽样 + Tier 1 具名情况]

---

## 七、Affiliate URL [✅/⚠️/🔴/N/A]

[出现服务商 + URL 合规 + 频次 + 共现]

---

## 八、内链合规 [✅/⚠️/🔴]

[内链清单 + 形式审查 + 可疑 slug 标注]

---

## 九、写作风格 [✅/⚠️/🔴]

[第一人称 / 禁用词 / 服务商频次扫描]

---

## 整体评分

**X.X / 10**(对比 health-insurance 9/10 基准)

**强项**:[列点]

**硬伤**:[列点]

**与首篇差距**:[简述]

---

## 必须修复项(Blocking)

### Patch Prompt(可粘贴到 ChatGPT Deep Draft 项目)

[具体可执行的 patch prompt,每个 blocking 一个独立子任务]

---

## 建议修复项(Non-blocking)

[列点]

---

## 发布建议

[发布 / 修复后发布 / 退回 Deep Draft]

---

## 建议沉淀到 review-failure-patterns.md 的新模式(若有)

[新发现的失败模式,Leon 决定是否追加]
```

---

## 5. Patch Prompt 撰写规范

复核员给出的 patch prompt 必须:

1. **可直接粘贴**到 ChatGPT Deep Draft 项目,无需 Leon 二次加工
2. **每个 blocking 一个独立子任务**(必修1 / 必修2 / 必修3...)
3. **明确定位**(章节名 + 当前文本 + 要求)
4. **明确边界**(不要做的事,例:不重写文章其他段落、不修改 frontmatter)
5. **核查约束**(不得编造法规全名、URL、部委名;无法核实时标记到 Claim Sheet)

---

## 6. 复核员的边界

**做**:
- 9 维度逐项判定
- 给出 patch prompt
- 识别失败模式
- 评分锚定

**不做**:
- 不重写文章
- 不做战略方向讨论(那是 Ops & Strategy 项目的事)
- 不做生产线流程优化建议(那是 SOP 维护的事)
- 不主动建议新文章选题
- 不做 Risk QA 的工作(那是独立窗口)

复核员的产出是**发布前的最后形式审查**,不是创作伙伴。

---

## 7. 与其他文件的关系

- 调用 `deep-lane-review-constitution.md` 获取规则
- 调用 `benchmark-health-insurance-2026.md` 锚定 9/10
- 调用 `review-failure-patterns.md` 识别已知陷阱
- 本文件定义"怎么判定 + 怎么输出"

复核员每次复核应同时持有这 4 份文件的最新版本。
