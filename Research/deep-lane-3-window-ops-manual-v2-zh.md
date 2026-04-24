# ExpatGuide 深度车道 3 窗口操作手册 v2（中文版，可复制执行）

## 文档定位

这份文档**给操作者看**，不是给 GPT 项目知识库看的。

用途只有一个：当某个主题已经确定属于 deep lane 时，你就按这份手册一步步执行。

核心原则：

1. 写稿、找问题、验修复，必须拆成 3 个独立窗口
2. 每个窗口只做一件事
3. 操作手册必须尽量做到复制粘贴即可执行
4. 最终本地保存、脚本检查、预览、发布、刷新 index 的落地流程，尽量与普通车道保持一致

---

## 适用范围

以下主题使用这份手册：

- visa
- residency / TRC
- tax
- insurance
- healthcare
- banking
- legality / compliance
- 其他高后果、高时效、高争议主题

不适用于普通车道文章。

---

## 开始前准备

开始前，先确认：

- [ ] 已建立 3 个独立 ChatGPT 项目：
  - `ExpatGuide Deep Draft`
  - `ExpatGuide Deep Risk QA`
  - `ExpatGuide Deep Patch Verify`
- [ ] `internal-articles-index.md` 是最新版本
- [ ] 已打开 `~/expatguide` 项目
- [ ] 已明确文章国家、板块、主题
- [ ] 准备好在 3 个窗口分别新开 chat，不复用同一个 chat 干 3 件事

建议命名：

- 窗口 A：`[Country] [Topic] — Deep Draft`
- 窗口 B：`[Country] [Topic] — Risk QA`
- 窗口 C：`[Country] [Topic] — Patch Verify`

---

## 全流程总览

```text
窗口 A（Deep Draft）
Step 1 选题 → Step 2 Deep Research → Step 3 Validation Strict → Step 4 Validation Gray → Step 5 Merge Validation → Step 6 Deep Draft → Step 7 Deep Claim Sheet

窗口 B（Deep Risk QA）
Step 8 风险审查 → 输出 GPT QA ISSUE LIST

窗口 A（回到 Draft）
Step 9 最小改动 patch → 输出 DEEP FINAL PACKAGE

窗口 C（Deep Patch Verify）
Step 10 验修复 → 输出 PATCH VERIFICATION LIST

本地落地
Step 11 保存 → Step 12 bash check → Step 13 npm run dev → Step 14 git push → Step 15 GSC → Step 16 刷新 index 并同步项目知识
```

---

## Step 1：窗口 A 生成 Deep TOPIC SHEET

### 在哪里做

窗口 A：`ExpatGuide Deep Draft`

### 直接粘贴这个 prompt

```text
按 Deep SOP 的格式，帮我生成 1 个深度车道选题提案。

Scope: [板块名，例如: Visa / Banking / Healthcare / Tax / Daily Life]
Country: [国家]
Goal: [主题说明，例如:
- 想写一篇关于 XXX 的深度指南
- 这是个明确属于深度车道的主题
- 需要完整 TOPIC SHEET，含 Risk Tier、Effective Date Sensitivity、Multi-Source Conflict Expected]

请直接返回一个完整 TOPIC SHEET（Deep）。
重点评估并明确给出：
- Risk Tier
- Effective Date Sensitivity
- Multi-Source Conflict Expected
- Primary Scope
- Adjacent Space
- Decision on Adjacent

如果这个主题其实不需要走 deep lane，请明确告知应切回 normal lane。
```

### 你要检查什么

- 主题确实属于 deep lane
- Scope Definition Check 三字段齐全
- 没有 scope 锁定到单一服务商/单一场景

### 通过后粘贴

```text
TOPIC SHEET 通过。进入 Deep Research。
```

---

## Step 2：窗口 A 生成 DEEP RESEARCH PACK

### 直接粘贴这个 prompt

