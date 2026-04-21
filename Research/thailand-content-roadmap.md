# ExpatGuide Thailand 完整选题规划 v1

**生成日期**: 2026-04-22
**目标 URL**: expatguide.site/thailand/ (下一国家站点,复用 Vietnam 站技术栈)
**泰国站饱和目标**: 55-68 篇(各板块最低 5 篇,与 Vietnam 对齐)
**启动前置条件**: Vietnam 站 ≥ 50 篇 + GSC 稳定流量 30 天

---

## v1 设计说明

本 Roadmap 完全复用 Vietnam Roadmap v2 的方法论,直接继承以下原则:

1. **决策空间命名**:所有选题用 "how to ... (covering 哪些选项)" 句式,避免 GPT 锁 scope
2. **车道分流**:🟢 普通 / 🔴 深度 / 🟡 边界,与 SOP v2.52(普通)+ Deep SOP v1.0(深度)配套
3. **优先级分级**:⭐⭐⭐ 必写 / ⭐⭐ 应写 / ⭐ 可选
4. **主题描述可整句复制**到 ChatGPT Prompt 1 的 Goal 字段

### 与 Vietnam 的关键差异(影响选题设计)

相比 Vietnam,Thailand 2026 的 expat 生态有几个关键特征会影响选题优先级:

1. **DTV 签证(2024 年推出)**是 Thailand 的杀手锏,Vietnam 没有类似产品。这让 Digital Nomad 板块在 Thailand 比 Vietnam 更核心,应优先产出。
2. **海外汇入所得税(2024 年起)+ CRS 实施** 让 financial-YMYL 主题的深度需求远高于 Vietnam(Vietnam 当前类似主题还停留在 BHYT 层)。
3. **Thailand 医疗旅游成熟度**(dental / cosmetic / 手术价格优势)是 Vietnam 没有的独立子主题,Healthcare 板块因此更丰富。
4. **Thailand 有多个核心 expat 城市**(Bangkok / Chiang Mai / Phuket / Hua Hin / Pattaya / Koh Samui / Krabi),Vietnam 只有 3 个。Housing 和 Daily Life 板块的城市对比文章会更多。
5. **Thailand 60 天免签可能缩回 30 天**(2026-03 提案,未落地),Visa 板块时效性比 Vietnam 更紧。
6. **Thailand 泰文 vs 英文的语言鸿沟** 比 Vietnam 深(Vietnam 北部青年英语渗透率高于 Thailand 非 Bangkok 区域),Daily Life 板块的"语言问题如何应对"是独立 worth-writing 主题。

### 使用方法

在 ChatGPT 项目对话里,Step 2 场景 B(已知主题)时:

```
按 SOP v2.52 Prompt 1 的格式(普通车道)/ Deep SOP v1.0 Prompt 1 的格式(深度车道),帮我生成 1 个选题提案。

Scope: [板块名,例如 Daily Life in Thailand]

Goal: [直接复制下面表格里的 "主题(复制即用)" 字段整句内容]

请直接返回一个完整 TOPIC SHEET...
```

---

## 车道说明

| 标识 | 含义 | SOP |
|---|---|---|
| 🟢 普通 | Decision-usefulness 优先,普通车道流程 | 普通 SOP v2.52 + 操作 SOP v1.3 |
| 🔴 深度 | Fact-robustness 优先,深度车道 + 双跑验证 + Claude QA Pass 1/2 | 深度 SOP v1.0 + 深度操作 SOP v2.0 |
| 🟡 边界 | 具体切角可决定车道,写前先判断 | 视切角定 |

## 优先级说明

| 标识 | 含义 |
|---|---|
| ⭐⭐⭐ 必写 | 高搜索需求 + 明显空缺,优先生产 |
| ⭐⭐ 应写 | 中等搜索需求,填充板块完整性 |
| ⭐ 可选 | 补完性质,晚些再写 |

---

## 板块结构预设(Thailand 版)

基于 Thailand expat 生态特征,预设 6 个核心板块(与 Vietnam 保持对齐,便于读者跨站迁移):

1. **Visa** — DTV / LTR / 60-day exemption / business visa / retirement visa
2. **Housing** — Bangkok 核心区、Chiang Mai、Phuket、其他度假城市、合同陷阱
3. **Banking** — 外国人开户、跨境汇款、Thai bank app 英文可用性、CRS 影响
4. **Healthcare** — 公立 vs 私立、医疗旅游、保险、急诊、牙科 / 美容
5. **Daily Life** — 成本对比、SIM / 网络、交通、购物、语言应对
6. **Digital Nomad** — DTV 深度、coworking、城市对比、税务 setup

---

## Phase 1:普通车道优先(目标冲到 35-40 篇)

### Daily Life 板块

**当前 0 篇 / 目标 15-18 篇 / 还差 15-18 篇**

