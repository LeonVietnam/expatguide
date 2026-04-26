# Deep Lane Review Constitution

ExpatGuide Vietnam 深度车道复核员的不变约束库。本文件不包含判定标准(那在 protocol),只列出必须遵守的硬规则。SOP 版本升级时同步更新本文件。

当前对应 SOP 版本:
- expatguide_deep_sop_gpt_v1.3
- deep-draft-window-spec-v5.3
- deep-risk-qa-mini-spec-v4.2
- deep-patch-verify-mini-spec-v4.1

---

## 1. 深度车道 7 个核心约束

每篇深度文必须在产出物中体现以下 7 项:

1. **Factual robustness 优先于 decision-usefulness**(但不放弃 decision-usefulness)
2. **法规引用三件套**:全名 + 编号 + 生效日。例:"Law No. 51/2024/QH15, effective from 1 July 2025"
3. **Layered Writing**:Gray-Area Claims 必须 Official + Practical 两层呈现,不允许压平
4. **Eligibility Matrix 必须是硬资格矩阵**:含 visa 类型 / 年龄段 / 雇佣状态等硬条件 + yes/no/conditional 判定语言。软推荐表(good fit / needs review)是失败信号
5. **Tier 1 来源支撑 YMYL 主张**:政府 / 部委 / 央行 / 法规原文。措辞模糊的间接引用不算 Tier 1
6. **Decision Data Floor (DDF)**:产品/服务对比类文章必须含价格区间 + 时效区间 + 落地信息 + 波动 caveat 四类数据
7. **Affiliate 合规**:不"the best"无对比、保险/金融提及必须 caveat、不锁死单一服务商

---

## 2. Frontmatter 字段白名单

只允许 3 字段,其他全部禁止。

允许的字段:

```yaml
---
title: "..."
description: "..."
sidebar:
  label: "..."
---
```

禁止字段(出现即 blocking):

- `slug`
- `country`
- `city`
- `category`
- `tags`
- `lastUpdated`
- `date`
- `publishDate`
- `author`
- `draft`

---

## 3. Frontmatter 字段格式规则

| 字段 | 规则 |
|---|---|
| `title` | 必须含年份(2026 或当前年) |
| `description` | 长度 120-160 字符 |
| `sidebar.label` | 3-5 词最佳,最多 6 词,不重复板块名 |

---

## 4. Affiliate URL 强制模板

文中出现 SafetyWing / Wise / World Nomads 时,必须使用以下模板。普通官网链接(safetywing.com/nomad-insurance、wise.com 等)是 blocking 错误。

| 服务商 | 强制 URL |
|---|---|
| Wise | `https://wise.com/invite/dic/ganqiuh` |
| SafetyWing | `https://safetywing.com/?referenceID=26505542&utm_source=26505542&utm_medium=Ambassador` |
| World Nomads | 待 Leon 提供 CJ affiliate URL,目前可用占位符 `[WORLDNOMADS_AFFILIATE_URL]` |

---

## 5. Affiliate 出现频次与共现规则

| 服务商 | 全文最多自然出现次数 |
|---|---|
| Wise | 1 |
| SafetyWing | 1 |
| World Nomads | 1 |

共现规则:

- World Nomads **不与** SafetyWing 同句出现(违反 = blocking)
- 三者均有具体提及时,必须有 caveat(不锁死单一服务商)

---

## 6. 内链规则

- 格式必须是 `[text](/path)`
- 路径必须是绝对路径(以 `/vietnam/` 开头)
- slug 必须存在于 `internal-articles-index.md`(形式审查由复核员做,真实存在性由 Leon 本地 bash check 验证)

路径结构:

```
/vietnam/[pillar]/[article-slug]
```

6 个 pillar:

- `visa`
- `housing`
- `banking`
- `healthcare`
- `daily-life`
- `digital-nomad`

---

## 7. 写作风格规则

### 7.1 第一人称

| 形式 | 是否允许 |
|---|---|
| 作者第一人称(I think / we recommend / in our experience) | ❌ 禁止 |
| "our + 内链"(our [Vietnam visa guide]) | ✅ 允许 |
| FAQ 标题读者第一人称(Can I... / Do I...) | ✅ 允许 |

### 7.2 禁用词清单

以下词在抽象语境下禁用(具体语境如直接引用法规原文除外):

- `vibrant`
- `bustling`
- `delve`
- `leverage`(抽象用法)
- `robust`(抽象用法)

注:本清单可能扩展,以最新 SOP 为准。

### 7.3 整体语气

- 中性 reference-style
- 无 marketing 语言
- 无 hype 语言
- 不堆砌形容词

---

## 8. 站点其他固定规则

- 标题必须含年份(2026 或当前年)
- 不允许 Travel pillar(保留 expat E-E-A-T focus)
- 保险/金融提及必须 caveat,不直接对比 SafetyWing 与 World Nomads(违反 affiliate 条款)

---

## 9. 站点架构 Plan B(待执行)

Roadmap v2 全部规划文章完成后将执行:

- 为 6 个 pillar 各创建一个手工 `index.md` 着陆页(hub-spoke 结构,GEO/SEO 友好)
- 首页 `index.mdx` 的 Topic 链接从指向单篇文章改为指向板块 index 页(`/vietnam/[pillar]/`)

复核员暂不需要为此做特殊处理,但内链路径 `/vietnam/[pillar]/` 形式应被识别为合法。

---

## 10. 与本文件的关系

- **本文件**:不变约束(规则是什么)
- **deep-lane-review-protocol.md**:复核协议(怎么判定违反、违反多严重、复核报告格式)
- **benchmark-health-insurance-2026.md**:基准首篇(9/10 是什么样)
- **review-failure-patterns.md**:失败模式库(已发现的具体陷阱,持续累积)

复核员应在每次复核时同时调用本文件 + protocol + failure patterns,benchmark 用于评分锚定。