```text
Topic Sheet 通过。请输出完整的 DEEP RESEARCH PACK。

硬要求：
1. 必须包含这些区块：
- Reader Questions
- Recommended Angle
- Suggested Outline
- Key Claims Table
- Regulatory Source Map
- Authority Hierarchy
- Conflict Inventory
- Eligibility Matrix（如不适用就明确写 not applicable）
- Possible Internal Links
- Potential Weak Spots

2. Key Claims Table 每行必须有：
- Claim
- Source URL
- Source Type（Tier 1 / 2 / 3 / 4）
- Why It Matters
- Freshness Risk
- Official / Practical

3. Regulatory Source Map 每条法规必须尽量给出：
- full name
- regulation number
- promulgating authority
- promulgated date
- effective date
- current status
- supersedes / replaced by

4. Internal links 只能使用 latest internal-articles-index.md 里存在的真实 slug。

请按以上要求直接返回完整 DEEP RESEARCH PACK。
```

### 你要检查什么

- Key Claims Table 字段齐全
- Regulatory Source Map 没有明显缺列
- 如果 Topic Sheet 说 conflict yes，Conflict Inventory 不能空
- Internal links 全都是真实 slug

### 有问题就直接回这个补救 prompt

```text
Research Pack 有以下问题，请按原结构完整重出，不要只补局部：

[把具体问题列出来]
```

---

## Step 3：窗口 A 跑 VALIDATION — STRICT

### 直接粘贴这个 prompt

```text
Research Pack 确认。现在基于同一份 DEEP RESEARCH PACK，执行 VALIDATION PACK — STRICT。

提醒：
- 立场是“政府/机构严格按规则执行”
- 任何高风险官方主张如果没有足够的官方层支撑，不要轻易放 Green
- 不要和 Gray 立场合并
- 单独输出完整 VALIDATION PACK — STRICT
```

### 你要检查什么

- 输出明确标识 Strict
- 严格立场下 Yellow / Red 足够严格
- 有 Gray-Area-Strict 时要保留

---

## Step 4：窗口 A 跑 VALIDATION — GRAY

### 直接粘贴这个 prompt

```text
Strict Pack 已生成。现在基于同一份 DEEP RESEARCH PACK，执行 VALIDATION PACK — GRAY。

提醒：
- 立场是“实际执行广泛偏离规则”
- 任何官方层 claim 如果现实执行层明显不稳，不能直接判成 Green
- 不要和 Strict 合并
- 单独输出完整 VALIDATION PACK — GRAY
```

### 你要检查什么

- 输出明确标识 Gray
- 实操偏离、paper vs practice、rule vs enforcement 被保留下来

---

## Step 5：窗口 A 合并双跑结果，生成 VALIDATION PACK — FINAL

### 直接粘贴这个 prompt

```text
现在请把 VALIDATION PACK — STRICT 和 VALIDATION PACK — GRAY 合并成 VALIDATION PACK — FINAL。

合并规则：
- 两跑都 Green → Final Green
- 一 Green / 一 Yellow → Final Yellow，并标记 Gray-Area 倾向
- 一 Green / 一 Red → Final Red，正文 omit
- 一 Yellow / 一 Red → Final Red，正文 omit
- 两 Yellow → Final Yellow + caveat
- 任一跑标 Gray-Area → Final Gray-Area Claim，正文必须 layered writing

额外规则：
- 不允许把 strict / gray 的差异平均掉
- 如果 Topic Sheet 说 Multi-Source Conflict Expected = yes，而 Final 里 0 条 Gray-Area Claim，请视为失败并重做合并

请输出完整 VALIDATION PACK — FINAL。
```

### 你要检查什么

- Gray-Area Claims 不该消失
- 差异被显式保留，不是被“平均化”

---

## Step 6：窗口 A 生成 DEEP DRAFT PACKAGE

### 直接粘贴这个 prompt

