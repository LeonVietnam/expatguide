#!/usr/bin/env python3
"""
ExpatGuide 批量更新脚本 v2

作用:
1. 为 16 篇文章添加 sidebar.label (如果已存在则跳过)
2. 删除所有 frontmatter 中手动写的 lastUpdated 字段
3. 保持 title / description / 其他字段不变

用法:
    cd ~/expatguide
    python3 apply-sidebar-labels.py

然后检查 git diff 确认改动符合预期,再 commit。
"""

import os
import re
from pathlib import Path

# ============================================================
# 配置区: 16 篇文章的 sidebar.label 映射
# 每个键是 slug 的"基础形式",脚本会尝试不同变体
# ============================================================

SIDEBAR_LABELS = {
    # Visa
    "vietnam/visa/visa-guide-2026": "Visa Options",
    "vietnam/visa/trc-application-guide-2026": "TRC Application",

    # Housing
    "vietnam/housing/avoid-rental-scams-vietnam-2026": "Rental Scams & Safety",
    "vietnam/housing/best-neighborhoods-hanoi-expats-2026": "Hanoi: Where to Live",
    "vietnam/housing/best-neighborhoods-hcmc-expats-2026": "Saigon: Where to Live",
    "vietnam/housing/best-neighborhoods-danang-expats-2026": "Da Nang: Where to Live",

    # Banking
    "vietnam/banking/bank-account-guide-2026": "Open a Bank Account",
    "vietnam/banking/international-cards-guide-2026": "Foreign Cards: Where They Work",

    # Healthcare
    "vietnam/healthcare/healthcare-vietnam-expats-2026": "Healthcare System",

    # Daily Life
    "vietnam/daily-life/cost-of-living-vietnam-2026": "Cost of Living: Vietnam",
    "vietnam/daily-life/cost-of-living-hoi-an-2026": "Cost of Living: Hoi An",
    "vietnam/daily-life/motorbike-guide-2026": "Motorbike Driving",
    "vietnam/daily-life/vietnam-drivers-license-2026": "Driver's License Conversion",
    "vietnam/daily-life/vietnam-essential-apps-2026": "Essential Apps",
    "vietnam/daily-life/vietnam-sim-card-guide-2026": "SIM Card & eSIM",

    # Digital Nomad
    "vietnam/digital-nomad/da-nang-vs-hanoi-vs-saigon-digital-nomad-guide-2026": "3-City Remote Work Comparison",
}

# 特殊处理: electricity 文章有多种可能的 slug,脚本会自动匹配
# 如果找到这些 slug 中的任何一个,都用 "Electricity Bills" 作为 label
ELECTRICITY_SLUG_CANDIDATES = [
    "vietnam/housing/electricity-bill-renter-2026",
    "vietnam/housing/electricity-bills-renters-2026",
    "vietnam/housing/electricity-bill-renters-2026",
    "vietnam/housing/electricity-bills-renter-2026",
]
ELECTRICITY_LABEL = "Electricity Bills"

DOCS_DIR = Path("src/content/docs")

# 统计
stats = {
    "updated_sidebar": 0,
    "skipped_sidebar_existed": 0,
    "removed_lastupdated": 0,
    "files_changed": 0,
    "files_not_found": [],
    "files_without_slug_match": [],
}


def process_file(file_path, slug, desired_label):
    """处理单个文件: 加 sidebar.label + 删 lastUpdated"""
    if not file_path.exists():
        stats["files_not_found"].append(str(file_path))
        return False

    content = file_path.read_text(encoding="utf-8")
    original = content

    if not content.startswith("---\n"):
        print(f"  ⚠️  {file_path}: 无 frontmatter, 跳过")
        return False

    parts = content.split("---\n", 2)
    if len(parts) < 3:
        print(f"  ⚠️  {file_path}: frontmatter 格式异常, 跳过")
        return False

    frontmatter = parts[1]
    body = parts[2]

    # --- 操作 1: 删除 lastUpdated 字段 ---
    new_frontmatter = re.sub(r'^lastUpdated:.*\n', '', frontmatter, flags=re.MULTILINE)
    if new_frontmatter != frontmatter:
        stats["removed_lastupdated"] += 1
        frontmatter = new_frontmatter

    # --- 操作 2: 添加 sidebar.label (如果不存在) ---
    if re.search(r'^sidebar:', frontmatter, flags=re.MULTILINE):
        if re.search(r'^\s+label:', frontmatter, flags=re.MULTILINE):
            stats["skipped_sidebar_existed"] += 1
            print(f"  ⏭  {slug}: 已有 sidebar.label, 跳过")
        else:
            frontmatter = re.sub(
                r'^sidebar:\s*\n',
                f'sidebar:\n  label: "{desired_label}"\n',
                frontmatter,
                count=1,
                flags=re.MULTILINE
            )
            stats["updated_sidebar"] += 1
            print(f"  ✓ {slug}: 加 label (已有 sidebar 块)")
    else:
        if not frontmatter.endswith("\n"):
            frontmatter += "\n"
        frontmatter += f'sidebar:\n  label: "{desired_label}"\n'
        stats["updated_sidebar"] += 1
        print(f"  ✓ {slug}: 加 sidebar.label → \"{desired_label}\"")

    new_content = f"---\n{frontmatter}---\n{body}"

    if new_content != original:
        file_path.write_text(new_content, encoding="utf-8")
        stats["files_changed"] += 1
        return True

    return False


