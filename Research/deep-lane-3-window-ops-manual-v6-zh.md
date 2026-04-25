# ExpatGuide 深度车道 3 窗口操作手册 v6（GPT-only 生产版）

## 文档定位

这份文档**给操作者看**，用于深度文章从选题到发布的逐步操作。

它不是项目知识库文件。项目知识库应放对应 SOP / mini-spec 文件，见《ChatGPT 项目配置与指令方案 v6》。

## v6 更新重点

1. Deep Draft 项目知识更新为 `expatguide_deep_sop_gpt_v1.3.md` + `deep-draft-window-spec-v5.3.md`。
2. Deep Risk QA 项目知识更新为 `deep-risk-qa-mini-spec-v4.2.md`，新增 Decision Data Floor 与 Eligibility Matrix 真实性检查。
3. Deep Patch Verify 项目知识更新为 `deep-patch-verify-mini-spec-v4.1.md`，新增 frontmatter 字段白名单和 affiliate URL 格式检查。
4. Step 8 / Step 10 的执行 prompt 同步到新 mini-spec 版本。
5. 保存前必须确认 frontmatter 只含 `title` / `description` / `sidebar.label`，affiliate 链接使用标准 URL。

## v5 更新重点

1. Risk QA 改为复制 `RISK QA HANDOFF BLOCK`，不再手动复制 6 份材料。
2. Patch Verify 改为复制 `PATCH VERIFY HANDOFF BLOCK`，不再手动复制 7 份材料。
3. Source Spot Check 必须输出证据；`unable to verify` 必须说明原因。
4. `no material issues found` 必须显示高风险检查覆盖和潜在失败模式。
5. Project instruction 与 mini-spec 去重，规则细节以 mini-spec 为准。
6. Patch Verify 的 `structural failure` 判定更具体。

---

## 开始前准备

确认已建立 5 个 ChatGPT 项目：

- `ExpatGuide Ops & Strategy`
- `ExpatGuide VN Normal Production`
- `ExpatGuide Deep Draft`
- `ExpatGuide Deep Risk QA`
- `ExpatGuide Deep Patch Verify`

确认 Deep 相关项目知识库：

- Deep Draft：`expatguide_deep_sop_gpt_v1.3.md`、`deep-draft-window-spec-v5.3.md`、最新 `internal-articles-index.md`
- Deep Risk QA：`deep-risk-qa-mini-spec-v4.2.md`、最新 `internal-articles-index.md`
- Deep Patch Verify：`deep-patch-verify-mini-spec-v4.1.md`、最新 `internal-articles-index.md`

建议 chat 命名：

- 窗口 A：`[Country] [Topic] — Deep Draft`
- 窗口 B：`[Country] [Topic] — Risk QA`
- 窗口 C：`[Country] [Topic] — Patch Verify`

高风险主题的 Strict / Gray 双跑可在 Deep Draft 项目内额外开：

- `A-Strict — [Country] [Topic]`
- `A-Gray — [Country] [Topic]`
- `A-Merge — [Country] [Topic]`

---

## 全流程总览

1. 窗口 A：Deep Topic Sheet
2. 窗口 A：Deep Research Pack
3. 窗口 A：Validation Strict
4. 窗口 A：Validation Gray
5. 窗口 A：Validation Final Merge
6. 窗口 A：Deep Draft Package
7. 窗口 A：Deep Claim Sheet + Risk QA Handoff Block
8. 窗口 B：Risk QA + Source Spot Check
9. 窗口 A：Patch / Final Package + Patch Verify Handoff Block
10. 窗口 C：Patch Verify
11. VS Code：保存、bash check、预览、发布、GSC、刷新 index

---

# Step 1：窗口 A 生成 Deep Topic Sheet

## 在哪里

`ExpatGuide Deep Draft` 项目，新 chat。

## 直接粘贴

```text
按 GPT-only Deep SOP 的格式，帮我生成 1 个深度车道选题提案。

Country / City: [国家/城市]
Category: [Visa / Banking / Healthcare / Tax / Insurance / Housing / Daily Life 等]
Goal: [主题说明]

要求：
- 明确 Risk Tier 与 Risk Subtype。
- 明确 Effective Date Sensitivity。
- 明确 Multi-Source Conflict Expected。
- 明确 Primary Scope / Adjacent Space / Decision on Adjacent。
- 如果这个主题不该走 deep lane，请直接说明并建议回 normal lane。

输出完整 DEEP TOPIC SHEET。
```

## 检查

- Risk Tier 是否合理。
- Scope 是否覆盖真实决策空间。
- 如果模型判断应走 normal lane，优先相信，除非你明确要做 flagship。

---

# Step 2：窗口 A 生成 Deep Research Pack

## 直接粘贴

```text
DEEP TOPIC SHEET 通过。请按 GPT-only Deep SOP 输出完整 DEEP RESEARCH PACK。

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

Key Claims Table 每行必须包含 Source URL 和 Source Type: Tier 1 / 2 / 3 / 4。
不得编造法律、政策、费用、生效日期或 slug。
```

