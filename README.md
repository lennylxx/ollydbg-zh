ollydbg-zh
==========
Simplified Chinese translation of OllyDbg 2.01

How to use
----------
1. Download the [release file](https://github.com/lennylxx/ollydbg-zh/releases). 
2. Put it into the root folder of the OllyDbg.
3. Select "File" -> "GUI language" -> "简体中文 (Simplified Chinese)"

> ⚠ Don't grab `ollydbg.lng` from the GitHub web UI's "Raw" / "Download" link — the blob is stored as UTF-8 and OllyDbg expects UTF-16 LE. The release artifact is the correct UTF-16 LE file; `git clone` also produces the correct format via `.gitattributes`.

Contributing
------------
Clone this repo. Git will automatically check out `ollydbg.lng` as UTF-16 LE with BOM and CRLF (required by OllyDbg) via the `working-tree-encoding` attribute. Requires git 2.10 or newer.

```
git clone https://github.com/lennylxx/ollydbg-zh
```
