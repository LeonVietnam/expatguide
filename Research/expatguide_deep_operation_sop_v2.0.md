# ExpatGuide 深度文章操作 SOP v2.0

从 0 到发布的深度车道通用流程模板。每次写深度文章照这个走就行。

## v2.0 设计说明

本操作 SOP 与普通车道操作 SOP v1.3 平级、互不依赖。专门服务深度车道 SOP v1.0 的执行流程。

**与普通车道 v1.3 的本质区别**:

1. **多一个工具:Claude**(普通车道全程在 ChatGPT;深度车道在 ChatGPT 写完 Draft 后切到 Claude 跑 QA Pass 1 和 Pass 2)
2. **多两个交接点**:Step 6(ChatGPT Draft → Claude Pass 1)+ Step 8(ChatGPT Final → Claude Pass 2)
3. **多一个交接负担**:每次切到 Claude 时,必须把 TOPIC SHEET / DEEP RESEARCH PACK / VALIDATION PACK / DEEP DRAFT 全部带过去(Claude 不在 ChatGPT 项目里,没有项目知识)
4. **流程总步数**:13 步(普通车道 11 步)
5. **预估时间**:90-150 分钟/篇(普通车道 40-80 分钟)

**为什么要付出这个时间成本**:深度文章一旦发错(过期法规 / YMYL 错误建议 / Affiliate 合规风险),损害远大于普通文章。Claude QA 双 pass 是这个损害的保险费。

---

## 整体流程概览

```
[ChatGPT 项目]              [Claude]              [VS Code 终端]              [浏览器]
     │
  Step 2 → 选题 (Prompt 1 深度版)
     │
  Step 3 → Deep Research Pack (Prompt 2)
     │
  Step 4 → Validation Strict (Prompt 3a)
     │
  Step 5 → Validation Gray (Prompt 3b) → Merge (Prompt 3c)
     │
  Step 6 → Deep Draft + 自检 (Deep Draft Prompt)
     │                                   ↓
     │                        交接到 Claude (粘贴 4 份 pack)
     │                                   │
     │                              Claude QA Pass 1
     │                                   │
     │                        ←  ISSUE LIST 返回
     │
  Step 7 → Patch + Final SEO/GEO (Prompt 5,吃 Pass 1 ISSUE LIST)
     │                                   ↓
     │                        交接到 Claude (粘贴 Final + Pass 1 ISSUE)
     │                                   │
     │                              Claude QA Pass 2
     │                                   │
     │                        ←  Verdict 返回
     │
  Step 8 → 验收 Pass 2 verdict
     │     ├─ ready for publication → Step 9
     │     ├─ re-patch required → 回 Step 7
     │     └─ structural failure → 回 Step 6 重新 Draft
     │
     └──── 一次性保存到 ────→ src/content/docs/vietnam/[板块]/
                                      │
                            bash check-articles.sh
                                      │
                              0 errors? ──No──→ 回 ChatGPT 修复
                                      │ Yes
                              npm run dev ──→ 浏览器预览
                                      │
                              git push ──→ Cloudflare 自动部署
                                      │
                              GSC 提交新 URL 索引
                                      │
                            bash generate-link-index.sh
                                      │
                              上传到 ChatGPT 项目知识
```

---

## Step 1:每次写新深度文章前确认

- [ ] ChatGPT Plus 订阅有效
- [ ] Claude(claude.ai)账号可用,**且 Claude 启用 web_fetch 能力**(免费版可能受限,Pro 推荐)
- [ ] ExpatGuide 项目知识里的 `internal-articles-index.md` 是最新的(如果有一段时间没写了,先跑 `bash generate-link-index.sh` 然后重新上传)
- [ ] VS Code 打开了 `~/expatguide` 项目
- [ ] 在 ChatGPT **ExpatGuide 项目**里开一个新对话(不是在项目外开!)
- [ ] **打开一个新的 Claude 对话(单独的 tab,不要等到 Step 6 才慌乱地开)**

---

## Step 2:选题(深度车道)

**在哪:** ChatGPT 对话框

**做什么:** 粘贴(把 `[板块名]` 和 `[主题]` 替换成自己的内容):

