# ExpatGuide Deep Lane 3-Window Operation Manual v1

## Purpose

This manual is for the operator, not for GPT project knowledge. Use it as the step-by-step runbook when a topic has already been routed into the deep lane.

Core rule: writing, risk QA, and patch verification must be split across separate ChatGPT projects and separate chats.

---

## Which articles use this manual

Use this manual when the topic belongs to the deep lane:
- visa
- residency / TRC
- tax
- insurance
- healthcare
- banking
- legality / compliance
- other high-consequence, high-timeliness, or high-dispute topics

Do not use this manual for normal-lane articles.

---

## Required projects before starting

You need these three working projects ready:

1. **ExpatGuide Deep Draft**
2. **ExpatGuide Deep Risk QA**
3. **ExpatGuide Deep Patch Verify**

Each article should use **three separate chats**:
- Chat A: `[Country] [Topic] — Deep Draft`
- Chat B: `[Country] [Topic] — Risk QA`
- Chat C: `[Country] [Topic] — Patch Verify`

Never reuse the same chat for all three roles.

---

## Inputs you need at hand

Before starting, make sure you have:
- latest `internal-articles-index.md`
- latest deep-lane SOP / prompt source
- a confirmed topic
- the current article scope and target country

---

## Full workflow

### Step 1 — Open Chat A in **ExpatGuide Deep Draft**

Use Chat A only for drafting work.

Target output sequence:
1. TOPIC SHEET
2. RESEARCH PACK
3. VALIDATION PACK
4. DRAFT PACKAGE
5. DEEP CLAIM SHEET

### Step 2 — Generate the TOPIC SHEET

In Chat A, run the deep-lane topic setup prompt.

Check manually:
- topic is truly deep-lane
- scope is correct
- official-vs-practical need is correctly identified
- no scope lock problem

If the topic is actually normal-lane, stop and move it out.

### Step 3 — Generate the RESEARCH PACK

Still in Chat A.

Check manually:
- key claims are specific
- source types are clear
- effective-date sensitivity is surfaced
- eligibility / scope issues are visible
- internal links use only real slugs from the latest index

### Step 4 — Generate the VALIDATION PACK

Still in Chat A.

Check manually:
- gray-area claims exist when they should
- yellow / red are strict enough
- official rule vs actual execution is not flattened

If validation is too soft, make Chat A redo validation before moving on.

### Step 5 — Generate the DRAFT PACKAGE

Still in Chat A.

Use the deep-draft prompt.

Output should include:
- title
- meta title
- meta description
- suggested slug
- frontmatter block
- full article
- internal links used
- self-audit

### Step 6 — Generate the DEEP CLAIM SHEET

Still in Chat A.

Immediately after the draft, ask for a **DEEP CLAIM SHEET**.

It must list only the high-risk claims, including:
- sentence quote
- claim type: official / practical / gray-area
- source basis
- effective-date relevance
- eligibility / scope sensitivity
- volatility
- safe wording status

Minimum coverage:
- regulation conclusions
- effective dates
- eligibility thresholds
- fees / penalties / wait times
- official-vs-practical judgment sentences
- gray-area judgment sentences
- any line that materially changes reader decisions

### Step 7 — Open Chat B in **ExpatGuide Deep Risk QA**

Use Chat B only for risk QA.

Paste into Chat B:
- TOPIC SHEET
- RESEARCH PACK
- VALIDATION PACK
- DEEP CLAIM SHEET
- DRAFT ARTICLE only

Do **not** paste the whole drafting conversation.

Run the Risk QA prompt.

Expected output:
- `GPT QA ISSUE LIST`

Check manually:
- issue count is controlled (target 8–12 max)
- issues are material, not cosmetic
- no full rewrites
- no new unsupported facts

If Chat B starts rewriting style or over-editing, stop and rerun with stricter instruction.

### Step 8 — Return to Chat A and patch

Paste the `GPT QA ISSUE LIST` into Chat A.

Run the patch prompt.

Expected output:
- `PATCHED ARTICLE`
- `Patch Changelog`
- `Patched Article`

Patch rules:
- minimum necessary edits only
- no unsupported new facts
- no broad rewriting
- no scope expansion
- each issue must map to a concrete patch entry

### Step 9 — Open Chat C in **ExpatGuide Deep Patch Verify**

Use Chat C only for patch verification.

Paste into Chat C:
- original `GPT QA ISSUE LIST`
- patch changelog
- patched article

Run the Patch Verification prompt.

Expected output:
- `PATCH VERIFICATION LIST`

Desired result:
- `all material issues fixed`

If Chat C returns:
- `partially fixed`
- `not fixed`
- `new issue`

then go back to Chat A and do one more minimum patch.

### Step 10 — Final local save and script checks

After Chat C passes:
1. save the article locally
2. run local checks
3. run preview
4. publish
5. refresh the internal index
6. re-upload the latest index to all article-production projects

---

## Hard operating rules

### Rule 1 — No role mixing
- Chat A drafts and patches
- Chat B finds issues
- Chat C verifies patch results
- never collapse these into one chat

### Rule 2 — No full SOP dump into QA chats
Risk QA and Patch Verify should not ingest the entire master SOP every time.
Use mini-spec rules only.

### Rule 3 — No full-article rewrite in QA
Risk QA should output issue lists, not replacement articles.

### Rule 4 — No patch drift
Patch only what the issue list requires.
If the changelog cannot map fix-to-issue cleanly, the patch was too wide.

### Rule 5 — Factual robustness stays first
This is still deep lane.
Do not trade away legal conditions, eligibility limits, or timing caveats for smoother writing.

---

## Pass / fail standard

The article can move to local publish workflow only if all are true:
- issue list is material and bounded
- patch changelog maps cleanly to issues
- patch verification says all material issues fixed
- official vs practical distinction remains visible
- gray-area claims are not flattened
- no invented slugs
- no banned wording problems
- no unsupported new facts introduced during patching

---

## Recommended naming convention

For each deep article:
- Chat A: `Vietnam TRC Guide — Deep Draft`
- Chat B: `Vietnam TRC Guide — Risk QA`
- Chat C: `Vietnam TRC Guide — Patch Verify`

Keep all three chats for auditability until the article is live.
