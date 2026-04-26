# Deep Lane Review Failure Patterns

ExpatGuide Vietnam 深度车道已识别的失败模式库。每次复核完成后,如发现新模式,追加到本文件。复核员每次复核时应主动检查文章是否触发已知模式。

**版本初始化日期**:2026-04-26
**初始化基础**:vietnam-visa-run-guide-2026 复核结果

---

## 模式分类索引

- A 系列:Tier 1 来源类
- B 系列:法规三件套类
- C 系列:DDF 类
- D 系列:Layered Writing 类
- E 系列:Eligibility Matrix 类
- F 系列:Frontmatter 类
- G 系列:Affiliate / 内链 / 写作风格类

---

## A 系列:Tier 1 来源类

### Pattern A1:模糊措辞引用(BLOCKING)

**症状**:用 "official material says" / "official information states" / "embassy material supports" / "according to official sources" 等模糊措辞引用 Tier 1 来源,但未具名部委、门户、法规编号。

**首发出处**:vietnam-visa-run-guide-2026
- "Accessible Cambodia embassy material supports the basic tourist-visa frame..."
- "Laos official eVisa information states that the eVisa is single-entry..."

**为何是 BLOCKING**:深度车道核心约束 5 要求 Tier 1 来源支撑 YMYL 主张,模糊措辞既不能让读者验证,也不能让 Risk QA 做 source spot check。本质上是把"来源工作"推给了读者。

**正确写法**:
- 替换为具名部委 + 官方门户 URL
  - "The Ministry of Foreign Affairs and International Cooperation of Cambodia (mfaic.gov.kh) confirms..."
  - "The Lao eVisa official portal (laoevisa.gov.la) states..."
- 或具名法规 + 三件套
  - "Decree No. XXX/2025/ND-CP, effective from [date], establishes..."

**复核员检查方式**:全文搜索关键词:
- `official material`
- `official information`
- `embassy material`
- `according to official`
- `accessible material`

任一命中 → 视为 Pattern A1 触发。

---

### Pattern A2:硬数字 YMYL 主张无法规出处(BLOCKING)

**症状**:文章给出具体硬数字(US$X、X 天、X%、X 月等)作为 YMYL 主张,但未给出该数字背后的法规、决议、官方 fee schedule 出处。

**首发出处**:vietnam-visa-run-guide-2026
- "official fees of US$25 for single-entry and US$50 for multiple-entry e-visas"
- "processing time of 3 working days after payment"
- 两条都未给法规出处

**为何是 BLOCKING**:硬数字是最容易被引用、最容易过时、最容易让读者实际损失钱的主张。没有法规出处意味着无法在数字变更时定位检查点。

**正确写法**:
- 在硬数字所在段末尾追加 1 句出处
- 格式:"These figures are based on [法规全名 + 编号 + 生效日,或官方门户名称 + URL]."
- 例:"These figures are based on the Vietnam e-visa portal (evisa.xuatnhapcanh.gov.vn) and Resolution No. 127/NQ-CP."

**复核员检查方式**:扫描文中所有 US$、VND、% 数字、天数、月数,检查是否在该段或邻近段有法规/官方门户出处。

---

### Pattern A3:监管层硬数字用"the amended X rules"等模糊措辞引用(BLOCKING)

**症状**:文章给出受监管约束的硬数字主张(支付限额、外汇限额、税率上限等),但引用监管法规时使用"the amended X rules" / "current X regulations" / "recent regulatory changes" / "updated regulatory framework"等模糊措辞,既不具名 Circular / Decree / Law 编号,也不给生效日。

**首发出处**:vietnam-domestic-money-transfer-2026
- "under the amended intermediary-payment rules, personal e-wallet transactions at one provider are generally capped at 100m VND/month"
- "while some listed payment categories may have separate higher caps up to 300m VND/month"

**为何是 BLOCKING**:这是 Pattern A1(模糊措辞)+ Pattern A2(硬数字无出处)+ Pattern B1(法规全名缺失)的**三模式叠加**变种,且尤其常见于"提到监管修订但未具体到法规编号"的场景。Pattern A1 主要针对部委/大使馆,Pattern A3 专门针对**法规修订**这类时间敏感引用。"amended"、"updated"、"recent"等词暗示读者法规是最新的,但读者无法验证哪一次修订、哪一条款。

**正确写法**:
- "Circular No. XX/YYYY/TT-NHNN on intermediary payment services, effective from [date], caps personal e-wallet transactions at..."
- 或保守表述:"Current regulations from the State Bank of Vietnam (specific circular reference pending verification on the SBV portal sbv.gov.vn) cap..."并标注到 Claim Sheet