```
按 Deep SOP v1.0 Prompt 1 的格式,帮我生成 1 个深度车道选题提案。

Scope: [板块名,例如:Healthcare in Vietnam / Banking in Vietnam / Visa in Vietnam]

Goal: [主题说明,例如:
  - 想写一篇关于 XXX 的深度指南
  - 这是个明确属于深度车道的主题(YMYL / 法规 / 合规)
  - 需要完整 TOPIC SHEET 含 Risk Tier + Effective Date Sensitivity + Multi-Source Conflict Expected]

请直接返回一个完整 TOPIC SHEET (Deep)。重点评估 Risk Tier 子类、Effective Date Sensitivity 时间窗、Multi-Source Conflict Expected 是否触发。如果判断这个主题其实不需要深度车道,明确告知。
```

**关键检查:**
- TOPIC SHEET 必须包含:Risk Tier(明确 health/financial/legal/safety-YMYL 子类)+ Effective Date Sensitivity(≤6/12/24/>24)+ Multi-Source Conflict Expected(yes/no)
- Scope Definition Check 三字段齐全(Primary Scope / Adjacent Space / Decision on Adjacent)
- 如果 GPT 反馈"这个主题应该走普通车道",**信它**,回到普通车道操作 SOP v1.3 走

**人工决策:** 接受 / 拒绝 / 让 GPT 重出。接受后:

```
TOPIC SHEET 通过。进入 Step 3。
```

---

## Step 3:深度调研 - Prompt 2

**在哪:** 同一对话继续

**做什么:** 粘贴(固定):

```
Topic Sheet 通过。请按 Deep SOP v1.0 Prompt 2 执行,输出完整的 DEEP RESEARCH PACK。

提醒:必须包含 9 个区块,缺一不可:
- Reader Questions / Recommended Angle / Suggested Outline
- Key Claims Table(每行 6 字段,Source Type 用 Tier 1/2/3/4)
- Regulatory Source Map(每条法规:全名/编号/颁布机构/promulgated/effective/current status/supersedes)
- Authority Hierarchy(Tier 1-4 对本主题的具体来源声明)
- Conflict Inventory(预期的官方-实际冲突点)
- Eligibility Matrix(如适用)
- Possible Internal Links / Potential Weak Spots
```

**关键检查:**
- `Possible Internal Links` 列的是真实 slug(在 internal-articles-index.md 里有的)
- `Key Claims Table` 每行 Source Type 明确标 Tier 1/2/3/4
- `Regulatory Source Map` 每条法规三件套齐全(全名 + 编号 + effective date),允许 unknown 但不允许编造
- `Conflict Inventory` 如果 TOPIC SHEET 说 Multi-Source Conflict Expected = yes,这里不能为零
- `Eligibility Matrix` 如果不适用,必须明确写 "not applicable for this topic" + 理由

如有问题,直接告知 GPT 修复:

```
[列出具体问题,例如:
- Regulatory Source Map 第二条法规缺 effective date
- Conflict Inventory 为零但 TOPIC SHEET 说 conflict yes
- Authority Hierarchy 没列出 Tier 1 优先级]

请按 SOP 重新输出。
```

---

## Step 4:Validation Strict 立场跑 - Prompt 3a

**在哪:** 同一对话继续

**做什么:** 粘贴(固定):

```
Research Pack 确认。请按 Deep SOP v1.0 Prompt 3a 执行 STRICT 立场 validation,输出完整 VALIDATION PACK — STRICT。

提醒:
- 立场是"政府执法严格"
- 任何 YMYL 主张无 Tier 1 → Yellow
- 任何法规无三件套 → Yellow
- 任何 Tier 4 单独支撑的 Official-layer 主张 → Red
- 单独输出 Strict pack,不要合并
```

**关键检查:**
- 输出明确标 `Stance: Strict`
- 每个 claim 的判断都基于"严格执法"立场
- Gray-Area-Strict 区块出现(除非主题真的没有 strict-stance 冲突)

---

## Step 5:Validation Gray 立场跑 + 合并

### 5.1 Gray 立场跑 - Prompt 3b

**在哪:** 同一对话继续

**做什么:** 粘贴(固定):

