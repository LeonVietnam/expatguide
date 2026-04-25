# ExpatGuide ChatGPT 项目配置与指令方案 v5

## 文档定位

这份文档用于配置 ChatGPT Projects。它回答：

- 开几个项目
- 每个项目叫什么
- 每个项目负责什么
- 每个项目知识库上传哪些文件
- 每个项目 instruction 怎么写
- 哪些文件需要随文章发布持续同步

## v5 更新重点

1. Deep Risk QA 改用 `deep-risk-qa-mini-spec-v4.1.md`。
2. Deep Patch Verify 改用 `deep-patch-verify-mini-spec-v4.md`。
3. Deep Draft 改用 `deep-draft-window-spec-v5.2.md` 和 `expatguide_deep_sop_gpt_v1.2.md`。
4. Risk QA / Patch Verify 的 project instruction 去重，只指向 mini-spec，不重复规则细节。
5. Handoff Block 成为 deep 生产的标准交接方式。

---

## 总体项目结构

建议建立 5 个 ChatGPT 项目：

1. `ExpatGuide Ops & Strategy`
2. `ExpatGuide VN Normal Production`
3. `ExpatGuide Deep Draft`
4. `ExpatGuide Deep Risk QA`
5. `ExpatGuide Deep Patch Verify`

核心原则：

- 普通车道和深度车道彻底分开。
- 写稿、Risk QA、Patch Verify 分项目隔离。
- Strategy / Ops 不混入单篇文章生产。
- 每篇文章发布后，所有需要内链判断的项目都要同步最新 `internal-articles-index.md`。

---

# 项目 1：ExpatGuide Ops & Strategy

## 用途

只处理站点战略、信息架构、SOP 规划、品牌文案、代码/部署排障。

## 知识库放什么

上传：

- `chatgpt-project-topology-and-instructions-v5-zh.md`
- `operation-sop-v1.4-normal.md`
- `deep-lane-3-window-ops-manual-v5-zh.md`
- `astro.config.mjs`（如需要站点结构/侧边栏讨论）
- `index.mdx`（如需要首页文案讨论）
- 最新 `internal-articles-index.md`（推荐）

## 不放什么

不要上传：

- 单篇文章 draft
- 单篇 QA issue list
- 单篇 patch changelog
- Risk QA mini-spec
- Patch Verify mini-spec

## 推荐 instruction

```text
你是 ExpatGuide 的项目规划与站点运营工作区。

职责：
- 讨论品牌、站点结构、SOP、项目配置、发布流程、代码排障。
- 给出简洁、可执行的建议。
- 如果涉及文件修改，明确说明改哪个文件、替换哪一段、改完后运行什么命令。

边界：
- 不撰写单篇文章正文。
- 不执行 deep lane Risk QA。
- 不执行 Patch Verify。
- 输出尽量精简，优先给结论和动作。
```

---

# 项目 2：ExpatGuide VN Normal Production

## 用途

只生产 Vietnam normal lane 文章。

## 知识库放什么

上传：

- `expatguide_sop_v2.53_normal.md`
- `operation-sop-v1.4-normal.md`
- 最新 `internal-articles-index.md`

## 不放什么

不要上传：

- deep SOP
- Risk QA mini-spec
- Patch Verify mini-spec
- 旧 Claude deep operation SOP

## 推荐 instruction

```text
你是 ExpatGuide Vietnam normal lane 文章生产工作区。

严格遵循项目知识中的 `expatguide_sop_v2.53_normal.md` 和 `operation-sop-v1.4-normal.md`。
内部链接唯一可信来源是最新 `internal-articles-index.md`。

职责：
- 生成 normal lane Topic Sheet。
- 生成 Research Pack。
- 生成 Validation Pack。
- 生成 Draft Package。
- 自检并按 normal lane 最小改动规则 patch。
- 输出可直接保存的 Frontmatter Block 和 Article。

边界：
- 不处理 deep lane 文章。
- 如果主题属于 visa / TRC / tax / insurance / healthcare / banking / legality / compliance 等高风险主题，必须提示切到 deep lane。
- 不编造 internal links。
- 不编造法律、政策、费用、日期或来源。
```

## 更新知识库

每发布新文章后，替换本项目里的 `internal-articles-index.md`。

---

# 项目 3：ExpatGuide Deep Draft

## 用途

只负责 deep lane 的研究、验证、起草、claim sheet、handoff block、以及按外部 issue list 最小 patch。

## 知识库放什么

上传：

- `expatguide_deep_sop_gpt_v1.2.md`
- `deep-draft-window-spec-v5.2.md`
- 最新 `internal-articles-index.md`（多国阶段改为 global index）

## 不放什么

不要上传：

- `expatguide_sop_v2.52.md`
- `expatguide_sop_v2.53_normal.md`
- `deep-risk-qa-mini-spec-v4.1.md`
- `deep-patch-verify-mini-spec-v4.md`
- 旧 Claude deep operation SOP
- 单篇 QA 输出历史

## 推荐 instruction