**复核员检查方式**:全文搜索关键词:
- `the amended` + 后接规则/法律词
- `current regulations` 后未具名
- `recent regulatory` 后未具名
- `updated rules` 后未具名

任一命中且涉及 YMYL 硬数字 → 视为 Pattern A3 触发。

**重要约束**:复核员发现 Pattern A3 时,**不得编造 Circular 编号或生效日**。Patch prompt 应要求 Deep Draft 窗口先核查 thuvienphapluat 法规库或 SBV 官方门户,若无法核实,标记到 Claim Sheet 并采用保守表述。

---

## B 系列:法规三件套类

### Pattern B1:法规全名缺失(BLOCKING)

**症状**:法规引用只给编号 + 生效日,未给法规全名。

**首发出处**:vietnam-visa-run-guide-2026
- "Decree 282/2025/ND-CP took effect on December 15, 2025" — 未给全名

**为何是 BLOCKING**:深度车道核心约束 2 要求三件套(全名 + 编号 + 生效日)。全名缺失意味着读者无法快速定位法规涵盖范围,也意味着可能存在编号引用错误未被发现。

**正确写法**:
- "Decree No. 282/2025/ND-CP on [完整 subject matter], effective from 15 December 2025"

**复核员检查方式**:全文搜索 `Decree` / `Law` / `Resolution` / `Circular`,逐条核查是否含全名。

**重要约束**:复核员发现 Pattern B1 时,**不得编造全名**。Patch prompt 应要求 Deep Draft 窗口先核查 Tier 1 法规库(thuvienphapluat / Vietnam Government 公报)再补全;若无法核实,标记到 Claim Sheet 待补。

---

### Pattern B2:法规生效日缺失(BLOCKING)

**症状**:法规引用给出全名 + 编号(完整或部分),但漏掉生效日。与 Pattern B1(全名缺失)是法规三件套的两个对称漏点。

**首发出处**:vietnam-atm-guide-2026
- "Circular 18/2024/TT-NHNN governs bank card operations in Vietnam. For ATM users..." — 编号 + 部分全名,缺生效日
- "replaced Decision No. 630/QD-NHNN" — 编号清晰但作为被替代法规未给原生效日

**为何是 BLOCKING**:深度车道核心约束 2 三件套(全名 + 编号 + 生效日)是 AND 关系,任一缺失即 BLOCKING(protocol 维度 5 明确"任一法规缺生效日"是 BLOCKING 触发条件)。Pattern B1 已覆盖全名缺失,但实际复核中"编号清晰但生效日缺失"是另一种常见漏点,值得独立编码以提高扫描精度。

**与 Pattern B1 的区别**:
- B1 关注"只有编号 + 生效日,无全名"(visa-run-2026 的 Decree 282 案例)
- B2 关注"全名描述 + 编号齐全,但缺生效日"(atm-guide-2026 的 Circular 18 案例)
- 两者都是 BLOCKING,但触发场景不同,patch 方向也不同(B1 补全名,B2 补生效日)

**正确写法**:
- "Circular No. 18/2024/TT-NHNN on bank card operations, effective from [date], governs..."
- 被替代法规也应给原生效日:"replaced Decision No. 630/QD-NHNN, which had been effective since [date]"

**复核员检查方式**:全文搜索 `Decree` / `Law` / `Resolution` / `Circular` / `Decision`,对每条引用做三件套核查表(全名 / 编号 / 生效日三列),任一列空白即标 BLOCKING。建议复核员在维度 5 报告中**强制使用三列核查表**,而非段落式叙述,以避免漏检生效日缺失。

**重要约束**:复核员发现 Pattern B2 时,**不得编造生效日**。Patch prompt 应要求 Deep Draft 窗口先核查 thuvienphapluat / Vietnam Government 公报 / SBV 官方门户(对应监管领域),若无法核实,标记到 Claim Sheet 并采用保守表述。

---

## C 系列:DDF 类

### Pattern C1:落地信息维度不具名(WARNING / BORDERLINE)

**症状**:文章触发 DDF,价格/时效/波动 caveat 都到位,但落地信息只用"designated ports" / "specific locations" / "official channels" 等抽象词,未列出具体地点/口岸/机构名。

**首发出处**:vietnam-visa-run-guide-2026
- Cambodia eVisa 接受口岸只说"designated ports",未列名
- Laos eVisa designated ports 同上

**为何不是 BLOCKING**:落地信息 caveat 化处理在某些场景是合理的安全策略(法规变化频繁、口岸名单可能更新)。但相对 health-insurance 首篇的具体度仍偏低。

**判定原则**:
- 如果文章其他维度强,Pattern C1 单独存在 → WARNING
- 如果文章已有多个 WARNING,Pattern C1 加重 → BORDERLINE BLOCKING
- 如果文章是路线/口岸密集类(visa-run、border-crossing),应该 → BLOCKING