```
Strict Pack 已生成。现在请按 Deep SOP v1.0 Prompt 3b 执行 GRAY 立场 validation,基于同一份 RESEARCH PACK,输出完整 VALIDATION PACK — GRAY。

提醒:
- 立场是"实际操作广泛偏离规则"
- 任何官方 claim 无 Tier 2-4 实际支撑 → Gray-Area-Gray
- 任何 "rule says X" 无 "in practice Y" → Gray-Area-Gray
- 单独输出 Gray pack,不要合并
```

### 5.2 双跑合并 - Prompt 3c

**在哪:** 同一对话继续

**做什么:** 粘贴(固定):

```
Gray Pack 已生成。现在请按 Deep SOP v1.0 Prompt 3c 合并双跑结果,输出 VALIDATION PACK — FINAL (Merged)。

合并规则:
- 两跑都 Green → Final Green
- 一 Green / 一 Yellow → Final Yellow + 标 Gray-Area
- 一 Green / 一 Red → Final Red,omit
- 一 Yellow / 一 Red → Final Red,omit
- 两 Yellow → Final Yellow + caveat
- 两 Red → omit
- 任一跑标 Gray-Area(Strict 或 Gray)→ Final Gray-Area Claim,Layered Writing 必须

升级触发:
- 如果 Final 零 Gray-Area Claims AND Topic Sheet 说 Multi-Source Conflict Expected = yes → ESCALATION,要求重跑 Strict 和 Gray
- 不允许"两跑都 OK 所以 Final Green 全占"
```

**关键检查:**
- Final Gray-Area Claims 区块必须有内容(除非 TOPIC SHEET 明确 Multi-Source Conflict Expected = no)
- 双跑差异点被显式保留,不是被"平均"掉
- 每个 Final Yellow / Final Red claim 注明 source(strict / gray / both)

---

## Step 6:Deep Draft + 自检 - Deep Draft Prompt

**在哪:** 同一对话继续

**做什么:** 粘贴(固定):

```
Validation Pack — Final 确认。现在按 Deep SOP v1.0 的 Deep Draft Prompt 执行:

1. 输出完整的 DEEP DRAFT PACKAGE(含 Self-Audit 带证据)
2. **不要扮演 issue hunter**(Claude QA Pass 1 是独立步骤,不在 ChatGPT 内)
3. **不要尝试 patch**(Patch 是吃了 Claude QA 后的 Step 7)

关键提醒:
- 这是深度车道,factual robustness 优先于 decision-usefulness
- 每个 Final Gray-Area Claim 必须 Layered Writing(Official + Practical 两层都在,不允许压平)
- 每个法规引用必须三件套齐全(全名 + 编号 + effective date)
- 每个 YMYL 主张必须有 Tier 1 来源
- 高风险段落必须有非个性化免责语
- Affiliate 合规检查(不允许"the best"无对比 / 保险金融提及必须 caveat)

输出结构要求:
第一部分: # Frontmatter Block —— 用 ```yaml 代码块``` 包起来
第二部分: # Article —— 用裸三反引号 fence 包起来(不加 markdown 语言标签,避免被 ChatGPT 重新渲染)
第三部分: 其他 Self-Audit 等区块直接写
```

**关键检查 (Self-Audit 必看的 6 个深度独有项):**

1. `regulatory_citation_completeness`:每条法规三件套齐全
2. `effective_date_check`:每条法规标注当前是否 in force(可标 unknown 等 Claude QA)
3. `tier1_source_present`:每个 YMYL 主张有 Tier 1 URL
4. `layered_writing_preserved`:每个 Final Gray-Area Claim 引用 Official 句 + Practical 句
5. `legal_safety_disclaimers`:高风险段落有 disclaimer
6. `affiliate_compliance_check`:每个 affiliate 有 alternative + caveat

如果任一项 fail,**先在 ChatGPT 里要求 GPT 修复**,不要急着切到 Claude(Claude QA 是用来抓 GPT 自己看不见的问题,不是用来兜底 GPT 已经能自检的问题)。

---

## Step 6.5:交接到 Claude — Pass 1

**在哪:** 切到 Claude(claude.ai)新对话

