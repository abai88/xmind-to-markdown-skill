# XMind to Markdown Skill

一个自包含的 Codex skill，用于将 XMind 脑图转换为层级清晰、UTF-8 编码的 Markdown。

## 支持范围

- XMind 2020 / Zen（`content.json`）
- XMind 8（`content.xml`）
- 单个 `.xmind` 文件或整个文件夹的递归批量转换
- 备注、标签、标记与超链接的尽可能保留
- 批量时保留原有子目录，默认跳过已有 Markdown，避免覆盖

## 使用方式

在 Codex 中直接提出请求，例如：

> 将 `E:\脑图` 中的所有 XMind 文件转换为 Markdown，保存到 `E:\归档`。

skill 会调用内置的 `scripts/xmind2md.py`，无需依赖 `D:\工具` 中的外部副本。

## 安装

将本仓库的 `xmind-to-markdown` skill 文件夹放入 Codex skills 目录（通常是 `~/.codex/skills/`），重启 Codex 后即可使用。

## 许可证与致谢

内置转换器源自 [jellzone/xmind2md](https://github.com/jellzone/xmind2md)，按其 MIT 许可分发。