```text
Validation Pack — Final 确认。现在输出完整的 DEEP DRAFT PACKAGE。

硬要求：
1. 这是 deep lane，factual robustness 优先于顺滑和精简
2. Final Gray-Area Claims 必须 layered writing（Official layer + Practical layer 同时保留）
3. 不要在这里自我扮演 final QA
4. 不要在这里提前 patch
5. 所有 internal links 必须来自 latest internal-articles-index.md
6. 输出格式必须与现有文章落地流程兼容：

第一部分：# Frontmatter Block —— 用 ```yaml``` 代码块
第二部分：# Article —— 用裸三反引号 fence，不加 markdown 语言标签
第三部分：其余区块（Internal Links Used / Affiliate Mentions Used / Source Risk Notes / SEO/GEO Notes / Self-Audit）按正常文本输出

Self-Audit 里至少必须包含：
- year_in_title
- sidebar_label_present
- first_person
- banned_words
- affiliate_limits
- absolute_internal_links_only
- official_vs_practical_distinction
- unsupported_claims_omitted
- regulatory_citation_completeness
- effective_date_check
- tier1_source_present
- layered_writing_preserved
- legal_safety_disclaimers
- no_openai_citation_markers

请直接输出完整 DEEP DRAFT PACKAGE。
```

### 你要检查什么

- Frontmatter / Article 分块可直接落地
- Self-Audit 里深度文独有检查项齐全
- layered writing 没被压平

### 如果 Draft 自检已明显 fail，用这个补救 prompt

```text
DEEP DRAFT PACKAGE 自检不通过。请仅根据以下问题重出完整 DEEP DRAFT PACKAGE，不要跳到 QA 或 patch：

[列出问题]
```

---

## Step 7：窗口 A 生成 DEEP CLAIM SHEET

### 直接粘贴这个 prompt

```text
现在基于刚刚输出的 DEEP DRAFT PACKAGE，额外输出一个 DEEP CLAIM SHEET。

要求：
- 只列高风险 claims，不列全文所有句子
- 至少覆盖：法规结论、生效日期、适用对象、资格门槛、费用/罚金/时效、official vs practical 判断句、gray-area 判断句、任何会显著改变读者决策的结论句

每条 claim 用这个格式：

Claim [编号]
- Sentence quote:
- Claim type: official / practical / gray-area
- Source basis:
- Effective date relevance: yes/no
- Eligibility / scope sensitivity: yes/no
- Volatility: low / medium / high
- Safe wording status: safe / needs caution
```

### 你要检查什么

- claim sheet 不是泛泛摘要
- 真正高风险句都被抓出来了

---

## Step 8：窗口 B 做 Risk QA，输出 GPT QA ISSUE LIST

### 在哪里做

窗口 B：`ExpatGuide Deep Risk QA`

### 粘贴材料顺序

只贴这 5 份：

1. TOPIC SHEET
2. DEEP RESEARCH PACK
3. VALIDATION PACK — FINAL
4. DEEP CLAIM SHEET
5. DRAFT ARTICLE（只贴文章正文，不贴整个聊天记录）

### 直接粘贴这个 prompt

```text
你现在是 ExpatGuide 深度车道的 Risk QA。

你的工作只有一个：输出 GPT QA ISSUE LIST。

不要重写全文。
不要补新事实。
不要给大段风格润色建议。
不要越过 issue hunter 身份直接改稿。

请只检查这些类别：
1. factual overstatement
2. misleading or over-confident phrasing
3. official-rule vs practical-execution confusion
4. eligibility / scope / effective-date ambiguity
5. gray-area flattened into certainty
6. unsupported or over-tight numbers
7. invalid internal links / invented slugs / non-absolute paths
8. awkward affiliate placement
9. mismatch with neutral reference-site tone

规则：
- 只抓 material issues
- 优先句级修正，不要要求大改
- 如果一句话方向对但过强，优先建议降级措辞，不要一删了之
- 如果问题已经处理得对，不要重复提
- 控制在 8–12 个 material issues 以内

输出格式严格如下：

GPT QA ISSUE LIST

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

如果没有实质问题，输出：

GPT QA ISSUE LIST
- no material issues found
```

### 你要检查什么

- issue 数量别失控
- 问题要实质，不要 cosmetic
- 没有开始越权重写

### 如果窗口 B 开始乱改，用这个补救 prompt