**做什么:** 粘贴(注意必须 4 份 pack 全部带过去,Claude 没有 ChatGPT 项目知识):

```
你是 ExpatGuide 深度车道的 Claude QA Pass 1。

请按 Deep SOP v1.0 的 Claude QA Prompt — Pass 1 执行审查。

你的 4 类工作:
1. Tier 1 来源活体验证(实际跑 web_fetch 验证每个 Tier 1 URL)
2. 法规生效日核查(实际跑 web search / web_fetch 确认每条法规当前状态)
3. 对抗性双视角(政府发言人 + 被误导读者,各至少 3 条)
4. Affiliate 合规审查

请实际调用 web 工具,不要"看起来权威就接受"。

【TOPIC SHEET (Deep)】
[粘贴 TOPIC SHEET 完整内容]

【DEEP RESEARCH PACK】
[粘贴 DEEP RESEARCH PACK 完整内容]

【VALIDATION PACK — FINAL】
[粘贴 VALIDATION PACK FINAL 完整内容]

【DEEP DRAFT PACKAGE】
[粘贴 DEEP DRAFT PACKAGE 完整内容,含 Self-Audit]

按 Pass 1 输出格式返回 ISSUE LIST。如果无实质问题,也要列出至少 3 个"已检查无问题"的项目作为证据。
```

**关键检查:**
- Claude 真的调用了 web_fetch / web search(如果它没有,要求它显式调用)
- 每个 Issue 标了 Severity(Critical / High / Medium / Low)
- 每个 Issue 有 Verification source

**人工判断:**
- Critical / High issues → 必须回 Step 7 patch
- Medium issues → 看具体内容决定是否 patch
- Low issues → 通常可接受(深度车道也不追求 100% 完美,合理工作量内的提升)

---

## Step 7:Patch + Final SEO/GEO - Prompt 5

**在哪:** 回到 ChatGPT 同一对话

**做什么:** 粘贴(替换最后的 Pass 1 ISSUE LIST):

```
Claude QA Pass 1 完成,以下是 ISSUE LIST。请按 Deep SOP v1.0 Prompt 5 最小改动 patch,输出 DEEP FINAL PACKAGE。

关键约束:
- 只做最小必要修改,不重写未提及的段落
- Patch 不得破坏 Layered Writing(Gray-Area Claim 两层必须保留)
- Patch 不得删除法规三件套
- Patch 不得引入新 unsupported facts
- Patch 不得让 affiliate 提及更"促销化"
- Patch Changelog 逐 Issue 映射,标注 Layered Writing affected / Regulatory citation affected

【CLAUDE QA ISSUE LIST — Pass 1】
[粘贴 Claude 返回的完整 ISSUE LIST]

输出结构要求:
第一部分: # Final Frontmatter Block —— ```yaml 代码块```
第二部分: # Final Article —— 裸三反引号 fence(不加 markdown 标签)
第三部分: # Patch Changelog 等其他区块直接写
```

**关键检查:**
- Patch Changelog 每条:Original / Patched / Change type / Meaning changed / Layered Writing affected / Regulatory citation affected
- Final Self-Audit 增加了三项(internal_links_preserved / gray_area_layered_preserved / regulatory_citations_preserved)
- 所有 Pass 1 issues 在 `claude_qa_issues_resolved` 列表里逐项有 verdict

---

## Step 7.5:交接到 Claude — Pass 2

**在哪:** 切回 Claude(可以在 Pass 1 同一对话内继续,Claude 已有 context)

**做什么:** 粘贴:

```
Patch 已完成,以下是 DEEP FINAL PACKAGE。请按 Deep SOP v1.0 的 Claude QA Prompt — Pass 2 执行审查。

你的工作:
1. 对照 Pass 1 每个 ISSUE,确认是否真的修复(读 patched section,不仅信 Patch Changelog)
2. 检查 patch 是否引入了新问题(Layered Writing 压平 / 法规三件套丢失 / Affiliate 漂移 / 内链断 / 新 unsupported claim / Tier 1 来源丢失)
3. 给出最终 Verdict

不要重做 Pass 1 的全文 Tier 1 验证和双视角(那是 Pass 1 的工作)。

【DEEP FINAL PACKAGE】
[粘贴 DEEP FINAL PACKAGE 完整内容]

【参考:CLAUDE QA ISSUE LIST — Pass 1】
[如果在新对话:粘贴 Pass 1 ISSUE LIST。如果在 Pass 1 同一对话:可省略]

按 Pass 2 输出格式返回。
```

