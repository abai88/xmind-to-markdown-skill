---
name: xmind-to-markdown
description: Convert one or many local XMind `.xmind` mind maps to UTF-8 Markdown files. Use when the user asks to export XMind maps, batch-convert a folder of XMind files, archive mind maps as Markdown, or preserve XMind directory structure in Markdown output.
---

# XMind to Markdown

Use this skill to convert local XMind files to Markdown. The default converter is `D:\工具\xmind2md\xmind2md.py` (jellzone/xmind2md), supporting XMind 2020/Zen and XMind 8.

## Workflow

1. Confirm the input exists, count `.xmind` files, and check whether output files already exist. Do not overwrite files without explicit permission.
2. Confirm the converter exists. If absent, request permission before cloning `https://github.com/jellzone/xmind2md.git` to `D:\工具\xmind2md`.
3. Run `scripts/convert_xmind.ps1`. Folder conversion is recursive and preserves relative paths below the output folder.
4. Report converted, skipped, and failed counts; read at least one generated file as UTF-8 to verify Chinese text.

## Usage

Single file:

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File "<skill-dir>\scripts\convert_xmind.ps1" -SourcePath "E:\mindmaps\plan.xmind" -OutputPath "E:\archive\plan.md"
```

Folder:

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File "<skill-dir>\scripts\convert_xmind.ps1" -SourcePath "E:\mindmaps" -OutputPath "E:\archive"
```

Append `-AllowOverwrite` only when the user explicitly asks to replace existing Markdown files.

## Resource

- `scripts/convert_xmind.ps1`: Converts one XMind file or a folder safely and emits a conversion summary.
