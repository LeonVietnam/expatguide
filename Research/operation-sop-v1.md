# ExpatGuide 操作 SOP v1.0

从选题到发布上线的完整人工操作流程。每一步都标注了"在哪做"和"做什么"。

---

## 整体流程概览

```
[ChatGPT 项目]                    [VS Code 终端]                [浏览器]
     │
  Prompt 1 → Topic Sheet
     │
  Prompt 2 → Research Pack
     │
  Prompt 3 → Validation Pack
     │
  Prompt 4 + Self-Patch → Final Package
     │
     └──── 复制 markdown ────→ 保存到 drafts/
                                      │
                            bash check-articles.sh
                                      │
                              0 errors? ──No──→ 回 ChatGPT 修复 ──→ 重新保存验证
                                      │ Yes
                              加 frontmatter
                                      │
                              移到正式目录
                                      │
                              npm run dev ──→ 浏览器预览
                                      │
                              git push ──→ Cloudflare 自动部署
                                      │
                            bash generate-link-index.sh
                                      │
                              上传到 ChatGPT 项目知识
```

---

## 准备工作（每次只需做一次）

确保以下东西已就绪：

- ChatGPT Plus 已订阅，ExpatGuide 项目已建好
- 项目知识里有最新的 `expatguide_sop_v2.3.md` 和 `internal-articles-index.md`
- VS Code 打开了 `~/expatguide` 项目
- 项目根目录有 `check-articles.sh` 和 `generate-link-index.sh` 两个脚本

---

## 完整操作步骤

### Step 1：在 ChatGPT 项目里启动新对话

**在哪：** chatgpt.com → 左侧 Projects → ExpatGuide → New chat

**做什么：** 开一个新对话。每写一篇新文章 = 一个新对话。所有 prompt 都在这一个对话里跑完。

---

### Step 2：跑 Prompt 1（选题确认）

**在哪：** ChatGPT 对话框

**做什么：** 粘贴：

```
按 SOP v2.3 Prompt 1 的格式，帮我生成 1 个选题提案。

Scope: [填写主题领域，例如 Daily Life / Housing in Vietnam]

Goal: [填写文章目标，例如：写一篇关于 XXX 的实用指南]

具体说明：这是一个已经确定的主题，请直接按 Prompt 1 的 TOPIC SHEET 格式返回一个完整提案（不是 10 个选项）。重点评估 Execution Risk 和 Need Official-vs-Practical Distinction，给出清晰判断。
```

**关键检查：**
- `Execution Risk` 是 high → 警告，应该走深度车道而不是普通车道
- `Need Official-vs-Practical Distinction = yes` 且涉及 visa/TRC/healthcare/banking → 警告，应该走深度车道

如果触发深度车道路由，停下来重新评估这篇文章是否真的该用普通车道。

---

### Step 3：跑 Prompt 2（调研）

**在哪：** 同一对话继续

**做什么：** 粘贴：

```
Topic Sheet 通过。请按 SOP v2.3 Prompt 2 执行，输出完整的 RESEARCH PACK。
```

**关键检查：**
- `Possible Internal Links` 部分应该列出**真实的 slug**（如 `/vietnam/housing/avoid-rental-scams-vietnam-2026`），不是占位符
- `Key Claims Table` 每行 6 个字段都要齐全
- 如果出现 `[DOMAIN]` 或编造的 slug → 停下来，告诉 GPT 它没正确读取项目知识里的清单

---

### Step 4：跑 Prompt 3（验证）

**在哪：** 同一对话继续

**做什么：** 粘贴：

```
Research Pack 确认。请按 SOP v2.3 Prompt 3 执行 adversarial validation，输出完整 VALIDATION PACK。
```

**关键检查：**
- `Gray-Area Claims` 块应该有内容（如果文章涉及"官方规则 vs 实际执行"）
- 如果返回 0 条 Gray-Area Claims 但文章主题明显有 paper-vs-practice 差异 → 让 GPT 重新审视

---

### Step 5：跑 Prompt 4 + 自检 + Patch（合并版）

**在哪：** 同一对话继续

**做什么：** 粘贴：