```text
你越过了 Risk QA 的角色边界。请重做，只输出 material issue list，不要改稿，不要重写结构，不要补新事实。
```

---

## Step 9：窗口 A 按 ISSUE LIST 做最小 patch，输出 DEEP FINAL PACKAGE

### 分支 A：如果窗口 B 输出 no material issues found

直接在窗口 A 粘贴：

```text
Risk QA 返回 no material issues found。
请直接把当前 DEEP DRAFT PACKAGE 重新整理成 DEEP FINAL PACKAGE。

要求：
- 不重写文章
- 只把输出标题标准化为 final 版本
- 输出格式必须是：
  第一部分：# Final Frontmatter Block —— ```yaml``` 代码块
  第二部分：# Final Article —— 裸三反引号 fence
  第三部分：# Final Internal Links Used / # Final Affiliate Mentions Used / # Patch Changelog / # Final SEO/GEO Check / # Final Self-Audit
- Patch Changelog 写：no material issues found
```

### 分支 B：如果窗口 B 输出了 ISSUE LIST

在窗口 A 粘贴：

```text
以下是 GPT QA ISSUE LIST。请按 deep lane 最小改动规则输出 DEEP FINAL PACKAGE。

关键约束：
- 只做最小必要修改
- 不重写未提及的段落
- 不引入新 unsupported facts
- 不扩 scope
- 不把 official vs practical 压成一层
- 不删除法规三件套
- 不让 affiliate 更促销化
- 每个 Issue ID 必须在 Patch Changelog 里逐项映射

【GPT QA ISSUE LIST】
[粘贴完整问题单]

输出格式严格如下：

DEEP FINAL PACKAGE

# Final Frontmatter Block
```yaml
[完整 frontmatter]
```

# Final Article
```
[完整文章正文]
```

# Final Internal Links Used
- ...

# Final Affiliate Mentions Used
- ...

# Patch Changelog
Issue ID:
- original sentence:
- changed sentence:
- change type:
- meaning changed: yes/no
- layered writing affected: yes/no
- regulatory citation affected: yes/no
- why substantive:

# Final SEO/GEO Check
- ...

# Final Self-Audit
- ...
```

### 你要检查什么

- 最终输出格式和普通车道落地方式兼容
- Patch Changelog 真的是逐 issue 映射

---

## Step 10：窗口 C 做 Patch Verify，输出 PATCH VERIFICATION LIST

### 在哪里做

窗口 C：`ExpatGuide Deep Patch Verify`

### 只贴这 3 份

1. 原始 `GPT QA ISSUE LIST`
2. `Patch Changelog`
3. `Final Article`

### 直接粘贴这个 prompt

```text
你现在是 ExpatGuide 深度车道的 Patch Verify。

不要重写文章。
不要做新的全文 QA。
不要补新事实。

你的工作只有三个：
1. 判断每个原始 issue 是否真的修复了
2. 判断是否只是 cosmetic 修正但核心风险还在
3. 判断 patch 是否引入了新的 material problem

输出格式严格如下：

PATCH VERIFICATION LIST

Issue ID:
- status: fixed / partially fixed / not fixed
- reason:
- if not fixed, minimum further fix:

New Issue:
- Quote:
- Category:
- Why risky:
- Minimal fix:

如果全部通过，输出：

PATCH VERIFICATION LIST
- all material issues fixed
```

### 分支处理

#### 如果窗口 C 输出

```text
PATCH VERIFICATION LIST
- all material issues fixed
```

直接进入本地落地。

#### 如果窗口 C 输出 partially fixed / not fixed / new issue

回到窗口 A，粘贴：

```text
Patch Verify 未通过。请只根据下面的 PATCH VERIFICATION LIST 做一轮额外的最小 patch。

规则：
- 只修未通过的问题
- 不重写其他段落
- 不引入新事实
- 输出完整 DEEP FINAL PACKAGE（同前一轮格式）

【PATCH VERIFICATION LIST】
[粘贴完整结果]
```