## 检查

- Tier 1 来源是否足够。
- Regulatory Source Map 是否有 full name / number / effective date。
- Possible Internal Links 是否都在 index 中。

---

# Step 3：窗口 A 运行 Validation Strict

## 直接粘贴

```text
DEEP RESEARCH PACK 确认。请按 GPT-only Deep SOP 执行 VALIDATION PACK — STRICT。

立场：政府/机构严格执行规则。

要求：
- YMYL claim 无 Tier 1 支撑时默认 Yellow。
- Official-layer claim 只有 Tier 4 支撑时默认 Red。
- 生效日期不清的法规 claim 默认 Yellow。
- 单独输出 STRICT，不要合并。
```

---

# Step 4：窗口 A 运行 Validation Gray

## 高风险主题推荐

对签证、税务、保险、医疗、银行类文章，建议在 Deep Draft 项目里另开 `A-Gray` chat，把同一份 Research Pack 粘过去跑，减少 Strict 结果污染。

## 直接粘贴

```text
请基于同一份 DEEP RESEARCH PACK，按 GPT-only Deep SOP 执行 VALIDATION PACK — GRAY。

立场：实际操作可能偏离纸面规则。

要求：
- 主动找 official rule 与 practical execution 的差异。
- 不把 community report 写成 universal fact。
- 单独输出 GRAY，不要合并。
```

---

# Step 5：窗口 A 合并 Validation

## 直接粘贴

```text
请合并 VALIDATION PACK — STRICT 与 VALIDATION PACK — GRAY，输出 VALIDATION PACK — FINAL (Merged)。

合并规则：
- 两跑都 Green → Final Green
- Green + Yellow → Final Yellow + caveat
- Green + Red → Final Red / omit
- Yellow + Red → Final Red / omit
- 两 Yellow → Final Yellow + caveat
- 任一跑标 Gray-Area → Final Gray-Area Claim，必须 Layered Writing

如果 Topic Sheet 预期有 conflict，但 Final 中没有 Gray-Area Claims，必须解释或要求重跑。
```

---

# Step 6：窗口 A 生成 Deep Draft Package

## 直接粘贴

````text
VALIDATION PACK — FINAL 确认。请按 GPT-only Deep SOP 生成完整 DEEP DRAFT PACKAGE。

要求：
- factual robustness first。
- Final Gray-Area Claims 必须 official + practical 两层都写出。
- 不使用 Red Claims。
- Yellow Claims 必须降级措辞。
- 保留 effective date / eligibility / scope boundary。
- 输出 Frontmatter Block 和 Article 分离代码块。
- Frontmatter Block 只允许 `title` / `description` / `sidebar.label`，不得添加 `slug` / `country` / `city` / `category` / `tags` / `lastUpdated` 等非标字段。
- 如果 markdown 链接 Wise 或 SafetyWing，必须使用 Deep SOP 中的标准 affiliate URL，不得使用普通官网链接。
- Article 从第一个 ## 开始，无 H1，无重复 frontmatter。
- 输出 Deep Self-Audit。

不要 patch。
不要宣布 ready for publication。
````

---

# Step 7：窗口 A 生成 Claim Sheet + Risk QA Handoff Block

## 直接粘贴

```text
请基于刚才的 DEEP DRAFT PACKAGE 输出：

1. DEEP CLAIM SHEET
2. RISK QA HANDOFF BLOCK

DEEP CLAIM SHEET 只列高风险 claim，必须覆盖：
- 法规/政策结论
- 生效日期
- 适用对象
- 资格门槛
- 费用 / 罚金 / 时效 / 有效期
- official vs practical 判断句
- gray-area 判断句
- affiliate-sensitive claim

RISK QA HANDOFF BLOCK 必须完整包含：
- TOPIC SHEET
- DEEP RESEARCH PACK
- VALIDATION PACK — FINAL
- DEEP CLAIM SHEET
- DRAFT FRONTMATTER + ARTICLE
- INTERNAL LINKS USED + AFFILIATE MENTIONS USED + DEEP SELF-AUDIT

使用以下边界：
=== RISK QA HANDOFF BLOCK START ===
...
=== RISK QA HANDOFF BLOCK END ===
```

## 检查

- Claim Sheet 是否有 Source URL(s)。
- Handoff Block 是否 6 段齐全。
- 不要手动拆 6 份材料，直接复制整段 handoff。

---

# Step 8：窗口 B Risk QA + Source Spot Check

## 在哪里

`ExpatGuide Deep Risk QA` 项目，新 chat。

## 直接粘贴

把窗口 A 输出的整段复制进去：

```text
=== RISK QA HANDOFF BLOCK START ===
...
=== RISK QA HANDOFF BLOCK END ===
```

然后补一句：

```text
请严格按 deep-risk-qa-mini-spec-v4.2.md 执行 Risk QA 和 Source Spot Check，输出 GPT QA ISSUE LIST。
```

## 检查

必须看到：