**关键检查:**
- Pass 2 给出明确 Verdict:`ready for publication` / `re-patch required` / `structural failure`
- Patch Vulnerability Pattern Audit 6 项全部 pass

---

## Step 8:验收 Pass 2 Verdict

| Pass 2 Verdict | 处理方式 |
|---|---|
| **ready for publication** | 进入 Step 9 保存 |
| **re-patch required**(新增 Critical/High issue) | 回 Step 7 重新 patch + 重跑 Pass 2 |
| **structural failure**(3+ 轮 patch 仍出新问题) | 回 Step 6 重 Draft,前面的 Research / Validation 不动 |

**re-patch 上限**:同一篇文章 patch + Pass 2 循环不超过 3 轮。第 4 轮意味着 Drafting 阶段结构性失败,必须回 Step 6 重新起草。

**这个上限不是"严格 3 轮就停",而是"达到 3 轮时必须停下来反思"**。如果第 3 轮 Pass 2 还有 Critical/High issue,基本可以判定 Drafting 思路有问题,继续 patch 是浪费时间。

---

## Step 9:一次保存到正式目录 + 验证

**在哪:** VS Code 编辑器 + 终端

### 9.1 创建正式目录下的 md 文件

**在哪:** VS Code

**做什么:**

1. 按 **Cmd + N** 新建文件
2. **先粘贴 Frontmatter Block**:在 ChatGPT 找 `# Final Frontmatter Block` 下的 ```yaml 代码块```,点右上角复制按钮,粘贴到文件顶部(包含首尾三个连字符 `---`)
3. **再粘贴 Article**:在 ChatGPT 找 `# Final Article` 下的裸代码块,点右上角复制按钮,粘贴到 frontmatter 下面(中间空一行)
4. **Cmd + S** 保存,文件路径直接选择正式目录:

```
src/content/docs/vietnam/[板块]/[文章 slug].md
```

可用板块路径:
- `src/content/docs/vietnam/visa/`
- `src/content/docs/vietnam/housing/`
- `src/content/docs/vietnam/banking/`
- `src/content/docs/vietnam/healthcare/`
- `src/content/docs/vietnam/daily-life/`
- `src/content/docs/vietnam/digital-nomad/`

### 9.2 文件结构检查

保存后的文件应该长这样:

```markdown
---
title: "How to ... in Vietnam: ..."
description: "..."
sidebar:
  label: "..."
---

## [第一个二级标题]

[正文开始]
```

**检查清单:**
- [ ] 文件顶部是 frontmatter(`---` 开头和结尾各一个)
- [ ] frontmatter 有 title / description / sidebar 三个字段
- [ ] frontmatter 之后空一行
- [ ] 正文**没有 H1 标题**,从 `##` 开始
- [ ] 正文**没有重复 frontmatter**
- [ ] 所有内链是 `[text](/path)` 格式(不是只有蓝色文字 / 不是只有 URL 没有文字)
- [ ] 列表项以 `-` 或 `*` 开头(不是只有圆点渲染效果)

### 9.3 跑验证脚本

**在哪:** VS Code 终端

```bash
bash check-articles.sh src/content/docs/vietnam/[板块]/[文章 slug].md
```

**结果判断:**

| 结果 | 处理方式 |
|---|---|
| `Errors: 0` + 少量 WARN | 通过,进入 Step 10 |
| `Errors: 0` + 0 WARN | 完美,进入 Step 10 |
| 有 Errors | 进入 9.4 修复 |

### 9.4 修复 Errors(如果有)

**在哪:** 回到 ChatGPT 同一对话(不是 Claude!Claude 已经下班)

**做什么:** 粘贴(替换最后的 `[粘贴脚本输出]`):

