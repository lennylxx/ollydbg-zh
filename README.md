ollydbg-zh
==========
OllyDbg 2.01 简体中文版

翻译进度
--------
**已翻译 4030 / 4106 行（98.1%）**。其余 76 行保留原文（缩略词、按键标签、格式说明符、Win32 结构字段名与品牌名）。

使用方法
--------
1. 从 [Releases](https://github.com/lennylxx/ollydbg-zh/releases) 下载语言文件。
2. 放入 OllyDbg 安装目录。
3. 在 OllyDbg 中依次选择 "File" → "GUI language" → "简体中文 (Simplified Chinese)"。

⚠️ **注意**：不要直接从 GitHub 网页点击 "Raw" 或 "Download" 下载 `ollydbg.lng`。仓库里存放的是 UTF-8 格式的 blob，而 OllyDbg 只识别 UTF-16 LE。请使用 Releases 提供的成品文件，或通过 `git clone` 获取（仓库的 `.gitattributes` 会自动转换为正确格式）。

参与贡献
--------
克隆本仓库即可。git 会通过 `working-tree-encoding` 属性自动把 `ollydbg.lng` 检出为 UTF-16 LE 格式（带 BOM 与 CRLF，正是 OllyDbg 所要求的格式）。需要 git 2.10 或更高版本。

```
git clone https://github.com/lennylxx/ollydbg-zh
```