```
Validation Pack 确认。现在按 SOP v2.3 Prompt 4 执行：

1. 先输出完整的 DRAFT PACKAGE（包括 Self-Audit 带证据部分）
2. Self-Audit 完成后，立刻扮演 Prompt 5 的 issue hunter 角色，对照 SOP v2.3 规则找出自己 draft 中的所有问题（硬禁用词、语境敏感词使用是否合理、占位符、过度保守、官方 vs 实际是否区分、affiliate、第一人称、内链是否都在清单中、decision-usefulness 是否达标）
3. 把问题整理成 ISSUE LIST
4. 按 Prompt 5 执行最小改动 patch，输出最终 FINAL PACKAGE

如果第 2 步发现 draft 质量已经很好（无实质问题），直接在 ISSUE LIST 写 "no material issues found"，然后把 DRAFT PACKAGE 包装成 FINAL PACKAGE 输出即可（仍然要带 Final Self-Audit）。

关键提醒：
- 这篇是普通车道，decision-usefulness 优先于过度保守
- 所有内链必须在 internal-articles-index.md 清单中
- Self-Audit 的 absolute_internal_links_only 必须逐链列出
- 输出 Final Article 时，请用 ```markdown 代码块```包起来，确保所有内链 [text](/path) 的格式完整、不被渲染
```

**关键提醒：** 务必让 GPT 用 ```markdown 代码块``` 输出 Final Article，否则复制时链接结构会被破坏。

---

### Step 6：复制 markdown 到本地草稿

**在哪：** VS Code

**做什么：**

1. 在 ChatGPT 找到 Final Article 的 ```markdown 代码块```
2. 点代码块右上角的复制按钮（不要手动选中复制）
3. 在 VS Code 按 **Cmd + N** 新建文件
4. 粘贴
5. **Cmd + S** 保存为 `drafts/[文章 slug].md`（slug 用 ChatGPT 输出的 Suggested Slug）

如果 `drafts/` 目录不存在，先在 VS Code 终端跑：

```bash
mkdir -p drafts
```

---

### Step 7：跑本地验证脚本

**在哪：** VS Code 终端（Cmd + ` 或者 View → Terminal）

**做什么：**

```bash
bash check-articles.sh drafts/[文章 slug].md
```

**结果判断：**

| 结果 | 处理方式 |
|---|---|
| `Errors: 0`，只有 WARN | 通过，进入 Step 8 |
| `Errors: 0`，0 WARN | 完美，进入 Step 8 |
| 有 Errors | 进入 Step 7.1 修复 |

#### Step 7.1：修复 Errors（如果有）

**在哪：** 回到 ChatGPT 同一对话

**做什么：** 粘贴：

```
以下是 bash check-articles.sh 的兜底输出，请按 SOP v2.3 Prompt 5 最小改动规则修复列出的 Errors，其他地方保持不变。修复后重新输出完整的 Final Article（用 ```markdown 代码块```包起来）和 Final Self-Audit。

[粘贴脚本输出]
```

拿到修复版后回 Step 6 重新保存，然后 Step 7 重跑验证。直到 `Errors: 0`。

#### 关于 WARN 的判断

WARN 是给你人工判断的，不强制修复：

- **语境敏感词 WARN**：脚本会显示这一行内容，你判断该词是本义使用还是填充语。本义保留，填充语回 ChatGPT 修复。
- **可能的第一人称 I**：通常是地名或缩写误报，但偶尔会漏掉真实问题，扫一眼即可。
- **未找到 title 字段**：drafts/ 阶段必有的 WARN，加 frontmatter 后会消失。
- **孤立页面**：新文章必有的 WARN，发布后再补反向内链。

---

### Step 8：加 Astro frontmatter

**在哪：** VS Code 编辑器

**做什么：** 在 `drafts/[文章 slug].md` 文件最顶部加上：

```yaml
---
title: "[完整文章标题，必须包含年份]"
description: "[文章描述，建议 80-150 字符，从 ChatGPT 输出的 Meta Description 复制]"
---
```

**重要：** 加完 frontmatter 后，**删除文章正文里原本的 H1 标题**（也就是和 frontmatter title 完全相同的那行）。否则 Astro Starlight 会显示两个标题。

例如：

修改前
```markdown
---
title: "Vietnam Electricity Bills for Renters in 2026: ..."
description: "..."
---

Vietnam Electricity Bills for Renters in 2026: How to Read Charges, Pay Safely, and Avoid Landlord Overcharging

If a landlord or building manager...
```

修改后
```markdown
---
title: "Vietnam Electricity Bills for Renters in 2026: ..."
description: "..."
---