| 优先级 | 车道 | 建议 slug | 主题(复制即用) |
|---|---|---|---|
| ⭐⭐⭐ | 🟢 | `thailand-cost-of-living-2026` | How much does it cost to live in Thailand in 2026 — covering Bangkok (central vs outer), Chiang Mai, Phuket, and Hua Hin as main expat cities, with realistic monthly budgets from lean to mid-range lifestyles, housing / food / transport / healthcare breakdown, and Southeast Asia cost comparison |
| ⭐⭐⭐ | 🟢 | `thailand-sim-card-guide-2026` | How to get a SIM card in Thailand as a foreigner — covering AIS, TrueMove, DTAC (now part of True), tourist SIM vs local SIM, eSIM options, passport registration requirements, and which provider has the best coverage/price for different use cases |
| ⭐⭐⭐ | 🟢 | `thailand-essential-apps-2026` | The complete app guide for expats arriving in Thailand in 2026 — covering ride-hailing (Grab, Bolt), payments (TrueMoney, PromptPay, Rabbit LINE Pay), food delivery (Grab Food, LINE MAN, foodpanda), translation, maps, government services, and expat-oriented communication apps |
| ⭐⭐⭐ | 🟢 | `thailand-home-internet-2026` | How to set up home internet in Thailand — covering major ISPs (AIS Fibre, True, 3BB, NT), typical speeds and pricing, contract length and deposit rules, landlord-handled vs tenant-handled installation, backup 5G SIM strategies, and realistic setup timelines |
| ⭐⭐⭐ | 🟢 | `bangkok-public-transport-2026` | How to use public transport in Bangkok — covering BTS Skytrain, MRT Blue/Purple/Yellow/Pink lines, Airport Rail Link, city buses, khlong (canal) boats, Chao Phraya river ferries, and when Grab or motorbike taxi makes more sense |
| ⭐⭐⭐ | 🟢 | `thailand-grocery-shopping-2026` | How to do grocery shopping in Thailand as an expat — covering modern chains (Tops, Villa Market, Gourmet Market, Big C, Lotus's / formerly Tesco Lotus), international supermarkets (Foodland, Villa Market expat lines), traditional wet markets (talad sot), and delivery apps (Rabbit Mart, Tops Online, HappyFresh) |
| ⭐⭐⭐ | 🟢 | `thailand-drinking-water-2026` | How to handle drinking water in Thailand — covering bottled water brands, home water delivery services (Sprinkle, Crystal, Singha), counter-top / under-sink filters, whole-house systems, and what to use for cooking vs drinking across Bangkok, Chiang Mai, and beach cities |
| ⭐⭐ | 🟢 | `thailand-aircon-guide-2026` | How to handle air conditioning in Thailand apartments — covering buying (inverter vs non-inverter, Mitsubishi / Daikin / LG / Haier), installation costs, cleaning frequency and local providers, electricity-saving settings, and Thai-specific humidity considerations |
| ⭐⭐ | 🟢 | `thailand-mosquitoes-dengue-2026` | How to protect yourself from mosquitoes and dengue in Thailand — covering seasonal risk by region (Bangkok / north / south / islands), repellent products (OFF, Soffell, Sketolene), home setup (screens, nets, traps), 2026 dengue vaccine availability, and what to do if infected |
| ⭐⭐ | 🟢 | `thailand-laundry-services-2026` | How to handle laundry in Thailand — covering in-unit washers, condo laundry rooms, independent neighborhood laundry shops (ranai reed pha), pickup-delivery services, dry cleaning, typical pricing per kg, and which option fits which housing type |
| ⭐⭐ | 🟢 | `thailand-barber-haircut-2026` | How to get a haircut in Thailand as a foreigner — covering expat-oriented salons in Bangkok / Chiang Mai / Phuket, local Thai barbershops, chain options (Chalachol, Lock's, Jacques Dessange), hotel salons, pricing ranges, and what to say/show to avoid miscommunication in Thai |
| ⭐⭐ | 🟡 | `thailand-streaming-vpn-2026` | How to access international streaming and websites in Thailand — covering which services work natively (Netflix TH, YouTube, Disney+ Hotstar), geo-restricted content, VPN options and Thailand's ambiguous legal status for personal use, and workarounds for common scenarios ⚠️ 法律模糊,写前评估是否走深度 |
| ⭐⭐ | 🟢 | `thailand-air-quality-pm25-2026` | How to deal with air quality in Thailand — covering Chiang Mai burning season (Feb-Apr), Bangkok PM2.5 patterns, AQI tracking apps (IQAir, AirVisual), air purifier shopping (local brands vs imported), masks, and home setup strategies |
| ⭐⭐ | 🟢 | `thailand-songkran-survival-2026` | How to survive Songkran (Thai New Year) as an expat in Thailand — covering what's open and closed (restaurants, banks, transport), water-festival safety and etiquette, cash needs, travel disruption, and whether to stay or leave the country |
| ⭐⭐ | 🟢 | `thailand-grocery-delivery-apps-2026` | How to use grocery delivery apps in Thailand — covering Rabbit Mart, Tops Online, HappyFresh, Lotus's online, Foodland delivery, and the key differences in product range, delivery speed, payment options, and expat-friendliness |
| ⭐ | 🟢 | `thailand-expat-gym-fitness-2026` | How to find a gym or fitness option in Thailand — covering international chains (Fitness First, Virgin Active, Anytime Fitness), mid-range local (Jetts, True Fitness), hotel gyms, independent neighborhood gyms, Muay Thai gyms, yoga/pilates studios, and outdoor running groups, with city-specific pricing |
| ⭐ | 🟡 | `thailand-pet-import-2026` | How to bring a pet to Thailand — covering import regulations, required documents (rabies vaccine, health certificate, microchip), airline requirements, Bangkok airport pet handling, post-arrival quarantine rules, and expat-friendly local vet networks ⚠️ 涉检疫法规,可能走深度 |
| ⭐ | 🟢 | `thailand-urban-driving-2026` | How to drive a car in Thailand's cities — covering International Driving Permit vs local license, insurance must-haves, Bangkok traffic survival, parking realities, Grab vs self-driving trade-off, and safer alternatives to self-driving for new arrivals |

---

### Digital Nomad 板块

**当前 0 篇 / 目标 12-15 篇(比 Vietnam 多,因为 DTV 是 Thailand 强项)/ 还差 12-15 篇**

| 优先级 | 车道 | 建议 slug | 主题(复制即用) |
|---|---|---|---|
| ⭐⭐⭐ | 🟢 | `best-cafes-remote-work-bangkok-2026` | Best cafes for remote work in Bangkok — covering a shortlist by neighborhood (Sukhumvit, Thonglor, Ari, Silom, Phrom Phong), evaluating WiFi speed, power outlets, noise level, laptop-friendliness, price range, and ideal use cases (deep work vs call-friendly vs long session) |
| ⭐⭐⭐ | 🟢 | `best-cafes-remote-work-chiang-mai-2026` | Best cafes for remote work in Chiang Mai — covering a shortlist by neighborhood (Nimman, Old City, Santitham, Chang Phueak), evaluating WiFi speed, power outlets, noise level, laptop-friendliness, price range, and why Chiang Mai has the densest cafe-work culture in Southeast Asia |
| ⭐⭐⭐ | 🟢 | `best-cafes-remote-work-phuket-2026` | Best cafes for remote work in Phuket — covering a shortlist by area (Patong, Rawai, Kata, Phuket Town), evaluating WiFi speed, power outlets, noise level, laptop-friendliness, price range, and beach-town work-life rhythm realities |
| ⭐⭐⭐ | 🟢 | `best-coworking-spaces-thailand-2026` | Best coworking spaces in Thailand — covering Bangkok (The Hive, Hubba, Ad Lib, WeWork), Chiang Mai (Punspace, Yellow, CAMP, Alt_ChiangMai), Phuket (Hatch, Garage Society), and Koh Samui / Koh Phangan co-living hybrids, with pricing ranges, community fit, and use-case guidance |
| ⭐⭐⭐ | 🟢 | `bangkok-vs-chiang-mai-vs-phuket-nomad-2026` | Bangkok vs Chiang Mai vs Phuket as a digital nomad base in 2026 — an honest comparison covering internet reality, coworking density, time-zone fit, DTV visa suitability, cost of living, nomad community size, and lifestyle trade-offs. Not another cost-of-living article |
| ⭐⭐⭐ | 🟢 | `thailand-internet-speed-reality-2026` | How fast is internet in Thailand really — covering real-world speed tests across Bangkok, Chiang Mai, Phuket, and island destinations, comparison of AIS Fibre / True / 3BB / NT, home vs mobile vs 5G, backup SIM strategies, and what you get for entry/mid/high-tier plans |
| ⭐⭐⭐ | 🟢 | `thailand-nomad-community-meetups-2026` | How to find a digital nomad community in Thailand — covering Chiang Mai Nomad groups, Bangkok tech meetups, Phuket beach-nomad scenes, Koh Phangan co-living communities, active Facebook groups and Slack/Discord channels, and where to meet nomads offline in each city |
| ⭐⭐ | 🟢 | `chiang-mai-vs-bali-nomad-2026` | Chiang Mai vs Bali as a digital nomad base in 2026 — comparing cost, internet, visa friendliness (DTV vs KITAS B211A), community density, healthcare, and lifestyle for remote workers deciding between the two most popular Southeast Asia nomad hubs |
| ⭐⭐ | 🟢 | `thailand-as-se-asia-base-2026` | How to use Thailand as a base for exploring Southeast Asia — covering direct flight connectivity from Bangkok / Chiang Mai / Phuket, weekend-trip destinations, multi-country visa routing, and cost comparison of basing in Thailand vs Vietnam vs Bali for regional hopping |
| ⭐⭐ | 🟢 | `budget-digital-nomad-thailand-2026` | How to live as a digital nomad in Thailand on a tight budget — covering sub-$1200 monthly setups by city (Chiang Mai / smaller towns / Koh Phangan off-season), accommodation strategies (co-living, monthly guesthouses, sharing), daily food/transport optimization, and where Thailand outperforms vs underperforms other cheap nomad destinations |
| ⭐⭐ | 🟢 | `thailand-koh-phangan-nomad-guide-2026` | Koh Phangan as a digital nomad base in 2026 — covering why it's become a major nomad hub (beach + cost + community), internet reality on the island, coworking and co-living options (Beachub, Mojo Dojo), visa practicality, and who shouldn't choose Koh Phangan as a base |
| ⭐ | 🟢 | `thailand-print-scan-courier-documents-2026` | Need to print, scan, copy, or send documents in Thailand? This 2026 guide shows where to go first (copy shops near BTS stations, coworking space services, 7-Eleven print kiosks), what to prepare, and when international couriers (DHL / FedEx / Thai Post EMS) make sense |

---

### Housing 板块

**当前 0 篇 / 目标 12-15 篇(比 Vietnam 多,因为 Thailand 有多个核心 expat 城市)/ 还差 12-15 篇**

| 优先级 | 车道 | 建议 slug | 主题(复制即用) |
|---|---|---|---|
| ⭐⭐⭐ | 🟢 | `best-neighborhoods-bangkok-expats-2026` | A BS-free breakdown of where foreigners actually live in Bangkok right now, covering Sukhumvit (Nana / Asok / Phrom Phong / Thonglor / Ekkamai / On Nut), Sathorn-Silom, Ari, Rama IX, Bang Na, with rent ranges, BTS/MRT accessibility, expat density, and who each neighborhood fits |
| ⭐⭐⭐ | 🟢 | `best-neighborhoods-chiang-mai-expats-2026` | A practical guide to where foreigners live in Chiang Mai, covering Nimmanhaemin, Old City, Santitham, Chang Phueak, Hang Dong, San Sai, Mae Rim, with rent ranges, expat community density, motorbike vs walkability, and lifestyle fit |
| ⭐⭐⭐ | 🟢 | `best-neighborhoods-phuket-expats-2026` | Where foreigners actually live in Phuket in 2026, covering Rawai/Nai Harn, Kata/Karon, Chalong, Patong, Phuket Town, Cherngtalay/Bang Tao, with rent ranges, long-term vs short-term differences, family vs single fit, and rainy-season reality |
| ⭐⭐⭐ | 🟢 | `thailand-avoid-rental-scams-2026` | The practical expat guide to renting safely in Thailand in 2026. Covers fake landlord tricks, deposit withholding patterns, contract red flags, non-owner listings on Facebook groups, and what to verify before transferring a deposit |
| ⭐⭐⭐ | 🟢 | `bangkok-vs-chiang-mai-cost-housing-2026` | Bangkok vs Chiang Mai housing cost reality in 2026 — covering same-quality apartment price comparison, BTS-accessible Bangkok vs Nimman-area Chiang Mai, condo vs house trade-off by city, utility cost differences, and when each city wins on value |
| ⭐⭐ | 🟢 | `thailand-condo-vs-apartment-2026` | Condo vs apartment vs serviced apartment in Thailand — covering the legal and practical differences in Thailand's rental market, what each includes (cleaning, utilities, amenities), flexibility for short vs long-term, price differences, and decision guide by length of stay |
| ⭐⭐ | 🟢 | `thailand-rental-viewing-checklist-2026` | What to check when viewing a rental in Thailand — a practical checklist covering structural (water damage, wiring, aircon age), documentation (landlord ID, chanote/title check), utility setup (electricity and water account types), neighborhood (flood history, noise), and questions to ask the landlord/agent |
| ⭐⭐ | 🟢 | `thailand-apartment-furniture-2026` | How to furnish an apartment in Thailand as an expat — covering IKEA Thailand, Index Living Mall, SB Design Square, HomePro/HomeWorks, local furniture districts, e-commerce (Lazada, Shopee), secondhand Facebook groups, and rental furniture services, with delivery/assembly considerations |
| ⭐⭐ | 🟢 | `thailand-moving-services-2026` | How to arrange a move in Thailand — covering Bangkok-area movers, intercity moves (Bangkok to Chiang Mai), international shipping for expats leaving, DIY with hired truck, packing supplies, and realistic pricing ranges |
| ⭐⭐ | 🟢 | `thailand-hua-hin-expat-housing-2026` | Hua Hin as an expat housing choice in 2026 — covering who Hua Hin fits (older expats / retirees / part-time residents), beachfront vs inland trade-offs, rent vs buy economics, condo developments popular with foreigners, and Hua Hin vs Pattaya vs Phuket as retirement bases |
| ⭐⭐ | 🟢 | `thailand-pattaya-expat-housing-2026` | Pattaya as an expat housing choice in 2026 — covering North Pattaya / Jomtien / Naklua / Pratumnak, the reputation reality for long-term expats vs short-term tourists, rent ranges, and who Pattaya actually fits as a long-term base |
| ⭐⭐ | 🔴 | `thailand-rental-contract-guide-2026` | How to read and negotiate a rental contract in Thailand — covering standard clauses, deposit rules (1-month vs 2-month norms), utility terms, early termination, maintenance responsibilities, Thai-law landlord obligations, what to add/remove, and when to require English translation ⚠️ 深度车道,法律内容 |
| ⭐ | 🟢 | `thailand-island-rental-realities-2026` | Renting on Thailand's islands (Koh Samui / Koh Phangan / Koh Tao / Phuket islands) — covering seasonality pricing, who manages what during monsoon, internet/power reliability, water supply realities, long-term vs monthly deals, and when island rental saves vs costs more than expected |

---

### Visa 板块(普通车道可做的部分)

**注意**:Visa 板块绝大多数是 🔴 深度车道,但有 1-2 个入门科普是普通车道可以做的。

| 优先级 | 车道 | 建议 slug | 主题(复制即用) |
|---|---|---|---|
| ⭐⭐⭐ | 🟡 | `thailand-visa-exemption-2026` | How the Thailand visa exemption works in 2026 — covering the current 60-day rule (93 countries) and the proposed 30-day reduction, how it interacts with DTV and other visa options, re-entry and "stamp run" patterns, and strategies for staying long-term using exemption combinations ⚠️ 如果 30-day 提案落地,升级为深度 |

(其他 Visa 选题在 Phase 2 深度车道部分)

---

## Phase 2:深度车道板块(Phase 1 完成后)

### Visa 板块(深度)

**当前 0 篇 / 目标 8-10 篇(比 Vietnam 多,因为 DTV / LTR / 60-day 变化多)/ 还差 8-10 篇**

| 优先级 | 车道 | 建议 slug | 主题(复制即用) |
|---|---|---|---|
| ⭐⭐⭐ | 🔴 | `thailand-dtv-application-2026` | How to apply for Thailand's Destination Thailand Visa (DTV) in 2026 — covering all 4 qualifying categories (remote work / workcation / Thai soft power / medical treatment), documentation requirements, the 500,000 THB financial proof, embassy vs e-visa application paths, 2026 location-verification rules (IP/GPS flagging), and realistic timeline. ⚠️ 必须深度车道,YMYL |
| ⭐⭐⭐ | 🔴 | `thailand-dtv-vs-ltr-2026` | DTV vs LTR visa — which long-term Thailand visa fits which expat profile, covering 5-year DTV (income from abroad, no local employment) vs 10-year LTR (wealthy citizen / pensioner / work-from-Thailand / highly-skilled), qualification thresholds, tax treatment differences, and dependent eligibility |
| ⭐⭐⭐ | 🔴 | `thailand-retirement-visa-2026` | How to get a Thailand retirement visa (Non-O / O-A / O-X) as an expat in 2026 — covering the 50+ age requirement, 800,000 THB financial proof OR 65,000 THB monthly income, insurance mandate (O-A / O-X), 90-day reporting rules, and how retirement visa compares with LTR-Pensioner pathway |
| ⭐⭐⭐ | 🔴 | `thailand-tax-residency-expats-2026` | How tax residency works in Thailand as an expat in 2026 — covering the 180-day rule, the 2024 foreign-remittance taxation change (foreign income remitted to Thailand may be taxable), CRS implementation, common expat tax setups, and when to consult a Thai tax professional. ⭐ YMYL flagship,必须深度车道 |
| ⭐⭐⭐ | 🔴 | `thailand-60-day-exemption-changes-2026` | How the 60-day visa exemption change affects expats in 2026 — covering the March 2026 government proposal to reduce from 60 to 30 days, implementation timeline uncertainty, impact on visa runs and "exemption tourism", and contingency plans for nomads relying on exemption patterns ⚠️ 极高时效,可能 6 个月内失效 |
| ⭐⭐ | 🔴 | `thailand-visa-run-guide-2026` | How to do a visa run from Thailand — covering all options: Cambodia (Phnom Penh, Siem Reap, border crossings), Laos (Vientiane), Malaysia (Penang, KL), Vietnam (by flight), Myanmar (currently restricted), by flight vs land border, typical cost, timing considerations, and what documents to bring |
| ⭐⭐ | 🔴 | `thailand-education-visa-ed-2026` | How to get a Thailand Education (ED) visa in 2026 — covering legitimate Thai language schools, Muay Thai training school pathway, Buddhist study pathway, 90-day reporting requirements, ED visa's grey-area misuse for long-stay, and the 2024-2025 enforcement crackdown on diploma-mill schools |
| ⭐⭐ | 🔴 | `thailand-business-visa-work-permit-2026` | How to get a Thailand business visa (Non-B) and work permit in 2026 — covering employer-sponsored process, 4-Thais-per-foreigner rule, minimum capital requirements, required documents (education, experience proof), processing time, BOI-promoted company fast-track option, and how Non-B interacts with tax residency |

---

### Banking 板块(深度)

**当前 0 篇 / 目标 8-10 篇 / 还差 8-10 篇**

| 优先级 | 车道 | 建议 slug | 主题(复制即用) |
|---|---|---|---|
| ⭐⭐⭐ | 🔴 | `thailand-bank-account-expats-2026` | How to open a bank account in Thailand as a foreigner in 2026 — covering visa requirements for each bank (Bangkok Bank, SCB, Kasikorn, Krungthai, TMBThanachart), DTV holder easier-access rules from 2025, work permit vs non-work-permit differences, minimum deposit amounts, and which bank is realistic for non-Thai-speakers |
| ⭐⭐⭐ | 🔴 | `thailand-wise-setup-2026` | How to use Wise in Thailand as an expat — covering account setup, receiving money from abroad to THB, sending money home, multi-currency card usage for ATM and retail, fees vs local banks, PromptPay interaction, and common pitfalls ⭐ affiliate 旗舰页,SafetyWing 对应 Wise 的地位 |
| ⭐⭐⭐ | 🔴 | `thailand-promptpay-2026` | How PromptPay works in Thailand for expats — covering how to register (Thai phone / Thai ID / passport number), how to send/receive domestic transfers instantly, which Thai bank apps support PromptPay in English, QR code payments at merchants, and how PromptPay compares to TrueMoney / Rabbit LINE Pay |
| ⭐⭐⭐ | 🔴 | `thailand-currency-exchange-2026` | How to exchange currency in Thailand in 2026 — covering Super Rich (best retail rates), other downtown exchanges (Vasu, SuperChange), airport counters (worst rates), bank branches, Wise multi-currency receiving, and real-rate comparison with warnings about fake exchange shops |
| ⭐⭐⭐ | 🔴 | `thailand-remittance-foreign-income-tax-2026` | How to send foreign income into Thailand after the 2024 remittance-tax change — covering the January 2024 rule change, the "same year earned + remitted" ambiguity, CRS-driven visibility of foreign accounts, Wise vs SWIFT vs keeping funds abroad trade-offs, and when to structure money flow to minimize tax exposure ⚠️ YMYL flagship,必须深度 |
| ⭐⭐ | 🔴 | `thailand-atm-guide-2026` | How to use ATMs in Thailand as an expat — covering foreign card ATM fees (220 THB flat fee universal), withdrawal limits by bank, safer vs riskier ATM locations, using local bank ATMs, and strategies to minimize per-withdrawal cost |
| ⭐⭐ | 🔴 | `thailand-remittance-home-2026` | How to send money from Thailand back home in 2026 — covering all options: Wise, traditional bank wire, Western Union, DeeMoney, SWIFT via Thai banks, with speed/fee comparison, THB outbound regulations, and when to use which |
| ⭐⭐ | 🔴 | `thailand-credit-card-expat-2026` | Can an expat get a Thai credit card in 2026 — covering eligibility by visa type (work permit mandatory for most issuers, DTV grey area), income requirement thresholds, Bangkok Bank / SCB / Kasikorn / Citi Thailand options, and whether to bother vs using foreign cards + Wise |

---

### Healthcare 板块(深度)

**当前 0 篇 / 目标 8-10 篇(比 Vietnam 多,因为 Thailand 医疗旅游独立子赛道)/ 还差 8-10 篇**

| 优先级 | 车道 | 建议 slug | 主题(复制即用) |
|---|---|---|---|
| ⭐⭐⭐ | 🔴 | `thailand-healthcare-expats-2026` | How Thailand's healthcare system actually works for foreigners — covering public (government) hospitals, private hospitals (Bumrungrad / BNH / Samitivej / Bangkok Hospital), international clinics, real costs, insurance options, emergency system, and the quality-vs-price reality that makes Thailand a medical tourism destination |
| ⭐⭐⭐ | 🔴 | `thailand-health-insurance-expats-2026` | How to choose health insurance as an expat in Thailand in 2026 — covering local options (AIA, Bupa Thailand, Pacific Cross, Allianz Ayudhya), international expat insurance (Cigna, Allianz, Aetna), SafetyWing for short-term, visa-mandated insurance for O-A / O-X, comparison by age / length of stay / budget ⭐ affiliate 旗舰页 |
| ⭐⭐⭐ | 🔴 | `expat-hospitals-bangkok-2026` | Best hospitals for expats in Bangkok — covering Bumrungrad International, Bangkok Hospital, Samitivej, BNH, MedPark, Phyathai 2, Siriraj (public prestige), with specialties / strengths / English-speaking staff availability / price ranges / insurance acceptance / when to choose which ⚠️ 健康 YMYL |
| ⭐⭐⭐ | 🔴 | `expat-hospitals-chiang-mai-2026` | Best hospitals for expats in Chiang Mai — covering Chiang Mai Ram, Bangkok Hospital Chiang Mai, Lanna Hospital, Chiangmai Klaimor, Suan Dok (public university), with specialties, English availability, price ranges, insurance acceptance ⚠️ 健康 YMYL |
| ⭐⭐⭐ | 🔴 | `expat-hospitals-phuket-2026` | Best hospitals for expats in Phuket — covering Bangkok Hospital Phuket, Phuket International Hospital, Mission Hospital Phuket, Vachira Phuket (public), with specialties, English availability, price ranges, insurance acceptance, and emergency access in island areas ⚠️ 健康 YMYL |
| ⭐⭐ | 🔴 | `thailand-dental-care-expats-2026` | How to find dental care in Thailand as an expat in 2026 — covering expat-friendly clinics in major cities, Thailand as a dental tourism destination (comparative pricing for cleaning / filling / root canal / implants / veneers), quality reality, insurance acceptance, and what to expect vs home-country dental |
| ⭐⭐ | 🔴 | `thailand-pharmacy-medication-2026` | How to get medication in Thailand in 2026 — covering pharmacy chains (Fascino, Boots, Save Drug, Watsons with pharmacy), prescription vs OTC rules, bringing medication from abroad, controlled substance restrictions, common medication name translations, and what's freely available vs restricted |
| ⭐⭐ | 🔴 | `thailand-emergency-medical-2026` | What to do in a medical emergency in Thailand in 2026 — covering emergency numbers (1669 government / private hospital direct lines), ambulance services (public vs private vs hospital-direct), which hospitals handle what emergencies, evacuation insurance for severe cases, and how to manage if uninsured ⚠️ 安全 YMYL |
| ⭐ | 🔴 | `thailand-medical-tourism-guide-2026` | How to use Thailand as a medical tourism destination — covering the most common procedures foreigners travel for (dental, cosmetic surgery, elective orthopedic, cardiac screening, fertility), cost comparison vs US/UK/Australia/Singapore, insurance interactions, and logistics (visa / accommodation / follow-up) |

---

## 完整总量表

| 板块 | 当前 | 目标 | 缺口 | 车道分布 |
|---|---|---|---|---|
| Visa | 0 | 8-10 | 8-10 | 🟡 1 + 🔴 7-9 |
| Housing | 0 | 12-15 | 12-15 | 🟢 11 + 🔴 1 |
| Banking | 0 | 8-10 | 8-10 | 全 🔴 |
| Healthcare | 0 | 8-10 | 8-10 | 全 🔴 |
| Daily Life | 0 | 15-18 | 15-18 | 🟢 15 + 🟡 2 |
| Digital Nomad | 0 | 12-15 | 12-15 | 全 🟢 |
| **合计** | **0** | **63-78** | **63-78** | |

### 缺口车道拆分

- 🟢 普通车道: **约 38-40 篇**(SOP v2.52 可直接生产)
- 🔴 深度车道: **约 22-25 篇**(Deep SOP v1.0 + Claude QA)
- 🟡 边界话题: **约 3-4 篇**(按具体切角判断)

### 与 Vietnam Roadmap v2 的数量对比

| 板块 | Vietnam 目标 | Thailand 目标 | 差异说明 |
|---|---|---|---|
| Visa | 6-8 | 8-10 | Thailand 多(DTV/LTR 生态 + 60-day 变化) |
| Housing | 10-12 | 12-15 | Thailand 多(多核心 expat 城市) |
| Banking | 8-10 | 8-10 | 相近 |
| Healthcare | 6-8 | 8-10 | Thailand 多(医疗旅游独立赛道) |
| Daily Life | 15-18 | 15-18 | 相近 |
| Digital Nomad | 10-12 | 12-15 | Thailand 多(DTV 对 DN 更友好) |

Thailand 整体目标 63-78 篇,比 Vietnam 55-68 篇高约 15%,符合 Thailand expat 生态复杂度更高的现实。

---

## 生产建议节奏

### 第 1 阶段:普通车道冲刺(2-3 周)

**前置**:Vietnam 站饱和 + 30 天 GSC 流量稳定 + 泰国站点技术初始化(Cloudflare Pages 新项目 / 域名 / Astro Starlight fork Vietnam 站模板)

优先级:Digital Nomad (⭐⭐⭐ 6 篇) + Daily Life (⭐⭐⭐ 7 篇) + Housing (⭐⭐⭐ 5 篇)

**目标**:从 0 → 25-30 篇

这个阶段日产量 2-3 篇,SOP v2.52 全程可用。Digital Nomad 应优先产出,因为 DTV + 泰国 nomad 生态是 Thailand 相比 Vietnam 的最大差异化卖点。

### 第 2 阶段:深度车道突击(3-4 周)

优先级:Visa (⭐⭐⭐ 4 篇) + Banking (⭐⭐⭐ 5 篇) + Healthcare (⭐⭐⭐ 5 篇)

**目标**:从 25-30 → 45-50 篇,日产量 1 篇,质量优先。

重点旗舰页:
- `thailand-dtv-application-2026`
- `thailand-tax-residency-expats-2026`(财务 YMYL flagship)
- `thailand-wise-setup-2026`(affiliate 旗舰,对应 Vietnam 的 wise-in-vietnam-2026)
- `thailand-health-insurance-expats-2026`(affiliate 旗舰,对应 Vietnam 的同名页)
- 3 篇 expat-hospitals 三城 trilogy

**深度车道泰国独有重点**:
- `thailand-remittance-foreign-income-tax-2026`:2024 汇入税规则的深度解读,这类主题 Vietnam 没有对应,但是 Thailand expat 关心的头部问题之一
- `thailand-60-day-exemption-changes-2026`:极高时效题,Effective Date Sensitivity ≤ 6 个月

### 第 3 阶段:补完(2-3 周)

优先级:剩余 ⭐⭐ 应写 的文章,按板块平衡推进。

**目标**:从 45-50 → 60+ 篇

### 第 4 阶段:观察期(30 天)

停止冲产量,观察 GSC 流量趋势 + 针对性优化。

### 第 5 阶段:下一国家决策

Thailand 站 ≥ 60 篇 + GSC 30 天流量稳定后,启动下一国家候选(预估:印尼 Bali / 马来西亚 KL & Penang / 菲律宾)。

---

## 选题名称命名原则(继承 Vietnam)

**决策空间命名三原则**(未做调整,与 Vietnam Roadmap v2 完全一致):

1. **以"how to ..."或"which ... should"开头**,强调用户的决策问题
2. **在括号或附注里列出 Adjacent Options**,明确这个选题覆盖哪些竞争/互补选项
3. **不用单一服务商命名**,除非文章真的只讲那一家(例如 `thailand-wise-setup-2026` 合理,因为它就是 Wise 深度指南)

**反例 vs 正例**:

❌ "Bangkok Bank / 泰国银行账户"
✅ "How to open a bank account in Thailand (Bangkok Bank / SCB / Kasikorn / Krungthai / TMBThanachart)"

❌ "Bumrungrad / 曼谷医院"
✅ "Best hospitals for expats in Bangkok (Bumrungrad / Bangkok Hospital / Samitivej / BNH / MedPark / Phyathai / Siriraj)"

---

## 文档使用说明

1. **每写完一篇,在优先级栏前加 ✅**(或新建一个 progress log)
2. **ChatGPT 讨论选题时**,Step 2 场景 B 直接复制"主题(复制即用)"整句到 Goal 字段
3. **遇到判断不清的(🟡 边界)**,写前询问或先查 SOP 的选题分流硬规则
4. **定期对照 GSC 数据微调优先级**
5. **泰国站启动前,确认 Vietnam 站已满足启动阈值**(≥ 50 篇 + GSC 30 天稳定流量)

---

## 与 Vietnam Roadmap v2 共享的待办事项

- [ ] Thailand 站启动时,复用 Vietnam 站 Astro Starlight 技术模板
- [ ] Thailand 站启动时,`generate-link-index.sh` 脚本需要适配 Thailand 板块路径
- [ ] Thailand 站独立的 internal-articles-index.md(不与 Vietnam 共用)
- [ ] Thailand 首页 index.mdx(参考 Vietnam 首页 6 板块表格结构)
- [ ] Thailand 的 SafetyWing / Wise / World Nomads affiliate 链接 ID(可能需要针对 Thailand 市场申请新 partner 码)
- [ ] Thailand 合规:泰国金融广告监管可能与 Vietnam 不同,Deep SOP v1.0 的 affiliate_compliance_check 规则需要针对泰国细化

---

## Status (2026-04-22)

- Thailand 站启动 **尚未开始**
- 前置条件:Vietnam 站 30 篇 → 目标 50+ 篇(还差约 20 篇)
- 预估 Thailand 启动时间:**Vietnam 站完成后 6-8 周内**
- Thailand Phase 1 预估完成:启动后 2-3 周
- Thailand Phase 2 预估完成:启动后 5-7 周
- Thailand Phase 3 预估完成:启动后 7-10 周
- Thailand 观察期 + 下一国家决策:启动后约 11-14 周

---

## 待办提醒(给未来的自己)

- [ ] Vietnam 50+ 篇达成 + GSC 30 天稳定前,不启动 Thailand
- [ ] Thailand 启动前,先做一次 Vietnam 站热门文章的 GSC / AI 引用率回看,提炼"什么内容真的 work"作为 Thailand 选题微调依据
- [ ] 60-day exemption 提案(2026-03)如果落地成 30 天,`thailand-60-day-exemption-changes-2026` 优先级升为"必写 + 立刻"
- [ ] 2024 汇入税规则如果在 Thailand 启动时仍有新变化(2026 中期政策调整),`thailand-remittance-foreign-income-tax-2026` 同样优先
- [ ] Thailand 启动时,考虑是否需要 Thai 语言辅助(部分 Tier 1 来源是 .go.th 泰文,可能需要 Google Translate 辅助阅读)