**正确写法**:
- 列出 1-2 个具名口岸 + caveat
- 例:"Laos eVisa is currently accepted at Wattay International Airport, the Lao-Thai Friendship Bridge I, and other designated ports — verify the current accepted-ports list before relying on a specific crossing."

---

### Pattern C2:产品对比类文章中"默认推荐方法"自身缺 DDF 数据(BORDERLINE BLOCKING)

**症状**:文章为产品对比类且明确推荐某一方法为"默认"(default / preferred / safest),但该默认方法在 DDF 表格或介绍章节中,价格区间/时效区间用"X-specific" / "varies by provider" 等去具体化措辞打发,反而不如非默认方法的数据具体。

**首发出处**:vietnam-domestic-money-transfer-2026
- "The short answer"和多个章节明确推荐"bank app transfer"为默认
- 但 DDF 表格 Bank app transfer 行的 Limit/fee anchor 列:"Bank-specific. Some banks waive many digital transfers; others may charge by route or amount"
- 而 MoMo / ZaloPay / NAPAS 等非默认方法反而给了具体数字区间

**为何是 BORDERLINE BLOCKING**:深度车道 DDF 的核心目的是让读者能 act on the data。如果读者按文章建议选了"默认方法",反而拿到最少的具体数据,DDF 实际未对决策路径产生支撑作用。这违反核心约束 1(factual robustness 服务于 decision-usefulness)。本质上是把"决策路径上最重要的那个产品"当成最不需要数据的产品来处理。

**判定原则**:
- 默认方法的 DDF 数据具体度应 ≥ 非默认方法
- 如果默认方法 DDF 数据明显弱于其他方法 → BORDERLINE BLOCKING
- 如果默认方法完全无 DDF 数据(只有 caveat)→ BLOCKING
- 如果文章未明确推荐默认方法(只是中立对比)→ 不触发本模式,按 Pattern C1 处理

**正确写法**:
- 至少给出 2-3 家具名 provider 的具体锚点(如 Vietcombank / Techcombank / VPBank 当前 fee schedule)
- 加波动 caveat 但不替代具体数字
- 引导读者去 provider 页面验证

**复核员检查方式**:
1. 先识别文章是否有明确推荐"默认 / preferred / safest / cleanest"方法的语言
2. 在 DDF 表/段中扫描该方法的价格、时效、限额数据
3. 与文章中非默认方法的数据具体度做对比
4. 若默认方法明显稀疏 → 视为 Pattern C2 触发

---

## D 系列:Layered Writing 类

### Pattern D1:灰区压平为单一陈述(BLOCKING)

**症状**:Gray-Area Claims(法规 vs 实操、官方 vs agency 行为、明文规则 vs 自由裁量)被压平为单一陈述,未做 Official + Practical 两层呈现。

**首发出处**:暂未在已复核文章中发现(visa-run 这一项做得非常好)。本模式预防性记录,典型场景包括:

- 签证延期实操灰区:"You can extend your visa" 但实际办理需要 agency 介入
- 银行开户灰区:"Foreigners can open accounts" 但实际很多分行拒绝某些 visa 类型
- 房屋租赁合同灰区:"Standard contracts require X" 但实际市场普遍跳过 X
- 摩托车驾照灰区:"You need a Vietnamese license" 但实际执法不一致

**正确写法**:
- 显式分层(子标题 "Official layer" / "Practical layer")
- 或段落分层(法规规定 → 实际操作 → 读者建议)

**复核员检查方式**:识别灰区主张后,问自己:"如果读者真的按 Official 层去做,会不会撞墙?" 如果答案是"会",必须有 Practical 层补充。

---

## E 系列:Eligibility Matrix 类

### Pattern E1:软推荐表替代硬矩阵(BLOCKING)

**症状**:文章给出表格,但用"good fit / needs review / depends" / "recommended for X type" 等软语言,而非 yes/no/conditional 硬判定。

**首发出处**:暂未在已复核文章中发现(预防性记录)

**为何是 BLOCKING**:深度车道核心约束 4 明确"软推荐表是失败信号"。软语言无法让读者做决策,只是把决策推回给读者。

**正确写法**:
- 表头列硬条件(visa 类型 / 年龄段 / 收入 / 国籍 / 雇佣状态等)
- 单元格用 Yes / No / Conditional / High risk / Not eligible 硬判定
- Conditional 单元格附简短条件说明

**复核员检查方式**:扫描文中所有表格,检查判定列用词。命中"good fit" / "depends" / "needs review"等 → 视为 Pattern E1 触发。

---

## F 系列:Frontmatter 类

### Pattern F1:禁止字段渗入 frontmatter(BLOCKING)

