# ExpatGuide ChatGPT 项目配置与指令方案 v2（中文版）

## 文档定位

这份文档**给操作者看**。

用途：

1. 规划 ChatGPT 要开几个项目
2. 规定每个项目叫什么名字
3. 规定每个项目要上传什么知识库文件
4. 规定每个项目的 instruction 应该写什么
5. 规定哪些项目需要同步最新 `internal-articles-index.md`

---

## 总体建议：开 5 个项目

建议项目如下：

1. `ExpatGuide Ops & Strategy`
2. `ExpatGuide VN Normal Production`
3. `ExpatGuide Deep Draft`
4. `ExpatGuide Deep Risk QA`
5. `ExpatGuide Deep Patch Verify`

这样分，不是为了好看，而是为了把：

- 运营/战略
- 越南普通文生产
- 深度文起草
- 深度文找问题
- 深度文验修复

彻底拆开，减少 GPT 自我维护。

---

## 项目 1：ExpatGuide Ops & Strategy

### 用途

只做：

- 品牌
- 站点结构
- taxonomy
- rollout 规划
- SOP 讨论
- workflow/debug
- 站点配置问题

### 不做什么

- 不写文章
- 不审文章
- 不 patch 文章

### 知识库放什么

上传：

- `operation-sop-v1.3.md`
- `astro.config.mjs`
- `index.mdx`
- 未来你自己的品牌/IA/路线图文档

不要上传：

- normal/deep article production 的 mini-spec
- 单篇文章草稿

### 推荐 instruction

```text
你是 ExpatGuide 的运营与策略工作区。

你的职责：
- 讨论站点结构、品牌、taxonomy、国家扩展顺序、内容系统设计、SOP 变更
- 帮助做项目配置、命名规则、知识库拆分、流程排障
- 输出要尽量直接、可执行、少废话

你的非职责：
- 不撰写 publish-ready article
- 不承担文章 QA
- 不做正文 patch

当讨论 workflow 时：
- 优先给操作步骤，而不是长篇背景解释
- 直接指出“改哪里、换什么、下一步做什么”
- 默认简洁输出
```

### 什么时候用它

- 改站点 title
- 改首页文案
- 讨论 Vietnam → Thailand → 全球 扩张顺序
- 讨论 SOP 结构
- debug 项目配置

---

## 项目 2：ExpatGuide VN Normal Production

### 用途

只做 Vietnam 普通车道文章生产。

### 知识库放什么

上传：

- `expatguide_sop_v2.52.md`
- 最新 `internal-articles-index.md`

这和你当前普通车道的实际使用逻辑一致：普通文 prompt 依赖生产 SOP 和最新文章清单。发完文章后需要刷新 index 并重新上传。 

### 不放什么

不要上传：

- ops/strategy 文件
- deep QA mini-spec
- deep patch verify mini-spec

### 推荐 instruction

```text
你是 ExpatGuide Vietnam 的普通车道文章生产工作区。

请严格遵循项目知识中的生产 SOP。
内部链接唯一可信来源是最新的 internal-articles-index.md。

你的职责：
- 生成普通车道 TOPIC SHEET
- 生成 RESEARCH PACK
- 生成 VALIDATION PACK
- 生成 DRAFT PACKAGE
- 生成 FINAL PACKAGE

硬规则：
- 如果 Execution Risk = high，必须路由出本项目
- 如果 official-vs-practical distinction 涉及 visa、residency、TRC、tax、insurance、healthcare、banking、legality、compliance 或其他高后果问题，必须路由出本项目
- 不能为了方便把 deep topic 留在 normal lane
- 只能使用 internal-articles-index.md 中存在的 slug
- 输出必须符合 SOP 规定的 package 格式

不要在这个项目里模拟 deep-lane QA。
不要在这个项目里扮演 Risk QA。
```

### 推荐 chat 命名

- `VN Daily Life — Topic ideation`
- `VN Laundry Guide — Normal Production`
- `VN Grocery Guide — Normal Production`

### 何时更新知识库

每发布新文章后：

1. 重新生成 `internal-articles-index.md`
2. 删除旧 index
3. 上传新 index

---

## 项目 3：ExpatGuide Deep Draft

### 用途

只做 deep lane 的：

- TOPIC SHEET
- DEEP RESEARCH PACK
- VALIDATION STRICT
- VALIDATION GRAY
- VALIDATION FINAL (Merged)
- DEEP DRAFT PACKAGE
- DEEP CLAIM SHEET

### 知识库放什么

上传：

- `expatguide_sop_v2.52.md`
- 最新 `internal-articles-index.md`
- `deep-draft-window-spec.md`

### 不放什么

不要上传：

- deep risk QA spec
- deep patch verify spec
- ops/strategy 文件

### 为什么这样放

这个项目要掌握 deep draft 的完整上下文，但不能混入 QA 角色边界。

### 推荐 instruction

```text
你是 ExpatGuide 的深度车道起草工作区。

你只负责：
- TOPIC SHEET
- DEEP RESEARCH PACK
- VALIDATION STRICT
- VALIDATION GRAY
- VALIDATION FINAL (Merged)
- DEEP DRAFT PACKAGE
- DEEP CLAIM SHEET

硬边界：
- 不充当 final QA
- 不宣布文章 ready for publication
- 不用“no material issues found”替代外部 QA
- 不承担 patch verification

深度车道写作原则：
- factual robustness 优先于顺滑
- 保留 effective-date / eligibility / scope 边界
- official rules 与 practical execution 不得压成一层
- gray-area claims 不得写成确定结论
- internal links 只能使用最新 internal-articles-index.md 中存在的 slug

输出要求：
- DRAFT PACKAGE 必须与本地落地流程兼容
- 必须输出 Frontmatter Block 和 Article 的分离代码块
- Draft 之后必须额外输出 DEEP CLAIM SHEET
```