```
以下是 bash check-articles.sh 的兜底输出,请按 Deep SOP v1.0 Prompt 5 最小改动规则修复列出的 Errors。

注意:这是深度文章,patch 不得:
- 破坏 Layered Writing
- 删除法规三件套
- 改变 affiliate 合规结构

输出要求:
- 只重新输出需要修改的部分,不要重复输出整篇文章
- 如果修改涉及 frontmatter,用 ```yaml``` 代码块输出新的完整 Frontmatter Block
- 如果修改涉及正文,用裸三反引号 fence 输出新的完整 Article

[粘贴脚本输出]
```

修复后,**在 VS Code 里直接编辑正式目录下的文件**,保存后重跑 `bash check-articles.sh [文件路径]`,直到 `Errors: 0`。

如果 Errors 涉及 Layered Writing / 法规引用 / Tier 1 来源等深度独有规则,**必须回到 Claude 跑一次小型 QA**(只针对修改部分),确认 patch 没破坏深度车道核心约束。

### 常见 Errors 类型速查(深度车道)

| Error 类型 | 最常见原因 | 修复方式 |
|---|---|---|
| **OpenAI 引用标记泄漏** | GPT 联网搜索后泄漏 `:contentReference[oaicite:...]` | 回 ChatGPT 让它清理 |
| **硬禁用词** | GPT 不小心用了 AI 味词 | 回 ChatGPT 按 Prompt 5 替换 |
| **断链 / 编造 slug** | 内链指向的 slug 清单里没有 | 回 ChatGPT 用真实 slug 或删除 |
| **SafetyWing/World Nomads 超过 1 次** | 多处植入 | 回 ChatGPT 保留最自然一处 |
| **第一人称** | 非例外的第一人称 | 回 ChatGPT 改第三方语气 |
| **相对路径内链** | 忘加开头 `/` | 直接 VS Code 改 |
| **法规引用三件套不全**(深度独有) | 编辑过程中丢了编号或日期 | 回 ChatGPT 补全,如果 GPT 也不知道 → 回 Claude QA 验证 |
| **Layered Writing 被压平**(深度独有) | Patch 时不小心压平了 | 回 ChatGPT 强制重新 Layered + 必要时小型 Claude QA 确认 |

---

## Step 10:本地预览

**在哪:** VS Code 终端

```bash
npm run dev
```

终端显示本地地址(通常 `http://localhost:4321`)。

**在哪:** 浏览器

**做什么:**
1. 打开 `http://localhost:4321/vietnam/[板块]/[文章 slug]/`(末尾的斜杠重要)
2. 检查:
   - 标题渲染正确,没有重复
   - 所有内链能点开,落地页面正确
   - **Layered Writing 段落清晰可读**(Official + Practical 两层都在)
   - **法规引用三件套显示完整**(全名 + 编号 + 生效日)
   - 没有格式破损(特别是列表、代码块、表格)
   - 移动端体验(Cmd + Option + I 开发者工具,切换设备模式)

预览完回终端按 **Ctrl + C** 停掉 dev server。

---

## Step 11:发布上线

**在哪:** VS Code 终端

```bash
git add .
git commit -m "publish (deep): [文章 slug]"
git push
```

push 后 Cloudflare Pages 自动部署,1-3 分钟内文章上线。

**深度车道 commit message 习惯**:在 commit message 里加 `(deep)` 标识,方便未来回溯哪些文章是深度车道产出的(便于做质量分析和迭代 SOP)。

---

## Step 12:Google Search Console 索引提交

**在哪:** 浏览器 → https://search.google.com/search-console

**做什么:** 与普通车道相同流程

1. 登录 GSC,选择 `expatguide.site` 属性
2. 顶部搜索栏输入新文章的完整 URL
3. 按回车,GSC 会显示该 URL 的当前索引状态
4. 点 **"Request indexing"** 按钮
5. 等 GSC 显示 "Indexing requested" 确认页面,关闭即可

**深度车道额外提醒**:深度文章通常是 YMYL 类高价值内容,GSC 索引提交优先级 > 普通文章。如果当天 GSC 配额有限,先提交深度文章。

---

## Step 13:刷新内链清单 + 同步 ChatGPT 项目知识