If a landlord or building manager...
```

---

### Step 9：移动到正式目录

**在哪：** VS Code 终端

**做什么：** 根据文章主题选择对应板块目录：

```bash
# 选择对应的板块路径，例如：
mv drafts/[文章 slug].md src/content/docs/vietnam/housing/[文章 slug].md
```

可用板块路径：
- `src/content/docs/vietnam/visa/`
- `src/content/docs/vietnam/housing/`
- `src/content/docs/vietnam/banking/`
- `src/content/docs/vietnam/healthcare/`
- `src/content/docs/vietnam/daily-life/`
- `src/content/docs/vietnam/digital-nomad/`

---

### Step 10：在正式目录再跑一次验证

**在哪：** VS Code 终端

**做什么：**

```bash
bash check-articles.sh src/content/docs/vietnam/[板块]/[文章 slug].md
```

**预期结果：**
- "未找到 title 字段" WARN 消失（已经加了 frontmatter）
- 其他 WARN 可能仍在（比如孤立页面、语境敏感词），可以接受

---

### Step 11：本地预览

**在哪：** VS Code 终端

**做什么：**

```bash
npm run dev
```

终端会显示一个本地地址（通常是 `http://localhost:4321`）。

**在哪：** 浏览器

**做什么：**
1. 打开 `http://localhost:4321/vietnam/[板块]/[文章 slug]/`（注意末尾的斜杠）
2. 检查：
   - 标题渲染正确，没有重复
   - 所有内链能点开
   - 没有奇怪的格式破损
   - 移动端体验（Cmd + Option + I 打开开发者工具，切换设备模式）

预览完毕回终端按 **Ctrl + C** 停止 dev server。

---

### Step 12：发布上线

**在哪：** VS Code 终端

**做什么：**

```bash
git add .
git commit -m "publish: [文章 slug]"
git push
```

push 后 Cloudflare Pages 自动部署，通常 1-3 分钟内文章就上线了。可以去 GitHub 看 commit 状态，或者直接刷新生产站点。

---

### Step 13：更新内链清单

**在哪：** VS Code 终端

**做什么：**

```bash
bash generate-link-index.sh
```

新文章会自动加入清单。然后：

```bash
git add Research/internal-articles-index.md
git commit -m "refresh internal articles index"
git push
```

---

### Step 14：同步 ChatGPT 项目知识

**在哪：** chatgpt.com → ExpatGuide 项目设置

**做什么：**
1. 进入项目，点 **Files** / **知识文件** 区域
2. 删除旧的 `internal-articles-index.md`
3. 上传新的 `internal-articles-index.md`（在 `~/expatguide/Research/` 目录）

这样下一篇文章跑 Prompt 1/2/4/5 时，GPT 就能看到刚发布的新文章作为可链接的内部资源。

---

## 完工

到这里一篇文章的完整流程结束。整个过程预计：
- ChatGPT 部分（Step 1-5）：30-60 分钟
- 本地验证 + 发布（Step 6-14）：10-15 分钟

---

## 常见操作速查

### 只想检查整个站点的健康度

```bash
bash check-articles.sh
```

### 想知道某篇文章被哪些文章引用

```bash
bash check-articles.sh --who-links /vietnam/visa/visa-guide-2026
```

### 修改 SOP / 禁用词清单 / Affiliate 规则后

1. 更新 SOP md 文件
2. 同步更新 `check-articles.sh` 里的对应规则
3. 上传新 SOP 到 ChatGPT 项目（覆盖旧版）
4. 跑一次 `bash check-articles.sh` 看老文章是否需要回溯修

### 添加新文章后没出现在站点上

- 先确认 `git push` 成功
- 等 Cloudflare Pages 部署完成（GitHub 上 commit 旁边应该有绿色勾）
- 浏览器强制刷新（Cmd + Shift + R）
- 检查文件路径是否正确（必须在 `src/content/docs/vietnam/[板块]/` 下）
- 检查 frontmatter 格式是否正确（首尾各三个连字符）

---

## 升级路径

未来可以考虑的优化：

- **当前是手动 push**，每次提交前手动跑 check-articles.sh。可以加 git pre-commit hook，每次 commit 前自动跑，errors > 0 就阻止 commit。
- **当前 ChatGPT 项目知识需要手动同步**，未来可以用 Custom GPT 加上 OpenAI Actions 自动从 GitHub 拉最新清单。
- **当前每篇文章都是单独对话**，未来产量上去了可以做模板化对话脚本。

但这些都是优化，不是当务之急。**当前流程已经能稳定产出可发布质量的内容。**