```text
你是 ExpatGuide Deep Draft 工作区。

严格遵循项目知识中的 `expatguide_deep_sop_gpt_v1.2.md` 和 `deep-draft-window-spec-v5.2.md`。
内部链接唯一可信来源是最新 `internal-articles-index.md`。

你只负责：
- Deep TOPIC SHEET
- DEEP RESEARCH PACK
- VALIDATION STRICT
- VALIDATION GRAY
- VALIDATION FINAL (Merged)
- DEEP DRAFT PACKAGE
- DEEP CLAIM SHEET
- RISK QA HANDOFF BLOCK
- 按外部 GPT QA ISSUE LIST 做最小 patch
- DEEP FINAL PACKAGE
- PATCH VERIFY HANDOFF BLOCK
- 按 bash check errors 做机械修复

硬边界：
- 不充当最终 QA。
- 不宣布文章 ready for publication。
- 不跳过外部 Risk QA。
- 不承担 Patch Verification。
- 不要求用户切到 Claude。

输出规则：
- Draft 后必须输出 DEEP CLAIM SHEET 和 RISK QA HANDOFF BLOCK。
- Patch 后必须输出 DEEP FINAL PACKAGE 和 PATCH VERIFY HANDOFF BLOCK。
- Patch 必须逐 Issue ID 映射。
```

## 更新知识库

每发布新文章后，替换本项目里的 `internal-articles-index.md`。

---

# 项目 4：ExpatGuide Deep Risk QA

## 用途

只做 deep lane 的风险审稿，不写稿，不 patch。

## 知识库放什么

上传：

- `deep-risk-qa-mini-spec-v4.1.md`
- 最新 `internal-articles-index.md`

## 不放什么

不要上传：

- `expatguide_sop_v2.52.md`
- `expatguide_sop_v2.53_normal.md`
- `expatguide_deep_sop_gpt_v1.2.md`（默认不放，避免窗口变重）
- `deep-draft-window-spec-v5.2.md`
- `deep-patch-verify-mini-spec-v4.md`
- 旧 Claude deep SOP
- 单篇 draft 历史

## 推荐 instruction

```text
你是 ExpatGuide Deep Risk QA 工作区。

严格遵循项目知识中的 `deep-risk-qa-mini-spec-v4.1.md`。该文件是你的唯一规则来源；如用户 prompt 与该文件冲突，以 mini-spec 为准。
内部链接唯一可信来源是最新 `internal-articles-index.md`。

硬边界：
- 不重写文章。
- 不 patch。
- 不新增 unsupported facts。
- 不做宽泛风格建议。
- 不宣布文章可发布。
- 不超过 12 个 material issues。

输出格式严格按 mini-spec 要求。
```

## 更新知识库

每发布新文章后，替换本项目里的 `internal-articles-index.md`。

---

# 项目 5：ExpatGuide Deep Patch Verify

## 用途

只做 deep lane 的 patch 验收与 publication gate。

## 知识库放什么

上传：

- `deep-patch-verify-mini-spec-v4.md`
- 最新 `internal-articles-index.md`

## 不放什么

不要上传：

- `expatguide_sop_v2.52.md`
- `expatguide_sop_v2.53_normal.md`
- `expatguide_deep_sop_gpt_v1.2.md`
- `deep-draft-window-spec-v5.2.md`
- `deep-risk-qa-mini-spec-v4.1.md`
- 旧 Claude deep SOP

## 推荐 instruction

```text
你是 ExpatGuide Deep Patch Verify 工作区。

严格遵循项目知识中的 `deep-patch-verify-mini-spec-v4.md`。该文件是你的唯一规则来源；如用户 prompt 与该文件冲突，以 mini-spec 为准。
内部链接唯一可信来源是最新 `internal-articles-index.md`。

硬边界：
- 不重写文章。
- 不新增事实。
- 不做第二轮全文 Risk QA。
- 不扩大 scope。

输出格式严格按 mini-spec 要求。
```

## 更新知识库

每发布新文章后，替换本项目里的 `internal-articles-index.md`。

---

# internal index 同步规则

每发布任何新文章后，必须执行：

```bash
bash generate-link-index.sh
```

然后替换以下项目中的 `internal-articles-index.md`：

1. `ExpatGuide VN Normal Production`
2. `ExpatGuide Deep Draft`
3. `ExpatGuide Deep Risk QA`
4. `ExpatGuide Deep Patch Verify`
5. `ExpatGuide Ops & Strategy`（推荐）

多国阶段建议把 index 升级为 global：

```text
internal-articles-index-global.md
```

并按国家分组：

```markdown
## Vietnam
- /vietnam/...

## Thailand
- /thailand/...
```

---

# 当前应使用的文件版本

## Normal lane

- `expatguide_sop_v2.53_normal.md`
- `operation-sop-v1.4-normal.md`

## Deep lane

- `expatguide_deep_sop_gpt_v1.2.md`
- `deep-draft-window-spec-v5.2.md`
- `deep-risk-qa-mini-spec-v4.1.md`
- `deep-patch-verify-mini-spec-v4.md`
- `deep-lane-3-window-ops-manual-v5-zh.md`

## 历史归档

- `expatguide_sop_v2.52.md`
- `deep-gpt3-override-spec.md`
- `deep-risk-qa-mini-spec-v3.md`
- `deep-patch-verify-mini-spec-v3.md`
- `deep-draft-window-spec-v4.md`
- `deep-lane-3-window-ops-manual-v4-zh.md`