**在哪:** VS Code 终端

```bash
bash generate-link-index.sh
git add Research/internal-articles-index.md
git commit -m "refresh internal articles index"
git push
```

**在哪:** chatgpt.com → ExpatGuide 项目 → Files

1. 删除旧的 `internal-articles-index.md`
2. 上传新的 `internal-articles-index.md`(在 `~/expatguide/Research/`)

---

## 完工

一篇深度文章完整流程结束。预计时间:

- **ChatGPT 部分**(Step 2-7,含 Validation 双跑 + Draft + Patch):60-100 分钟
- **Claude QA 部分**(Step 6.5 + Step 7.5):20-40 分钟
- **本地保存 + 验证**(Step 9):10-15 分钟
- **发布 + GSC + 清单 + 同步**(Step 10-13):5-10 分钟

**总计约 90-150 分钟/篇**(普通车道是 40-80 分钟)。

vs 普通车道的多出来的时间,主要花在:
- Validation 双跑(+15-20 分钟)
- Claude QA Pass 1(+10-20 分钟,主要等 web_fetch 验证)
- Claude QA Pass 2(+5-10 分钟)
- 4 次跨工具交接(每次 2-3 分钟粘贴 4 份 pack)

---

## 常见操作速查

### 整个站点健康度检查

```bash
bash check-articles.sh
```

### 某篇文章被哪些文章引用

```bash
bash check-articles.sh --who-links /vietnam/[板块]/[slug]
```

### 更新 Deep SOP 后

1. 更新 `expatguide_deep_sop_v1.x.md`(Research/)
2. 同步更新 `check-articles.sh` 里的对应规则(如果有新的硬规则)
3. 上传新 SOP 到 ChatGPT 项目(覆盖旧版)
4. 跑一次 `bash check-articles.sh` 看老深度文章是否需要回溯修

### Claude QA 时 Claude 没有真的 web_fetch

- 在新一轮对话开头明确要求:"请实际调用 web_fetch 工具验证 Tier 1 来源 URL,不要只看 URL 字符串就判断"
- 如果 Claude 仍然不调用,可能是免费版限制 → 升级 Claude Pro 或换其他对话
- 兜底:你自己手动跑 web_fetch / 浏览器打开 URL 确认

### Claude QA Pass 2 出现循环 patch 怎么办

- 第 1 轮 Pass 2 出 Critical/High issue → 正常,re-patch
- 第 2 轮 Pass 2 仍出 Critical/High issue(且不是同一个) → 警惕,看是不是 Pass 1 漏了什么
- 第 3 轮 Pass 2 仍出 Critical/High issue → 停下来,回 Step 6 重 Draft

---

## 什么情况下要切回普通车道?

如果 Step 2 后,GPT 反馈"这个主题其实不需要深度车道",信它(它没有偏深度的动机)。具体信号:

- TOPIC SHEET 中 `Risk Tier = none-YMYL`
- TOPIC SHEET 中 `Execution Risk = low` 或 `medium`
- TOPIC SHEET 中 `Need Official-vs-Practical Distinction = no`
- TOPIC SHEET 中 `Effective Date Sensitivity > 24 months`
- TOPIC SHEET 中 `Multi-Source Conflict Expected = no`

满足以上**全部**条件时,主题应该走普通车道(操作 SOP v1.3),不要为了"深度看起来更专业"硬走深度车道——会浪费 60+ 分钟却没有质量收益。

---

## v2.0 实战首篇推荐

**vietnam-health-insurance-expats-2026**(Healthcare 旗舰页)

理由:
- 同时触发 health-YMYL + financial-YMYL 双 YMYL
- Multi-Source Conflict 极强(BHYT 官方覆盖 vs 实际报销体验)
- Decision Data Floor 必须触发(保费区间 / 覆盖范围)
- Affiliate 旗舰场景(SafetyWing 自然适配)
- Scope 复杂度高,完美压测 Scope Definition Check
- 失败成本可控(已有 healthcare-vietnam-expats-2026 兜底),成功收益巨大(核心商业页 + 高 GEO 引用率)

跑这一篇,等于一次性测试深度车道 SOP 在 6 个维度的鲁棒性。
