# ExpatGuide ChatGPT 项目设置说明

这份文档说明如何在 ChatGPT Plus 里搭建一个专属的 "ExpatGuide" 项目，让 GPT-5.4 Thinking 在写每篇新文章时都自动带上站内文章清单、SOP 规则，不用每次复制粘贴。

---

## 一次性设置（约 10 分钟）

### 第 1 步：生成最新的 internal-articles-index.md

在项目根目录运行：

```bash
bash generate-link-index.sh
```

这会在 `Research/internal-articles-index.md` 生成最新清单。

### 第 2 步：在 ChatGPT 里创建项目

1. 打开 https://chatgpt.com
2. 左侧边栏找到 **"Projects"** / **"项目"**，点击 **"New Project"** / **"新建项目"**
3. 项目名填：`ExpatGuide`
4. 描述可填：`Content production for expatguide.site using SOP v2.2`

### 第 3 步：配置项目指令（System Instructions）

在项目设置里找到 **"Instructions"** / **"指令"** 字段，粘贴以下内容：

```
You are helping produce content for ExpatGuide, a reference site for expats in Vietnam (expatguide.site).

Core behavior:
- Follow the SOP v2.2 exactly as uploaded in this project's knowledge files.
- When producing any deliverable, use ONLY the prompts defined in SOP v2.2.
- When selecting internal links, use ONLY slugs listed in internal-articles-index.md.
- If a user asks for a draft without explicitly invoking an SOP prompt, remind them which prompt applies and wait for the full input.
- Never invent internal article slugs or use placeholders like [DOMAIN].
- Never break SOP v2.2's banned word list, affiliate caps, or first-person rules.

This is a normal-lane content pipeline unless the user explicitly routes to the deep lane.
```

### 第 4 步：上传项目知识文件

在项目的 **"Files"** / **"知识文件"** 区域，上传两个文件：

1. `expatguide_sop_v2.2.md` — SOP 完整版
2. `Research/internal-articles-index.md` — 站内文章清单

上传后 ChatGPT 会把这两个文件作为项目的持久知识，所有在该项目下的新对话都能访问它们。

---

## 日常使用流程

每次写新文章，在 **ExpatGuide 项目下**开新对话，然后：

### 用法 A：直接引用 SOP 中的 Prompt

```
按 SOP v2.2 Prompt 1 的格式，帮我做 10 个普通车道选题提案。

Scope: Daily Life in Vietnam
Goal: 补充日常生活板块的文章
```

GPT 会从知识文件里读取 Prompt 1 的完整模板，并自动使用 `internal-articles-index.md` 里的 slug 清单。

### 用法 B：完整流程一条龙

```
我选定了这个 Topic Sheet，请按 SOP v2.2 从 Prompt 2 开始跑，一直跑到 Prompt 4。

[粘贴 Topic Sheet]
```

GPT 会依次执行 Research Pack → Validation Pack → Draft Package，每一步都遵守 SOP 规则。

### 用法 C：只跑某一步

```
请执行 Prompt 3 (Validation Pack)。

[粘贴 Research Pack]
```

---

## 清单更新流程（每周或发布新文章后）

```bash
# 1. 在项目根目录重新生成清单
cd ~/expatguide
bash generate-link-index.sh

# 2. Git 提交
git add Research/internal-articles-index.md
git commit -m "refresh internal articles index"
git push

# 3. 上传到 ChatGPT
# - 打开 ExpatGuide 项目
# - Files 区域删除旧版 internal-articles-index.md
# - 上传新版
```

---

## 进阶：Sitemap 兜底

如果你忘记更新清单，在对话里提醒 GPT：

```
如果你对某个内链 slug 不确定，请读取 https://expatguide.site/sitemap.xml 验证存在性。
```

GPT-5.4 Thinking 会用联网工具抓 sitemap 做兜底验证。但这不是主工作流，只是保险。

---

## 项目外的对话怎么办？

**严格要求**：所有 ExpatGuide 相关对话都在该项目下进行。如果不小心在项目外开了对话，关掉重新在项目里开。项目外的对话不会自动加载 SOP 和清单知识。

---

## 检查清单

每次跑完一篇文章，发布前验证：

```bash
cd ~/expatguide
bash check-articles.sh path/to/new-article.md
```

如果 check-articles.sh 报错，把报错内容贴回 ChatGPT：

```
以下是 bash check-articles.sh 的输出，请按 Prompt 5 处理。

[粘贴报错]
```

GPT 会用 Prompt 5 的 patch 流程修正。