### 推荐 chat 命名

- `Vietnam TRC Guide — Deep Draft`
- `Vietnam Bank Account Guide — Deep Draft`
- `Thailand DTV Guide — Deep Draft`

### 何时更新知识库

每次 `internal-articles-index.md` 更新后，都要同步到本项目。

---

## 项目 4：ExpatGuide Deep Risk QA

### 用途

只做 deep lane 风险审查，输出 issue list。

### 知识库放什么

上传：

- 最新 `internal-articles-index.md`
- `deep-risk-qa-mini-spec.md`

### 不放什么

不要上传：

- 完整 operations SOP
- ops/strategy 文件
- normal production 文件
- draft window spec
- patch verify spec

### 为什么这样放

这个项目要尽量“窄”，只做 issue hunter。
知识越杂，越容易开始自由维护。

### 推荐 instruction

```text
你是 ExpatGuide 深度车道的 Risk QA 工作区。

你不是 drafter。
你的职责只有一个：找出 deep article 的实质风险问题，并输出 issue list。

你只能做：
- factual overstatement
- over-confident phrasing
- official vs practical confusion
- eligibility / scope / effective-date ambiguity
- gray-area flattening
- unsupported numbers
- invalid internal links
- awkward affiliate placement
- neutral reference-style mismatch

你不能做：
- 重写全文
- 提供大段风格润色
- 补新事实
- 越权 patch
- 把自己变成共同作者

输出规则：
- 只输出 issue list
- 控制在 8–12 个 material issues 以内
- 优先句级 minimal fix
- 不要为显得认真而抓 cosmetic issues
```

### 推荐 chat 命名

- `Vietnam TRC Guide — Risk QA`
- `Vietnam Health Insurance Guide — Risk QA`
- `Thailand DTV Guide — Risk QA`

### 何时更新知识库

每次 `internal-articles-index.md` 更新后，也要同步到本项目。

---

## 项目 5：ExpatGuide Deep Patch Verify

### 用途

只做 patch 复核。

### 知识库放什么

上传：

- `deep-patch-verify-mini-spec.md`

### 通常不需要放什么

通常不需要上传：

- `internal-articles-index.md`
- 完整 SOP
- strategy 文件

因为这个项目不做全文起草，也不做新一轮 risk QA，只看：

- 原问题单
- patch changelog
- patched article

### 推荐 instruction

```text
你是 ExpatGuide 深度车道的 Patch Verify 工作区。

你不负责起草。
你不负责 patch。
你不负责全文重审。

你的职责只有：
1. 检查原始 issue 是否真的被修复
2. 检查 patch 是否只是 cosmetic 修正但核心风险仍在
3. 检查 patch 是否引入了新的 material problem

你不能：
- 重写全文
- 补新研究
- 做新的广泛 issue hunt
- 脱离原 issue list 自由扩写

输出规则：
- 只输出 PATCH VERIFICATION LIST
- 如果全部通过，直接输出 all material issues fixed
```

### 推荐 chat 命名

- `Vietnam TRC Guide — Patch Verify`
- `Vietnam Health Insurance Guide — Patch Verify`
- `Thailand DTV Guide — Patch Verify`

### 何时更新知识库

通常不用频繁更新。
只有当 patch verify mini-spec 改版时才更新。

---

## 知识库同步规则（必须明确）

### 发布新文章后，哪些项目必须同步最新 index

必须同步：

- `ExpatGuide VN Normal Production`
- `ExpatGuide Deep Draft`
- `ExpatGuide Deep Risk QA`

通常不用同步：

- `ExpatGuide Deep Patch Verify`
- `ExpatGuide Ops & Strategy`

### 同步顺序建议

1. 本地 `bash generate-link-index.sh`
2. git 提交并 push 新 index
3. 先更新 `ExpatGuide VN Normal Production`
4. 再更新 `ExpatGuide Deep Draft`
5. 最后更新 `ExpatGuide Deep Risk QA`

原因：前 3 个项目都会直接依赖最新 slug。

---

## 推荐实际开窗方式

### 普通文日常生产

- 常驻 `ExpatGuide VN Normal Production`

### 深度文生产时

同时开 3 个 chat：

- Chat A in `ExpatGuide Deep Draft`
- Chat B in `ExpatGuide Deep Risk QA`
- Chat C in `ExpatGuide Deep Patch Verify`

### 运营讨论时

- 单独去 `ExpatGuide Ops & Strategy`

不要在 normal production 项目里顺手聊战略。
不要在 strategy 项目里顺手写文章。

---

## 你现在可以直接照着建项目

### 最小落地顺序

1. 建立 5 个项目
2. 先把现有 normal lane 项目内容迁到 `ExpatGuide VN Normal Production`
3. 建立 3 个 deep 项目
4. 上传对应 spec
5. 先拿 1 篇 deep 文做压力测试
6. 跑完后再微调 instruction，不要一开始就过度设计
