---
name: xmind-to-markdown
description: Convert one or many local XMind `.xmind` mind maps to UTF-8 Markdown files. Use when the user asks to export XMind maps, batch-convert a folder of XMind files, archive mind maps as Markdown, or preserve XMind directory structure in Markdown output.
---

# XMind 转 Markdown

使用本 skill 将本机 XMind 文件转换为 Markdown。默认转换器为
`D:\工具\xmind2md\xmind2md.py`（jellzone/xmind2md），支持 XMind 2020/Zen 和 XMind 8。

## 功能概述

- 将单个 `.xmind` 文件或整个文件夹递归转换为 UTF-8 Markdown。
- 保留脑图层级，并尽可能导出备注、标签、标记和超链接。
- 批量转换时保留原有子目录结构，避免同名文件相互覆盖。
- 默认跳过已有目标文件；只有用户明确要求时才使用 `-AllowOverwrite` 覆盖。

## 工作流

1. 确认输入路径存在，统计 `.xmind` 文件并检查输出位置是否已有同名 Markdown。不要在未获明确许可时覆盖已有文件。
2. 确认转换器位于默认路径。若缺失，先请求授权，再克隆 `https://github.com/jellzone/xmind2md.git` 到 `D:\工具\xmind2md`。
3. 运行 `scripts/convert_xmind.ps1`。文件夹转换会递归处理所有 `.xmind`，并在输出目录中保留相对路径，避免重名覆盖。
4. 报告转换成功、跳过和失败的数量；抽查至少一个生成文件，确认以 UTF-8 读取时中文正常。

## 执行示例

单文件：

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File "<skill目录>\scripts\convert_xmind.ps1" `
  -SourcePath "E:\脑图\周计划.xmind" `
  -OutputPath "E:\归档\周计划.md"
```

批量转换：

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File "<skill目录>\scripts\convert_xmind.ps1" `
  -SourcePath "E:\桌面\周计划\归档" `
  -OutputPath "E:\归档"
```

只有用户明确要求替换已有 Markdown 时，附加 `-AllowOverwrite`。

## 资源

- `scripts/convert_xmind.ps1`：安全地转换单个文件或整个目录，并输出转换摘要。