def try_process(slug, desired_label):
    """尝试处理 slug (自动尝试 .md 和 .mdx 两种扩展名)"""
    file_md = DOCS_DIR / f"{slug}.md"
    file_mdx = DOCS_DIR / f"{slug}.mdx"

    if file_md.exists():
        return process_file(file_md, slug, desired_label)
    elif file_mdx.exists():
        return process_file(file_mdx, slug, desired_label)
    else:
        return None  # 文件不存在


def main():
    print("=" * 70)
    print("ExpatGuide 批量更新 v2: sidebar.label + lastUpdated 清理")
    print("=" * 70)
    print()

    if not DOCS_DIR.exists():
        print(f"❌ 错误: 找不到 {DOCS_DIR}. 请在项目根目录运行此脚本.")
        return

    total_targets = len(SIDEBAR_LABELS) + 1  # +1 for electricity
    print(f"计划更新 {total_targets} 篇文章")
    print()

    # 处理标准 16 篇
    for slug, desired_label in SIDEBAR_LABELS.items():
        result = try_process(slug, desired_label)
        if result is None:
            stats["files_not_found"].append(slug)
            print(f"  ✗ {slug}: 文件不存在")

    # 处理 electricity (尝试多种 slug)
    print()
    print("处理 electricity 文章 (尝试多种 slug 变体)...")
    electricity_found = False
    for candidate in ELECTRICITY_SLUG_CANDIDATES:
        result = try_process(candidate, ELECTRICITY_LABEL)
        if result is not None:
            electricity_found = True
            break
    if not electricity_found:
        stats["files_not_found"].append(f"electricity-bills (tried: {', '.join(ELECTRICITY_SLUG_CANDIDATES)})")
        print(f"  ✗ electricity 文章: 未找到 (已尝试 {len(ELECTRICITY_SLUG_CANDIDATES)} 种 slug)")

    # --- 额外扫描: 清理不在清单中的文件的 lastUpdated ---
    print()
    print("扫描其他文件的 lastUpdated 字段...")
    all_md_files = list(DOCS_DIR.rglob("*.md")) + list(DOCS_DIR.rglob("*.mdx"))

    processed_slugs = set(SIDEBAR_LABELS.keys()) | set(ELECTRICITY_SLUG_CANDIDATES)

    for f in all_md_files:
        rel_path = str(f.relative_to(DOCS_DIR)).replace(".md", "").replace(".mdx", "")
        if rel_path in processed_slugs:
            continue

        content = f.read_text(encoding="utf-8")
        if "lastUpdated:" in content:
            new_content = re.sub(r'^lastUpdated:.*\n', '', content, flags=re.MULTILINE)
            if new_content != content:
                f.write_text(new_content, encoding="utf-8")
                stats["removed_lastupdated"] += 1
                stats["files_changed"] += 1
                print(f"  ✓ {rel_path}: 删除 lastUpdated")

    # --- 总结 ---
    print()
    print("=" * 70)
    print("总结")
    print("=" * 70)
    print(f"  文件总数修改:        {stats['files_changed']}")
    print(f"  sidebar.label 新增:  {stats['updated_sidebar']}")
    print(f"  sidebar.label 跳过:  {stats['skipped_sidebar_existed']} (已存在)")
    print(f"  lastUpdated 删除:    {stats['removed_lastupdated']}")

    if stats["files_not_found"]:
        print()
        print("⚠️  以下文件未找到:")
        for f in stats["files_not_found"]:
            print(f"    - {f}")

    print()
    print("下一步:")
    print("  1. 检查改动: git diff --stat")
    print("  2. 详看改动: git diff src/content/docs/vietnam/visa/visa-guide-2026.md")
    print("  3. 打开 astro.config.mjs, 在 starlight({ title: ... }) 下加一行:")
    print("       lastUpdated: true,")
    print("  4. 本地预览: npm run dev")
    print("  5. 确认无误后 commit + push")
    print()


if __name__ == "__main__":
    main()
