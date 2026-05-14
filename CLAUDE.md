# OllyDbg Simplified Chinese localization

Single-file project: `ollydbg.lng` is OllyDbg's language file. Each entry is a 4-line block:

```
// SECTION:LINE
EN <english text>
ZH <translation>

```

`SECTION:LINE` is the source location in OllyDbg's C code that emits the string — treat it as an opaque key. A `ZH` line containing `Chicken`/`Chic`/`CHI`/`CH`/`Chi-chic` etc. is an untranslated stub; the original author left placeholders so the file structure parses.

## File encoding

- Working tree: UTF-16 LE, BOM, CRLF line endings — OllyDbg requires this exactly
- Repo blob: UTF-8, no BOM, LF (canonical git text form)
- Conversion handled natively by git via `.gitattributes`:
  ```
  *.lng text eol=crlf working-tree-encoding=UTF-16LE-BOM
  ```
  **Attribute order matters** — `eol=crlf` must come before `working-tree-encoding` or CRLF normalization gets silently skipped (observed on git 2.43, Linux). Verified working with `cmp` after a fresh clone round-trip.
- Requires git ≥ 2.10. Fresh clones get the correct working tree with no bootstrap script.
- When writing the file from a build script, emit UTF-16 LE + BOM + CRLF directly; git normalizes to UTF-8/LF on stage.
- Caveat for end users (already in `README.md`): GitHub's raw web download serves the UTF-8 blob and won't work for OllyDbg — use the releases page or `git clone`.

## Translation style

Follow **Microsoft Simplified Chinese Style Guide** for terminology and tone, with **one deliberate deviation: selective halfwidth ASCII punctuation** for labels, tooltips, and short messages (see Punctuation section).

### Pre-flight per entry / per section
1. `grep` the file for related EN strings — many terms appear in multiple entries (menu labels, error messages, tooltips). Translate consistently.
2. For UI feature names (windows/views/menu items), check that menu / tooltip / error-message strings all use the same Chinese label.
3. Before inventing a new term, scan the 437 existing translations and the terminology table below.

### Punctuation

Tested 2026-05-14 in OllyDbg's Shortcut editor: fullwidth glyphs look bloated/awkward in OllyDbg's bitmap fonts. Use halfwidth for short strings, fullwidth only for multi-sentence prose where the visual rhythm of `，。` actually helps readability.

**Halfwidth (default — use for labels, tooltips, single-sentence messages, parentheticals):**
- `,` `.` `!` `?` `:` `;` followed by halfwidth space
- `()` parens regardless of whether content is Chinese, English, or code
- Trailing `...` ellipsis preserved as-is
- Examples:
  - `主菜单: 文件`
  - `内存不足!`
  - `缺少 SYMSRV.DLL, Microsoft 符号服务器已停用`
  - `运行被调试的程序 (所有线程)`
  - `插件 '%s' (文件 '%s') 初始化失败`

**Fullwidth (only when source has 2+ sentence-ending marks `. ! ?` — multi-sentence dialog body text):**
- `，。！？：；（）` for sentence punctuation
- No space between Chinese characters and fullwidth punctuation (fullwidth glyphs include their own spacing)
- Examples:
  - `无法获取 .NET 调试接口 ICorDebugProcess2。这实际上使调试无法进行。例如，任何断点（包括临时断点）都可能导致死锁。`
  - `跳转表内存不足。跳转路径和调用树中将遗漏部分调用和跳转。`

**Decision heuristic:** if it's one short string that fits in a status bar, label, tooltip, or dialog item — halfwidth. If it's multiple sentences in a dialog body — fullwidth.

### Format specifiers and inline code
- Preserve `%s`, `%i`, `%02X`, `%08X`, `%.200S` etc. verbatim in original position
- Add halfwidth space around them when surrounded by Chinese characters: `结构 %s 位于`, not `结构%s位于`
- Same for inline English/identifiers: `.NET 调试接口 ICorDebugProcess2`

### Pronouns
- Second-person in prompts: `您` ("You may continue" → `您可以继续`)
- Greetings: `你好`, never `您好`
- Drop personified "I" / "we" — render subjectless (`but I recommend` → `但建议`)

### Keyboard accelerators
- Pattern: `中文文本(&X)` — Chinese label, halfwidth parens, uppercase letter
- Trailing `...` goes after the accelerator: `添加监视(&A)...`
- Preserve the original English letter when possible (so muscle memory carries over)

### Terminology — keep English
Acronyms, protocol/format names, and short technical identifiers users learn as-is:
`DLL`, `INT3`, `SEH`, `VEH`, `EIP`, `EAX`/`EBX`/etc., `FPU`, `GUID`, `TLS`, `.NET`, `Run` trace, `Hit` trace, `OMF`, `COFF`, `IMAGE_*` (PE struct names), `ICorDebug*`, `DBGHELP.DLL`.

### Terminology — translate
Descriptive feature/view/window names and verbs:
| EN | ZH | Notes |
|---|---|---|
| command (= x86 instruction) | 指令 | OllyDbg's terminology; covers "Command help", "Invalid command", etc. |
| command (= user/menu action) | 命令 | Only when clearly menu/shell context |
| jump table | 跳转表 | Not 跳跃表 (= "skip list", different concept) |
| jump path | 跳转路径 | |
| call tree | 调用树 | |
| call stack | 调用堆栈 | |
| disassembler | 反汇编器 | |
| handle | 句柄 | |
| breakpoint | 断点 | |
| trace | 跟踪 | |
| procedure | 过程 | Distinct from "function" in OllyDbg's analyzer |
| exception handler | 异常处理程序 | |
| native debugging | 原生调试 | |
| symbol server | 符号服务器 | |
| speech interface | 语音接口 | |

### Generic dispatcher "item"
OllyDbg uses "item" as its F1-context-help dispatcher term (= "whatever is under the cursor"). Render `Help on item` → `当前项帮助`. For explicit "selected item" variants use `所选项` (`No help on selected item` → `所选项无可用帮助`).

## Workflow

- Translate **section by section**, smallest first
- Show all `EN/ZH` pairs in chat for review before writing
- Apply approved batches via a builder script (typically `/tmp/build_lng.py`, session-local; rewrite per session if `/tmp` is wiped) — script reads UTF-8 source, applies a `{key → translation}` dict, writes UTF-16 LE + BOM + CRLF to `ollydbg.lng`
- Audit existing "translated" entries for stub placeholders before reusing terminology — the simple `chicken` substring filter misses short stubs like `Chic`, `CHI`, `CH`, `Chi-chic`

## Commits

- No `Co-Authored-By` or AI-attribution trailers
- Match existing repo style: lowercase, short subject line (e.g. `add translation for menus`)
- One commit per section or per logical batch is fine — granularity helps blame and review
