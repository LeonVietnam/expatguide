# ExpatGuide 每日内容生产操作 SOP v1.3

从 0 到发布的通用流程模板。每次写新文章照这个走就行。

## v1.3 更新说明（vs v1.2）

1. SOP 版本号同步升级到 **v2.52**(含 Scope Definition Check、Decision Data Floor、完整 Frontmatter Block 输出)
2. **Step 6-10 合并为单步**:移除 drafts/ 中间目录环节,GPT 输出后直接保存到正式板块目录,一次保存+验证到位
3. Step 5 的 prompt 要求 GPT 输出完整 Frontmatter Block(title + description + sidebar.label),可直接复制到文件顶部,不用手动组装
4. Step 6.4 错误修复流程同步简化(在正式目录原地修,不用 mv)
5. 流程总步数从 15 步缩短到 **11 步**

## v1.2 更新说明（vs v1.1）

1. SOP 版本号统一升级到 v2.5
2. 新增 Step 13:GSC 索引提交——发布即索引,避免新文章等 Google 自然爬取
3. Step 7 验证部分加入 OpenAI citation marker 错误处理说明
4. Step 5 写作 prompt 提醒:关注 GPT 的 affiliate_opportunity_check 自检结果

---

## 整体流程概览

```
[ChatGPT 项目]                    [VS Code 终端]                [浏览器]
     │
  Step 2 → 选题
  (场景 A: 从板块生成候选题)
  (场景 B: 直接确认已有主题)
     │
  Step 3 → Research Pack
     │
  Step 4 → Validation Pack
     │
  Step 5 → Draft + Self-Patch → Final Package
         (含完整 Frontmatter Block + Article)
     │
     └──── 一次性保存到 ────→ src/content/docs/vietnam/[板块]/
                                      │
                            bash check-articles.sh
                                      │
                              0 errors? ──No──→ 回 ChatGPT 修复,原地覆盖
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

## Step 1:每次写新文章前确认

- [ ] ChatGPT Plus 订阅有效
- [ ] ExpatGuide 项目知识里的 `internal-articles-index.md` 是最新的(如果有一段时间没写了,先跑 `bash generate-link-index.sh` 然后重新上传)
- [ ] VS Code 打开了 `~/expatguide` 项目
- [ ] 在 ChatGPT **ExpatGuide 项目**里开一个新对话(不是在项目外开!)

---

## Step 2:选题(二选一)

### 场景 A:不知道写什么,让 GPT 提选题

**在哪:** ChatGPT 对话框

**做什么:** 粘贴(把 `[板块名]` 和 `[方向说明]` 替换成自己的内容):

```
按 SOP v2.52 Prompt 1 的格式,帮我生成 10 个普通车道选题提案。

Scope: [板块名,例如:Daily Life in Vietnam / Housing in Vietnam / Banking in Vietnam]

Goal: [方向说明,例如:
  - 补充 Daily Life 板块的常见实操问题
  - 找 5 个低风险、高搜索意图的选题
  - 优先和 TRC/visa 衔接的日常话题]

请按 Prompt 1 格式返回,并在最后按:
- Best 5 fast-production topics(容易写)
- Best 5 high-value topics(SEO/GEO 价值高)
- Best 5 safest low-risk topics(不需要深度车道)
三个维度给出推荐。
```

**关键检查:**
- 所有提案的 `Execution Risk` 都应该是 low 或 medium,不能是 high(high 要走深度车道)
- `Need Official-vs-Practical Distinction = yes` 且涉及 visa/TRC/healthcare/banking → 警告,应该走深度车道
- GPT 应该已经从项目知识读到 `internal-articles-index.md`,`Suggested Internal Links` 应该列真实 slug

**人工决策:** 从 10 个提案里挑一个你要写的。把它的完整 TOPIC SHEET 在对话里再贴一次:

```
我选这一个,请确认这个 TOPIC SHEET 作为最终选题:

[粘贴选中的 TOPIC SHEET 完整内容]

确认无误后,进入 Step 3。
```

### 场景 B:已经有明确主题,直接生成 Topic Sheet

**在哪:** ChatGPT 对话框

**做什么:** 粘贴(把 `[主题]` 和 `[说明]` 替换):

```
按 SOP v2.52 Prompt 1 的格式,帮我生成 1 个选题提案(不是 10 个选项)。

Scope: [板块名,例如:Housing in Vietnam]

Goal: [主题说明,例如:
  - 想写一篇关于 XXX 的实用指南
  - 这是个已经确定的主题,需要完整的 TOPIC SHEET 来启动后续流程]