- `Source Spot Check Summary`
- 5–8 个 checked claim
- 每个 checked claim 有 `Evidence observed`
- `unable to verify` 有具体原因
- 如果无实质问题，仍然有高风险检查覆盖和 2 个 likely failure modes

如果没有 Source Spot Check evidence，要求窗口 B 重跑。

---

# Step 9：窗口 A 最小改动 Patch / Final Package

## 分支 A：Risk QA 有 issue

回窗口 A 主 chat，粘贴：

````text
以下是 GPT QA ISSUE LIST。请按 deep lane 最小改动规则 patch。

硬规则：
- 只修 Issue List 中的问题。
- 不重写未提及段落。
- 不引入新 unsupported facts。
- 不为了风格顺手润色。
- 不破坏 Layered Writing。
- 不删除法规 full name / number / effective date。
- 不让 affiliate 更促销。
- Patch Changelog 必须逐 Issue ID 映射。

GPT QA ISSUE LIST:
[粘贴]

输出：
1. DEEP FINAL PACKAGE
2. PATCH VERIFY HANDOFF BLOCK

PATCH VERIFY HANDOFF BLOCK 必须使用：
=== PATCH VERIFY HANDOFF BLOCK START ===
...
=== PATCH VERIFY HANDOFF BLOCK END ===
````

## 分支 B：Risk QA 返回 no material issues found

回窗口 A 主 chat，粘贴：

````text
Risk QA 返回 no material issues found。请不要改正文内容，只把当前 DRAFT PACKAGE 包装成 DEEP FINAL PACKAGE。

要求：
- 不改文章事实、结构、措辞。
- Patch Changelog 写：no material issues found; no patch applied。
- 输出 DEEP FINAL PACKAGE。
- 同时输出 PATCH VERIFY HANDOFF BLOCK。
````

---

# Step 10：窗口 C Patch Verify

## 在哪里

`ExpatGuide Deep Patch Verify` 项目，新 chat。

## 直接粘贴

把窗口 A 输出的整段复制进去：

```text
=== PATCH VERIFY HANDOFF BLOCK START ===
...
=== PATCH VERIFY HANDOFF BLOCK END ===
```

然后补一句：

```text
请严格按 deep-patch-verify-mini-spec-v4.1.md 执行 Patch Verification，输出 PATCH VERIFICATION LIST 和 Final verdict。
```

## 判断

- `ready for local save` → 进入 Step 11。
- `re-patch required` → 回 Step 9，只修窗口 C 指出的点，再回 Step 10。
- `structural failure` → 回 Step 6 重新 draft；Research / Validation 可保留。

---

# Step 11：保存到正式目录

## 在哪里

VS Code。

## 做什么

1. 新建文件。
2. 先复制 `# Final Frontmatter Block` 下的 YAML 代码块。
3. 再复制 `# Final Article` 下的正文代码块。
4. 保存到：

```text
src/content/docs/vietnam/[category]/[article-slug].md
```

当前 Vietnam 常用路径：

```text
src/content/docs/vietnam/visa/
src/content/docs/vietnam/housing/
src/content/docs/vietnam/banking/
src/content/docs/vietnam/healthcare/
src/content/docs/vietnam/daily-life/
src/content/docs/vietnam/digital-nomad/
```

---

# Step 12：bash check

```bash
bash check-articles.sh src/content/docs/vietnam/[category]/[article-slug].md
```

- `Errors: 0` → Step 13。
- 有 errors → 回 Deep Draft 项目机械修复。
- 如果修复影响法规、生效日、eligibility、gray-area、affiliate caveat → 回 Patch Verify 小范围验证。

---

# Step 13：本地预览

```bash
npm run dev
```

检查：

- 页面能打开。
- title / sidebar.label 正常。
- frontmatter 只含 `title` / `description` / `sidebar.label` 三个字段。
- SafetyWing / Wise 等 affiliate 链接使用标准 URL。
- 正文无 H1 重复。
- 内链能点开。
- official / practical 分层清晰。
- gray-area 没被压平。
- 表格、列表、代码块无破损。

---

# Step 14：发布

```bash
git add .
git commit -m "publish (deep): [article-slug]"
git push
```

---

# Step 15：GSC 索引提交

在 Google Search Console 提交新 URL。

---

# Step 16：刷新 internal index 并同步项目知识

```bash
bash generate-link-index.sh
git add Research/internal-articles-index.md
git commit -m "refresh internal articles index"
git push
```

然后替换这些项目里的 `internal-articles-index.md`：

1. `ExpatGuide VN Normal Production`
2. `ExpatGuide Deep Draft`
3. `ExpatGuide Deep Risk QA`
4. `ExpatGuide Deep Patch Verify`
5. `ExpatGuide Ops & Strategy`（推荐）

---

## 完工检查

- [ ] Risk QA 有 Source Spot Check evidence。
- [ ] Patch Verify verdict 是 ready for local save。
- [ ] bash check 无 errors。
- [ ] npm run dev 预览正常。
- [ ] git push 完成。
- [ ] GSC 提交完成。
- [ ] internal index 已刷新并同步。
