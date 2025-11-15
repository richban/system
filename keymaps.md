# Neovim Key Mappings Reference

## Git Operations (GitSigns)

| Key | Mode | Description |
|-----|------|-------------|
| `<Space>hb` | n | Git blame current line |
| `<Space>hd` | n | Diff this file |
| `<Space>hD` | n | Diff file (detailed) |
| `<Space>hp` | n | Preview hunk |
| `<Space>hr` | n/v | Reset hunk |
| `<Space>hR` | n | Reset buffer |
| `<Space>hs` | n/v | Stage hunk |
| `<Space>hS` | n | Stage buffer |
| `<Space>hu` | n | Undo stage hunk |
| `<Space>tb` | n | Toggle current line blame |
| `<Space>td` | n | Toggle deleted |
| `]h` | n | Next hunk |
| `[h` | n | Previous hunk |
| `ih` | x/o | Select hunk (text object) |

## Git Workflow (Fugitive & Neogit)

| Key | Mode | Description |
|-----|------|-------------|
| `<Space>gb` | n | Git blame |
| `<Space>gd` | n | Git diff split |
| `<Space>gh` | n | Git log (0Gclog!) |
| `<Space>gj` | n | Get diff from left (//2) |
| `<Space>gk` | n | Get diff from right (//3) |
| `<Space>gs` | n | Neogit status |
| `<Space>v` | n | Diffview |

## AI Assistants

### Avante
| Key | Mode | Description |
|-----|------|-------------|
| `<Space>aa` | n/v | Ask Avante |
| `<Space>aB` | n | Add all open buffers |
| `<Space>ad` | n | Toggle debug |
| `<Space>ae` | v | Edit with Avante |
| `<Space>af` | n | Focus Avante |
| `<Space>ah` | n | Select history |
| `<Space>an` | n/v | Create new ask |
| `<Space>ar` | n | Refresh |
| `<Space>aR` | n | Display repo map |
| `<Space>as` | n | Toggle suggestion |
| `<Space>aS` | n | Stop |
| `<Space>at` | n | Toggle |
| `<Space>a?` | n | Select model |

### CodeBridge (Claude Integration)
| Key | Mode | Description |
|-----|------|-------------|
| `<Space>cc` | n | General chat without context |
| `<Space>cq` | n | Interactive query with context |
| `<Space>ct` | n/v | Send context/selection to Claude via tmux |

### Windsurf AI
| Key | Mode | Description |
|-----|------|-------------|
| `<C-G>` | i | Windsurf trigger |
| `<C-;>` | i | Windsurf action 1 |
| `<C-,>` | i | Windsurf action 2 |
| `<C-X>` | i | Windsurf action 3 |

### Codeium
| Key | Mode | Description |
|-----|------|-------------|
| `<C-K>` | i | Accept next word |
| `<C-L>` | i | Accept next line |
| `<C-]>` | i | Clear suggestions |
| `<M-[>` | i | Previous suggestion |
| `<M-]>` | i | Next suggestion |
| `<M-Bslash>` | i | Complete |

## LSP (Language Server Protocol)

### Navigation
| Key | Mode | Description |
|-----|------|-------------|
| `gd` | n | Go to definition |
| `gD` | n | Go to declaration |
| `gi` | n | Go to implementation |
| `grr` | n | Find references |
| `gri` | n | Go to implementation |
| `grt` | n | Go to type definition |
| `gO` | n | Document symbols |
| `K` | n | Hover documentation |
| `gK` | n | Signature help |

### Code Actions
| Key | Mode | Description |
|-----|------|-------------|
| `gra` | n/v | Code actions |
| `grn` | n | Rename symbol |
| `<Space>ca` | n/v | Code actions (alternative) |

### Diagnostics
| Key | Mode | Description |
|-----|------|-------------|
| `[d` | n | Previous diagnostic |
| `]d` | n | Next diagnostic |
| `[D` | n | First diagnostic |
| `]D` | n | Last diagnostic |
| `[e` | n | Previous error |
| `]e` | n | Next error |
| `[w` | n | Previous warning |
| `]w` | n | Next warning |
| `<C-W>d` | n | Show diagnostics |

### Workspace
| Key | Mode | Description |
|-----|------|-------------|
| `<Space>wa` | n | Add workspace folder |
| `<Space>wr` | n | Remove workspace folder |
| `<Space>wl` | n | List workspace folders |
| `<Space>ws` | n | Workspace symbols |
| `<Space>ds` | n | Document symbols |

## Telescope (Fuzzy Finder)

### Search
| Key | Mode | Description |
|-----|------|-------------|
| `<Space><Space>` | n | Frecency |
| `<Space>/` | n | Search in current buffer |
| `<Space>s/` | n | Search in open files |
| `<Space>f/` | n | Grep last search |
| `<Space>sf` | n | Find files |
| `<Space>sg` | n | Live grep |
| `<Space>sw` | n | Grep current word |
| `<Space>sb` | n | Git branches |
| `<Space>sc` | n | Git commits |
| `<Space>sd` | n | Diagnostics |
| `<Space>sh` | n | Help tags |
| `<Space>sk` | n | Keymaps |
| `<Space>ss` | n | Select Telescope |
| `<Space>s.` | n | Recent files |
| `<Space>so` | n | Vim options |

### Advanced Search
| Key | Mode | Description |
|-----|------|-------------|
| `<Space>/c` | n | Commands |
| `<Space>/m` | n | Marks |
| `<Space>/r` | n | Registers |
| `<Space>/t` | n | Treesitter |
| `<Space>fB` | n | Builtin pickers |
| `<C-P>` | n | Git files |

## Completion (nvim-cmp)

| Key | Mode | Description |
|-----|------|-------------|
| `<C-N>` | i | Next completion |
| `<C-P>` | i | Previous completion |
| `<C-Y>` | i | Confirm completion |
| `<C-E>` | i | Abort completion |
| `<C-Space>` | i | Trigger completion |
| `<C-D>` | i | Scroll docs down |
| `<C-F>` | i | Scroll docs up |
| `<Tab>` | i/s | Accept completion |
| `<S-Tab>` | i/s | Previous completion |
| `<CR>` | i | Confirm completion |
| `<leader>tg` | i/n | **Toggle ghost text** |

## File Management

### File Explorer
| Key | Mode | Description |
|-----|------|-------------|
| `<Space>b` | n | Toggle NvimTree |
| `<Space>br` | n | Refresh NvimTree |
| `<Space>-` | n | Oil (parent directory) |
| `-` | n | Oil (parent directory) |

### Project Management
| Key | Mode | Description |
|-----|------|-------------|
| `<Space>pp` | n | Find projects |
| `<Space>po` | n | Open recent project |
| `<Space>pr` | n | Recent projects |
| `<Space>pd` | n | **Go to project root directory** |
| `<Space>pl` | n | Load session |
| `<Space>ps` | n | Save project session |
| `<Space>px` | n | Delete project session |

## Text Editing

### Movement & Selection
| Key | Mode | Description |
|-----|------|-------------|
| `F` | n | Hop words forward |
| `T` | n | Hop char forward |
| `J` | v | Move selection down |
| `K` | v | Move selection up |
| `Y` | n | Yank to end of line |

### Treesitter Navigation
| Key | Mode | Description |
|-----|------|-------------|
| `]m` | n | Next function start |
| `[m` | n | Previous function start |
| `]M` | n | Next function end |
| `[M` | n | Previous function end |
| `]]` | n | Next class start |
| `[[` | n | Previous class start |
| `][` | n | Next class end |
| `[]` | n | Previous class end |
| `gnd` | n | Go to definition (Treesitter fallback) |

### Treesitter Selection (Progressive)
| Key | Mode | Description |
|-----|------|-------------|
| `gnn` | n | **Start incremental selection** |
| `gns` | n | **Expand to next node** |
| `gnc` | n | **Expand to next scope** |
| `gnm` | n | **Shrink selection** |

### Treesitter Text Objects
| Key | Mode | Description |
|-----|------|-------------|
| `af` | x/o | Around function |
| `if` | x/o | Inside function |
| `ac` | x/o | Around class |
| `ic` | x/o | Inside class |
| `df` | n | Peek function definition |
| `dF` | n | Peek class definition |

### Treesitter Refactoring
| Key | Mode | Description |
|-----|------|-------------|
| `gtr` | n | **Treesitter smart rename** |
| `<a-*>` | n | Next usage |
| `<a-#>` | n | Previous usage |

### Text Objects & Surrounds
| Key | Mode | Description |
|-----|------|-------------|
| `sa` | n/x | Add surrounding |
| `sd` | n | Delete surrounding |
| `sr` | n | Replace surrounding |
| `sf` | n | Find right surrounding |
| `sF` | n | Find left surrounding |
| `sh` | n | Highlight surrounding |
| `sn` | n | Update n_lines |

### Mini.ai Text Objects
| Key | Mode | Description |
|-----|------|-------------|
| `a` | x/o | Around textobject |
| `i` | x/o | Inside textobject |
| `an` | x/o | Around next textobject |
| `in` | x/o | Inside next textobject |
| `al` | x/o | Around last textobject |
| `il` | x/o | Inside last textobject |

### Comments
| Key | Mode | Description |
|-----|------|-------------|
| `gc` | n/x | Toggle comment |
| `gcc` | n | Toggle comment line |
| `gc` | o | Comment textobject |

### Substitution & Search
| Key | Mode | Description |
|-----|------|-------------|
| `<Space>sr` | n | Replace current word in buffer |
| `<Space>sl` | n | Replace current word on line |
| `,r` | n | Replace inner word with register |

## Window & Buffer Management

### Window Navigation (Tmux Integration)
| Key | Mode | Description |
|-----|------|-------------|
| `<C-H>` | n | Navigate left |
| `<C-J>` | n | Navigate down |
| `<C-K>` | n | Navigate up |
| `<C-L>` | n | Navigate right |
| `<C-Bslash>` | n | Navigate previous |

### Window Resizing
| Key | Mode | Description |
|-----|------|-------------|
| `<Space><Space>+` | n | Increase height |
| `<Space><Space>-` | n | Decrease height |
| `<Space><Space>>` | n | Increase width |
| `<Space><Space><` | n | Decrease width |

### Buffer Navigation
| Key | Mode | Description |
|-----|------|-------------|
| `<C-^>` | n | Switch to alternate buffer |
| `]b` | n | Next buffer |
| `[b` | n | Previous buffer |
| `]B` | n | Last buffer |
| `[B` | n | First buffer |

## Utilities

### System
| Key | Mode | Description |
|-----|------|-------------|
| `<Space>t` | n | **Inspect** (Treesitter info) |
| `<Space>p` | n | Toggle paste mode |
| `<Space>Q` | n | Quit all (force) |
| `<Space>W` | n | Write all and quit |

### Quickfix & Location Lists
| Key | Mode | Description |
|-----|------|-------------|
| `<Space>qo` | n | **Open quickfix** |
| `<Space>qc` | n | **Close quickfix** |
| `]q` | n | Next quickfix |
| `[q` | n | Previous quickfix |
| `]Q` | n | Last quickfix |
| `[Q` | n | First quickfix |
| `]l` | n | Next location |
| `[l` | n | Previous location |

### Documentation Generation
| Key | Mode | Description |
|-----|------|-------------|
| `<Space>nf` | n | Generate function docs |
| `<Space>nc` | n | Generate class docs |

### Code Formatting
| Key | Mode | Description |
|-----|------|-------------|
| `<Space>cf` | n/v | Format buffer/selection |

## Trouble (Diagnostics)

| Key | Mode | Description |
|-----|------|-------------|
| `<Space>xx` | n | Toggle Trouble |
| `<Space>xw` | n | Workspace diagnostics |
| `<Space>xd` | n | Document diagnostics |
| `<Space>xl` | n | Location list |
| `<Space>xq` | n | Quickfix |
| `<Space>xR` | n | LSP references |

## Scrolling (Neoscroll)

| Key | Mode | Description |
|-----|------|-------------|
| `<C-U>` | n/x/s | Scroll up |
| `<C-D>` | n/x/s | Scroll down |
| `<C-B>` | n/x/s | Page up |
| `<C-F>` | n/x/s | Page down |
| `<C-Y>` | n/x/s | Line up |
| `<C-E>` | n/x/s | Line down |
| `zt` | n/x/s | Top |
| `zz` | n/x/s | Center |
| `zb` | n/x/s | Bottom |

## Autopairs

| Key | Mode | Description |
|-----|------|-------------|
| `"` | i | Smart quote pairing |
| `'` | i | Smart quote pairing |
| `(` | i | Smart parentheses |
| `)` | i | Smart parentheses |
| `[` | i | Smart brackets |
| `]` | i | Smart brackets |
| `{` | i | Smart braces |
| `}` | i | Smart braces |
| `` ` `` | i | Smart backticks |
| `<BS>` | i | Smart backspace |

## Special Keys

### Insert Mode
| Key | Mode | Description |
|-----|------|-------------|
| `<C-C>` | i | Escape to normal |
| `<C-S>` | i | Signature help |
| `<M-CR>` | i | Copilot panel open |

### Misc Utilities
| Key | Mode | Description |
|-----|------|-------------|
| `<Space>\`` | n | Surround word with backticks |
| `gx` | n/x | Open URL/file under cursor |
| `v` | n/x | Visual mode |
| `p` | v | Paste without yanking |
| `yy` | v | Yank with OSC52 support |

---

## Key Patterns Summary

- **`<Space>` prefix**: Main leader key for most commands
- **`g` prefix**: LSP navigation and text operations
- **`]` / `[` prefix**: Next/previous navigation
- **`<C-*>` combos**: Window navigation and scrolling
- **`s` prefix**: Surround operations
- **AI tools**: Various AI assistants with different prefixes

## Quick Reference for Common Tasks

- **Ghost text toggle**: `<leader>tg`
- **File search**: `<Space>sf`
- **Live grep**: `<Space>sg`
- **Git status**: `<Space>gs`
- **LSP rename**: `grn`
- **Code actions**: `gra`
- **Go to definition**: `gd`
- **Toggle file tree**: `<Space>b`
- **Quick switch buffer**: `<C-^>`

### Treesitter Workflows
- **Progressive selection**: `gnn` → `gns` → `gns` → `gnc`
- **Function navigation**: `]m` (start) / `]M` (end)
- **Class navigation**: `]]` (start) / `][` (end)
- **Smart text objects**: `daf` (delete around function), `vic` (select inside class)
- **Treesitter rename**: `gtr` (vs LSP `grn`)