然后再回窗口 C 复核。

### 循环上限

- Patch Verify 循环不超过 3 轮
- 第 3 轮后仍有 Critical/High 级别问题，回窗口 A 重做 Draft，不要继续 patch

---

## Step 11：本地保存文件

### 怎么保存

1. 复制 `# Final Frontmatter Block` 下的 ```yaml``` 代码块
2. 复制 `# Final Article` 下的裸代码块
3. 新建文件并保存到：

```text
src/content/docs/[country]/[category]/[article-slug].md
```

如果你当前仍是 Vietnam 旧结构，也可以先保存到：

```text
src/content/docs/vietnam/[板块]/[article-slug].md
```

### 文件结构检查

保存后应当长这样：

```markdown
---
title: "..."
description: "..."
sidebar:
  label: "..."
---

## [第一个二级标题]
```

检查：

- [ ] frontmatter 完整
- [ ] 正文从 `##` 开始
- [ ] 没有重复 frontmatter
- [ ] 没有重复 H1

---

## Step 12：跑脚本检查

### 命令

```bash
bash check-articles.sh src/content/docs/[country]/[category]/[article-slug].md
```

### 分支处理

#### 如果 `Errors: 0`
进入 Step 13。

#### 如果有 Errors
回窗口 A，不回窗口 B/C。

粘贴：

```text
以下是 bash check-articles.sh 的输出。请按 deep lane 最小改动规则修复这些 Errors。

注意：
- 不得破坏 layered writing
- 不得删除法规三件套
- 不得改变 affiliate 合规结构
- 只输出需要修改的部分
- 如果改 frontmatter，用 ```yaml``` 代码块
- 如果改正文，用裸三反引号 fence

[粘贴脚本输出]
```

修完后本地覆盖，再重跑 `bash check-articles.sh`。

---

## Step 13：本地预览

### 命令

```bash
npm run dev
```

### 检查

打开本地地址后，检查：

- 标题正常
- 内链能点开
- layered writing 可读
- 法规三件套显示完整
- 列表/表格/代码块没炸
- 手机端没明显错位

---

## Step 14：发布上线

### 命令

```bash
git add .
git commit -m "publish (deep): [article-slug]"
git push
```

---

## Step 15：GSC 提交索引

发布后到 GSC 提交新 URL。

如果当天有提交优先级冲突，深度文优先于普通文。

---

## Step 16：刷新 internal-articles-index 并同步项目知识

### 命令

```bash
bash generate-link-index.sh
git add Research/internal-articles-index.md
git commit -m "refresh internal articles index"
git push
```

### 然后同步到这些项目

至少同步到：

- `ExpatGuide VN Normal Production`
- `ExpatGuide Deep Draft`
- `ExpatGuide Deep Risk QA`

通常不需要同步到：

- `ExpatGuide Deep Patch Verify`
- `ExpatGuide Ops & Strategy`

除非你明确让它们也读 index。

---

## 快速故障分流

### 情况 1：窗口 B 开始像编辑器一样重写文章
处理：重开窗口 B chat，重贴材料，只给 Risk QA prompt。

### 情况 2：窗口 C 开始做新一轮全文 QA
处理：重开窗口 C chat，明确它只能 verify patch，不是重审全文。

### 情况 3：窗口 A 在 Draft 阶段就说 ready for publication
处理：打回。Deep Draft 项目没有 final approval 权限。

### 情况 4：脚本错误和窗口 B/C 的 issue 冲突
处理：先修脚本硬错误，再决定是否需要回窗口 C 小复核。

### 情况 5：Patch 越修越长
处理：说明窗口 A 失控了。重新强调“只按 Issue ID 修”，必要时回到 Draft 重起。

---

## 与普通车道相比，deep lane 额外多出来的东西

1. Strict / Gray 双跑 validation
2. DEEP CLAIM SHEET
3. 独立的 Risk QA 窗口
4. 独立的 Patch Verify 窗口
5. 更严格的 patch 循环上限

这 5 个就是 deep lane 3 窗口策略的核心增量。