请直接返回一个完整 TOPIC SHEET。重点评估 Execution Risk 和 Need Official-vs-Practical Distinction,给出清晰判断。如果判断需要走深度车道,明确告知。
```

**关键检查:** 同场景 A 的检查清单。

---

## Step 3:调研 - Prompt 2

**在哪:** 同一对话继续

**做什么:** 粘贴(这段固定,每次都一样):

```
Topic Sheet 通过。请按 SOP v2.52 Prompt 2 执行,输出完整的 RESEARCH PACK。
```

**关键检查:**
- `Possible Internal Links` 部分列的是真实 slug,不是 `[DOMAIN]` 或编造的路径
- `Key Claims Table` 每行 6 个字段齐全
- 如果出现占位符或编造 slug → 停下,告诉 GPT 重新读取项目知识的 `internal-articles-index.md`

---

## Step 4:验证 - Prompt 3

**在哪:** 同一对话继续

**做什么:** 粘贴(固定):

```
Research Pack 确认。请按 SOP v2.52 Prompt 3 执行 adversarial validation,输出完整 VALIDATION PACK。
```

**关键检查:**
- `Gray-Area Claims` 如果主题涉及"官方规则 vs 实际执行"的主题应该有内容
- 如果返回 0 条但文章明显有 paper-vs-practice 差异 → 让 GPT 重审
- Yellow / Red 分类看起来要够严格(GPT 自审容易偏松,你对照 Research Pack 看有没有明显被放过的 claim)

---

## Step 5:初稿 + 自检 + Patch(合并)- Prompt 4 + 5

**在哪:** 同一对话继续

**做什么:** 粘贴(固定):

```
Validation Pack 确认。现在按 SOP v2.52 Prompt 4 执行:

1. 先输出完整的 DRAFT PACKAGE(包括 Self-Audit 带证据部分)
2. Self-Audit 完成后,立刻扮演 Prompt 5 的 issue hunter 角色,对照 SOP v2.52 规则找出自己 draft 中的所有问题:
   - 硬禁用词、语境敏感词使用是否合理
   - 占位符、OpenAI citation markers (:contentReference / oaicite / {index=)
   - 过度保守,decision-usefulness 是否达标
   - 官方 vs 实际是否区分
   - 内链是否都在清单中
   - 第一人称
   - Affiliate 上限 (≤1 次) 和 affiliate 机会 (自然匹配是否被漏掉)
   - Scope Completeness: Primary Scope + Adjacent Space 是否匹配 Topic Sheet 的声明
   - Decision Data Floor (如适用): 价格区间、时效、落地信息是否齐全
3. 把问题整理成 ISSUE LIST
4. 按 Prompt 5 执行最小改动 patch,输出最终 FINAL PACKAGE

如果第 2 步发现 draft 质量已经很好(无实质问题),直接在 ISSUE LIST 写 "no material issues found",然后把 DRAFT PACKAGE 包装成 FINAL PACKAGE 输出即可(仍然要带 Final Self-Audit)。

关键提醒:
- 这篇是普通车道,decision-usefulness 优先于过度保守
- 所有内链必须在 internal-articles-index.md 清单中
- Self-Audit 的 absolute_internal_links_only 必须逐链列出
- Self-Audit 的 no_openai_citation_markers 必须确认输出不含任何内部引用标记
- Self-Audit 的 affiliate_opportunity_check 必须主动判断是否漏掉自然植入(Wise / SafetyWing / World Nomads)
- Self-Audit 的 scope_completeness 必须确认文章实际覆盖范围匹配 Topic Sheet 声明
- Self-Audit 的 decision_data_present 必须确认(如触发 Decision Data Floor)价格/时效/地点信息齐全

输出结构要求 (v2.52):

第一部分: # Frontmatter Block —— 用 ```yaml 代码块```包起来,包含:
  - title (完整 SEO 标题,含年份)
  - description (meta description, 120-160 字符)
  - sidebar.label (3-6 词短名,高指向性)
  
  格式严格如下(含 --- 分隔):
  ```yaml
  ---
  title: "..."
  description: "..."
  sidebar:
    label: "..."
  ---
  ```

第二部分: # Article —— 用 ```markdown 代码块```包起来,从第一个 ## 开始(无 H1,无重复 frontmatter)

这两个代码块的内容会被直接复制拼接成完整 md 文件,所以结构必须精确。
```

**关键提醒:**
- 务必让 GPT 分成两个独立代码块输出(frontmatter YAML + article markdown),否则复制时会出错
- Frontmatter YAML 块用 ```yaml```,Article 块用 ```markdown```,便于一眼识别

---

## Step 6:一次保存到正式目录 + 验证

**在哪:** VS Code 编辑器 + 终端

这一步把原 v1.2 的"保存草稿 → 跑验证 → 加 frontmatter → 删重复 H1 → mv 正式目录 → 再跑验证"6 步合并成 1 步,因为 GPT 现在直接输出完整 Frontmatter Block,无需手动组装。

### 6.1 创建正式目录下的 md 文件

**在哪:** VS Code

**做什么:**

1. 按 **Cmd + N** 新建文件
2. **先粘贴 Frontmatter Block**:在 ChatGPT 找 `# Frontmatter Block` 下的 ```yaml 代码块```,点右上角复制按钮,粘贴到文件顶部(包含首尾三个连字符 `---`)
3. **再粘贴 Article**:在 ChatGPT 找 `# Article` 下的 ```markdown 代码块```,点右上角复制按钮,粘贴到 frontmatter 下面(中间空一行)
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

**slug** 用 ChatGPT 输出的 Suggested Slug(如果该 slug 未在 roadmap 里出现,参考 roadmap 的决策空间命名原则起一个)。

### 6.2 文件结构检查

保存后的文件应该长这样:

```markdown
---
title: "Vietnam [topic] in 2026: [detail]"
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
- [ ] 正文**没有 H1 标题**(没有单独的 `# 标题` 行),从 `##` 开始
- [ ] 正文**没有重复 frontmatter**(GPT 偶尔会在 Article 块开头又写一次 frontmatter,要删掉)

### 6.3 跑验证脚本

**在哪:** VS Code 终端

```bash
bash check-articles.sh src/content/docs/vietnam/[板块]/[文章 slug].md
```

**结果判断:**

| 结果 | 处理方式 |
|---|---|
| `Errors: 0` + 少量 WARN | 通过,进入 Step 7 |
| `Errors: 0` + 0 WARN | 完美,进入 Step 7 |
| 有 Errors | 进入 Step 6.4 修复 |

### 6.4 修复 Errors(如果有)

**在哪:** 回到 ChatGPT 同一对话

**做什么:** 粘贴(替换最后的 `[粘贴脚本输出]`):

```
以下是 bash check-articles.sh 的兜底输出,请按 SOP v2.52 Prompt 5 最小改动规则修复列出的 Errors,其他地方保持不变。

输出要求:
- 只重新输出需要修改的部分,不要重复输出整篇文章
- 如果修改涉及 frontmatter,用 ```yaml``` 代码块输出新的完整 Frontmatter Block
- 如果修改涉及正文,用 ```markdown``` 代码块输出新的完整 Article

[粘贴脚本输出]
```

拿到修复版后,**在 VS Code 里直接编辑正式目录下的文件**(不用 mv,不用新建):

- 如果只改了正文 → 复制新 Article 内容,全选替换文件里的正文部分
- 如果只改了 frontmatter → 复制新 Frontmatter,全选替换文件顶部 frontmatter 部分
- 如果都改了 → 两处都替换

保存后重跑 `bash check-articles.sh [文件路径]`,直到 `Errors: 0`。

### 常见 Errors 类型速查

| Error 类型 | 最常见原因 | 修复方式 |
|---|---|---|
| **OpenAI 引用标记泄漏** | GPT 开了联网搜索后输出到 markdown 代码块时泄漏 `:contentReference[oaicite:...]` | 回 ChatGPT 让它清理掉所有此类标记,重新输出 |
| **硬禁用词** | GPT 不小心用了 AI 味词 | 回 ChatGPT 按 Prompt 5 最小改动替换 |
| **断链** | 内链指向的 slug 清单里没有 / 编造的 slug | 回 ChatGPT,明确告知清单里没这个 slug,要求用真实 slug 或删除该内链 |
| **SafetyWing / World Nomads 超过 1 次** | 同一文章多处植入 | 回 ChatGPT 让它保留最自然的一处,删除其余 |
| **第一人称 (我们/我/我的)** | 非 FAQ 标题、非 "our + 内链" 例外的第一人称 | 回 ChatGPT 改成第三方语气或 passive voice |
| **相对路径内链** | 忘了加开头的 `/` | 直接在 VS Code 里改 |

### 关于 WARN 的判断

WARN 是给你人工判断的,不强制修复:

- **语境敏感词 WARN**:脚本显示这一行内容,你判断该词是本义使用还是填充语。本义保留,填充语回 ChatGPT 修复。
- **可能的第一人称 I**:通常是缩写或地名误报,偶尔漏掉真实问题,扫一眼即可。
- **孤立页面**:新文章必有的 WARN,发布后再补反向内链。

---
**预期结果:**
- "未找到 title 字段" WARN 消失
- "孤立页面" WARN 仍在(正常)
- 其他 WARN 可能仍在,可以接受

---

## Step 7:本地预览

**在哪:** VS Code 终端

**做什么:**

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
   - 没有格式破损(特别是列表、代码块、表格)
   - 移动端体验(Cmd + Option + I 开发者工具,切换设备模式)

预览完回终端按 **Ctrl + C** 停掉 dev server。

---

## Step 8:发布上线

**在哪:** VS Code 终端

**做什么:**

```bash
git add .
git commit -m "publish: [文章 slug]"
git push
```

push 后 Cloudflare Pages 自动部署,1-3 分钟内文章上线。GitHub commit 旁边绿色勾表示部署成功。

---

## Step 9:Google Search Console 索引提交

**在哪:** 浏览器 → https://search.google.com/search-console

**做什么:**

1. 登录 GSC,选择 `expatguide.site` 属性
2. 顶部搜索栏输入**新文章的完整 URL**,例如:
   ```
   https://expatguide.site/vietnam/housing/electricity-bills-renters-2026/
   ```
3. 按回车,GSC 会显示该 URL 的当前索引状态
4. 页面加载后,会有两种情况:
   - **"URL is not on Google"** → 点 **"Request indexing"** 按钮,等待 1-2 分钟验证完成即可
   - **"URL is on Google"** → 文章已被索引,无需操作
5. 等 GSC 显示 "Indexing requested" 确认页面,关闭即可

**关键提醒:**

- **必须先确认 Cloudflare Pages 部署完成**(GitHub 上新 commit 的绿色勾出现,文章 URL 在浏览器里能正常访问),否则 GSC 爬取时拿到 404 会被标记为失败
- **一个账号每天有提交配额**(通常 10-15 次),一天写很多篇要分批提交
- 提交后**不保证立刻被索引**,但比什么都不做快很多——通常 1-3 天内会被收录,自然爬取可能要 1-4 周
- 对于**时效性强的文章**(法规变更、新政策)尤其重要,不提交等于自愿慢半个月

**为什么这一步必须做:**

Cloudflare Pages 会自动更新 sitemap.xml,但 Google 不会立刻重新抓 sitemap。GSC 的 "Request indexing" 是主动告诉 Google "有新内容,请来看"。对于新站权重还没建立的阶段尤其关键。

---

## Step 10:刷新内链清单

**在哪:** VS Code 终端

**做什么:**

```bash
bash generate-link-index.sh
git add Research/internal-articles-index.md
git commit -m "refresh internal articles index"
git push
```

---

## Step 11:同步 ChatGPT 项目知识

**在哪:** chatgpt.com → ExpatGuide 项目 → Files

**做什么:**
1. 删除旧的 `internal-articles-index.md`
2. 上传新的 `internal-articles-index.md`(在 `~/expatguide/Research/`)

这样下一篇文章跑 prompts 时,GPT 能看到刚发布的新文章作为可链接资源。

---

## 完工

一篇文章完整流程结束。预计时间:
- ChatGPT 部分(Step 2-5):30-60 分钟
- 本地保存 + 验证(Step 6):5-10 分钟
- 发布 + GSC + 清单 + ChatGPT 同步(Step 7-11):5-10 分钟

总计约 **40-80 分钟/篇**。

vs v1.2 的优化:
- 去掉 drafts/ 中间目录,去掉手动加 frontmatter + 删 H1 + mv 三个小步骤
- 整篇文章生产流程从 15 步精简到 11 步

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

### 更新 SOP 或禁用词清单后

1. 更新 SOP md 文件(Research/)
2. 同步更新 `check-articles.sh` 里的对应规则
3. 上传新 SOP 到 ChatGPT 项目(覆盖旧版)
4. 跑一次 `bash check-articles.sh` 看老文章是否需要回溯修

### 新文章没出现在站点上

- 确认 `git push` 成功
- 等 Cloudflare Pages 部署完成(GitHub commit 绿色勾)
- 浏览器强制刷新(Cmd + Shift + R)
- 检查文件路径(必须在 `src/content/docs/vietnam/[板块]/` 下)
- 检查 frontmatter 格式(首尾各三个连字符)

---

## 什么情况下要切到深度车道?

如果 Step 2 的 Topic Sheet 出现以下任一情况,**停下来,不要继续普通车道流程**:

- `Execution Risk = high`
- `Need Official-vs-Practical Distinction = yes` + 主题涉及:
  - visa / residency / TRC
  - tax / insurance
  - healthcare / banking
  - legality / compliance
  - 其他高后果 expat 决策

深度车道需要:
- 更严格执行 Prompt 2 和 Prompt 3
- Prompt 4 用 SOP v2.52 的 Deep Draft Prompt(不是普通 Prompt 4)
- Prompt 4 之后、Prompt 5 之前插入 **Claude QA** 环节(去 Claude 里跑 Claude QA Prompt)
- Prompt 5 patch 时吃 Claude 的 ISSUE LIST

深度车道的完整流程后续单独写一份深度 SOP,现在先保证普通车道跑顺。