**症状**:frontmatter 出现 slug / country / lastUpdated / tags 等白名单外字段。

**首发出处**:暂未在已复核文章中发现(visa-run 此项干净)。已记录因为这是常见 Astro Starlight 项目陷阱,GPT 起草时容易自动加上。

**为何是 BLOCKING**:Frontmatter 字段白名单是站点架构硬规则,任何禁止字段都会破坏 sidebar 自动生成、URL 路径、内链一致性。

**正确写法**:严格只保留 title / description / sidebar.label。

**复核员检查方式**:每次复核第一步就检查 frontmatter,这是最便宜的 blocking 检查。

---

## G 系列:Affiliate / 内链 / 写作风格类

### Pattern G1:Affiliate URL 退化为普通官网链接(BLOCKING)

**症状**:Wise / SafetyWing / World Nomads 出现时,使用 wise.com / safetywing.com / worldnomads.com 等普通链接,而非 affiliate 模板。

**首发出处**:暂未在已复核文章中发现(visa-run 此项干净)。预防性记录,因为 GPT 起草时如不强制注入 affiliate URL,容易回退到普通官网。

**为何是 BLOCKING**:直接损失收入,且违反 SOP 强制规则。

**正确写法**:严格使用 constitution 第 4 节的 URL 模板。

**复核员检查方式**:全文搜索 wise.com / safetywing.com / worldnomads.com,检查每个出现位置是否使用 affiliate 模板。

---

### Pattern G2:作者第一人称渗入(BLOCKING)

**症状**:文中出现 "I think" / "we recommend" / "in our experience" / "I've found" 等作者第一人称。

**首发出处**:暂未在已复核文章中发现。预防性记录。

**为何是 BLOCKING**:深度车道写作风格规则明确禁止作者第一人称(only "our + 内链" 和 FAQ 读者第一人称允许)。

**正确写法**:
- 改为客观陈述:"This guide recommends..." → "The most practical option is..."
- 改为读者视角:"We suggest you..." → "Travelers should..."

**复核员检查方式**:扫描 "I " / "I'm " / "I've " / "we recommend" / "we suggest" / "in our experience" / "our opinion"。注意区分:
- "our [Vietnam visa guide](/vietnam/visa/...)" ✅ 允许
- "in our experience" ❌ 禁止

---

### Pattern G3:服务商共现违规(BLOCKING)

**症状**:World Nomads 与 SafetyWing 在同一句中被并列提及。

**首发出处**:暂未在已复核文章中发现(预防性记录,因 affiliate 条款明确禁止)。

**为何是 BLOCKING**:违反 SafetyWing affiliate 条款,可能导致账号被封。

**正确写法**:
- 在不同段落分别提及
- 或只提一个,另一个用"other expat insurance options" 概括

**复核员检查方式**:扫描含 SafetyWing 的句子,检查同句是否有 World Nomads 字样。

---

## 模式触发统计(Leon 维护)

每次复核完成后,Leon 在此处更新触发计数。计数高的模式说明 Deep Draft 窗口的 SOP 仍有漏洞,值得反向回流到 Draft 侧。

| 模式 | 触发文章数 | 最近触发 |
|---|---:|---|
| A1 模糊措辞引用 | 2 | domestic-money-transfer-2026 |
| A2 硬数字无法规出处 | 2 | domestic-money-transfer-2026 |
| A3 监管层"the amended X rules"模糊引用 | 1 | domestic-money-transfer-2026 |
| B1 法规全名缺失 | 2 | domestic-money-transfer-2026 |
| C1 落地信息不具名 | 1 | visa-run-2026 |
| C2 默认方法缺 DDF 数据 | 1 | domestic-money-transfer-2026 |
| D1 灰区压平 | 0 | — |
| E1 软推荐表 | 0 | — |
| F1 frontmatter 禁止字段 | 0 | — |
| G1 affiliate URL 退化 | 0 | — |
| G2 作者第一人称 | 0 | — |
| G3 服务商共现违规 | 0 | — |

**反向回流触发条件**(Leon 决策点):
- 单一模式触发 ≥ 3 次 → 应回流到 Deep Draft SOP,在起草侧加预防 prompt
- A 系列 / B 系列任一模式触发 ≥ 2 次 → 优先级高,应立即回流

---

## 新模式追加格式

发现新失败模式时,按以下格式追加:

```markdown
### Pattern [X编号]:[简短描述]([BLOCKING / WARNING])

**症状**:[具体表现]

**首发出处**:[文章 slug]
- [文中原文引用]

**为何是 [BLOCKING/WARNING]**:[关联到哪条核心约束 + 损害后果]

**正确写法**:
- [具体改写示例]

**复核员检查方式**:[搜索关键词或扫描方法]
```

并在"模式触发统计"表中追加新行。
