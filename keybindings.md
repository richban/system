# Keybindings Reference

A unified reference for all keyboard shortcuts across **Neovim**, **Tmux**, **AeroSpace**, and **Karabiner**.

---

## 1. Neovim

### Snacks.nvim (Pickers & Utilities)

| Key | Function | Description |
|---|---|---|
| `<C-p>` | `Snacks.picker.smart()` | Smart Find Files (Frecency + Buffers + Git) |
| `<leader><space>` | `Snacks.picker.smart()` | Smart Find Files |
| `<leader>,` / `<leader>fb` | `Snacks.picker.buffers()` | Buffers |
| `<leader>/` / `<leader>sg` | `Snacks.picker.grep()` | Grep workspace |
| `<leader>:` | `Snacks.picker.command_history()` | Command History |
| `<leader>n` | `Snacks.picker.notifications()` | Notification History |
| `<leader>e` | `Snacks.explorer()` | File Explorer |
| `<leader>fc` | `Snacks.picker.files({ cwd = config })` | Find Config File |
| `<leader>ff` | `Snacks.picker.files()` | Find Files |
| `<leader>fg` | `Snacks.picker.git_files()` | Find Git Files |
| `<leader>fp` / `<leader>pr` | `Snacks.picker.projects()` | Projects (Recent & Discovered) |
| `<leader>ps` | `SessionManager save_current_session` | Save Project Session |
| `<leader>pl` | `SessionManager load_session` | Load Project Session |
| `<leader>po` | `SessionManager load_last_session` | Open Last Session |
| `<leader>px` | `SessionManager delete_session` | Delete Project Session |
| `<leader>pd` | Project root navigation | Go to Project Root Directory |
| `<leader>fr` / `<leader>s.` | `Snacks.picker.recent()` | Recent Files |
| `<leader>sb` | `Snacks.picker.lines()` | Buffer Lines |
| `<leader>sB` | `Snacks.picker.grep_buffers()` | Grep Open Buffers |
| `<leader>sw` | `Snacks.picker.grep_word()` | Grep Word / Selection |
| `<leader>s"` | `Snacks.picker.registers()` | Registers |
| `<leader>s/` | `Snacks.picker.search_history()` | Search History |
| `<leader>sa` | `Snacks.picker.autocmds()` | Autocmds |
| `<leader>sc` | `Snacks.picker.command_history()` | Command History |
| `<leader>sC` | `Snacks.picker.commands()` | Commands |
| `<leader>sd` | `Snacks.picker.diagnostics()` | Workspace Diagnostics |
| `<leader>sD` | `Snacks.picker.diagnostics_buffer()` | Buffer Diagnostics |
| `<leader>sh` | `Snacks.picker.help()` | Help Pages |
| `<leader>sH` | `Snacks.picker.highlights()` | Highlights |
| `<leader>si` | `Snacks.picker.icons()` | Icons |
| `<leader>sj` | `Snacks.picker.jumps()` | Jumps |
| `<leader>sk` | `Snacks.picker.keymaps()` | Keymaps |
| `<leader>sl` | `Snacks.picker.loclist()` | Location List |
| `<leader>sm` | `Snacks.picker.marks()` | Marks |
| `<leader>sM` | `Snacks.picker.man()` | Man Pages |
| `<leader>sp` | `Snacks.picker.lazy()` | Plugin Spec Search |
| `<leader>sq` | `Snacks.picker.qflist()` | Quickfix List |
| `<leader>sR` | `Snacks.picker.resume()` | Resume Last Picker |
| `<leader>su` | `Snacks.picker.undo()` | Undo History |
| `<leader>uC` | `Snacks.picker.colorschemes()` | Colorschemes |
| `<leader>z` / `<leader>Z` | `Snacks.zen()` / `zoom()` | Zen Mode / Zoom |
| `<leader>.` / `<leader>S` | `Snacks.scratch()` | Toggle / Select Scratch Buffer |
| `<leader>bd` | `Snacks.bufdelete()` | Delete Buffer (preserve layout) |
| `<leader>cR` | `Snacks.rename.rename_file()` | Rename File |
| `<leader>un` | `Snacks.notifier.hide()` | Dismiss Notifications |
| `<c-/>` | `Snacks.terminal()` | Toggle Floating Terminal |
| `]]` / `[[` | `Snacks.words.jump()` | Next / Prev Reference |
| `<leader>u[s/w/L/d/l/c/T/b/h/g/D]` | `Snacks.toggle.*` | Quick Option Toggles (spell, wrap, num, diag, etc.) |

---

### LSP (Language Server Protocol)

#### General Navigation & Pickers (via Snacks.nvim)
| Key | Function | Description |
|---|---|---|
| `gd` | `Snacks.picker.lsp_definitions()` | Goto Definition |
| `gD` | `Snacks.picker.lsp_declarations()` | Goto Declaration |
| `gr` / `grr` | `Snacks.picker.lsp_references()` | Find References |
| `gI` | `Snacks.picker.lsp_implementations()` | Goto Implementation |
| `gy` | `Snacks.picker.lsp_type_definitions()` | Goto Type Definition |
| `gai` | `Snacks.picker.lsp_incoming_calls()` | Incoming Calls |
| `gao` | `Snacks.picker.lsp_outgoing_calls()` | Outgoing Calls |
| `<leader>ss` | `Snacks.picker.lsp_symbols()` | Document Symbols |
| `<leader>sS` | `Snacks.picker.lsp_workspace_symbols()` | Workspace Symbols |
| `<leader>sd` | `Snacks.picker.diagnostics()` | Workspace Diagnostics |
| `<leader>sD` | `Snacks.picker.diagnostics_buffer()` | Buffer Diagnostics |

#### Buffer-Local LSP Operations
| Key | Function | Description |
|---|---|---|
| `K` | `vim.lsp.buf.hover()` | Hover Documentation |
| `<C-k>` (insert) | `vim.lsp.buf.signature_help()` | Signature Help |
| `gh` | `Lspsaga lsp_finder` | Interactive Def & Ref Finder |
| `]d` / `[d` | `vim.diagnostic.jump()` | Next / Prev Diagnostic |
| `]e` / `[e` | `vim.diagnostic.jump(ERROR)` | Next / Prev Error |
| `]w` / `[w` | `vim.diagnostic.jump(WARN)` | Next / Prev Warning |
| `<leader>cd` | `vim.diagnostic.open_float()` | Line Diagnostics Float |
| `gra` / `<leader>ca` | `Lspsaga code_action` | Code Action / Auto-Fix |
| `grn` / `<leader>rn` | `Lspsaga rename` | Rename Symbol |
| `grx` | `vim.lsp.codelens.run()` | Run Code Lens |
| `<leader>li` | `vim.notify(...)` | Show Attached Clients |
| `<leader>ll` | `vim.notify(...)` | Show Log Path |

#### Language Workflows (under `<leader>c` [C]ode)
| Key | Function | Description |
|---|---|---|
| `<leader>co` | Organize Imports | Organize Imports (Python Ruff / TS `organizeImports`) |
| `<leader>ci` | TypeScript Import All | TS: Add Missing Imports |
| `<leader>cf` | `conform.format()` | Code Format (`conform.nvim` - ruff / prettier / etc.) |
| `<leader>ca` / `gra` | `Lspsaga code_action` | Code Action / Auto-Fix (Ruff fixes, TS fixes) |
| `<leader>ct` | Pytest Runner | Python: Run Tests (auto-detects test file) |
| `<leader>cv` | Virtualenv Info | Python: Show Virtual Env |

---

### Git Operations

Neovim integrates Git through **Gitsigns** (in-buffer hunks & blame), **Neogit** (status dashboard), **Diffview** (diffs & merge tool), and **Snacks** (pickers).

#### Gitsigns (Hunk Actions & In-Buffer Blame)
| Key | Mode | Function | Description |
|---|---|---|---|
| `]h` / `[h` | Normal | `next_hunk` / `prev_hunk` | Jump to next / previous changed hunk |
| `<leader>hs` | Normal / Visual | `stage_hunk` | Stage hunk (in visual mode: stage selected lines) |
| `<leader>hr` | Normal / Visual | `reset_hunk` | Revert hunk (in visual mode: revert selection) |
| `<leader>hS` | Normal | `stage_buffer` | Stage entire buffer |
| `<leader>hu` | Normal | `undo_stage_hunk` | Undo last staged hunk |
| `<leader>hR` | Normal | `reset_buffer` | Reset entire buffer back to HEAD |
| `<leader>hp` | Normal | `preview_hunk` | Floating popup preview of current hunk |
| `<leader>hb` | Normal | `blame_line({ full = true })` | Detailed commit blame popup for current line |
| `<leader>gB` | Normal | `:Gitsigns blame` | Full-file blame in scroll-bound side split |
| `<leader>hd` | Normal | `diffthis` | Diff current buffer against git index |
| `<leader>hD` | Normal | `diffthis("~")` | Diff current buffer against previous commit (`HEAD~1`) |
| `<leader>tb` | Normal | `toggle_current_line_blame` | Toggle live inline blame virtual text |
| `<leader>td` | Normal | `toggle_deleted` | Toggle inline display of deleted lines |
| `ih` | Visual / Operator | `select_hunk` | Hunk text object (e.g. `vih` to select, `dih` to delete) |

#### Neogit (Status Dashboard & Git Operations)
Open dashboard: `<leader>gs` (`:Neogit kind=tab`). *Auto-closes upon successful push.*

| Key | Action | Description |
|---|---|---|
| `j` / `k` | Navigate | Move cursor up / down |
| `<Tab>` | Toggle | Expand / collapse file diff or section |
| `<CR>` | Open | Go to file under cursor |
| `s` / `u` | Stage / Unstage | Stage / unstage file, hunk, or visual selection |
| `S` / `U` | Stage / Unstage All | Stage / unstage all files |
| `x` | Discard | Discard changes (with confirmation) |
| `c` | **Commit Popup** | `c c` commit, `c a` amend, `c e` extend, `c f` fixup |
| `p` | **Push Popup** | `p p` push remote, `p u` push upstream, `p f` force push |
| `F` | **Pull Popup** | `F p` pull remote, `F r` pull with rebase |
| `f` | **Fetch Popup** | `f p` fetch remote, `f a` fetch all |
| `b` | **Branch Popup** | `b b` checkout, `b c` create branch, `b d` delete branch |
| `m` | **Merge Popup** | `m m` merge, `m a` abort merge |
| `r` | **Rebase Popup** | `r r` rebase, `r i` interactive rebase, `r c` continue, `r a` abort |
| `z` | **Stash Popup** | `z z` stash both, `z p` pop, `z a` apply, `z d` drop |
| `d` | **Diff Popup** | Open diff menu (integrated with Diffview) |
| `l` | **Log Popup** | `l l` log HEAD, `l a` log all branches |
| `R` | Refresh | Refresh repository status |
| `$` / `<C-x>` | Command History | View Git command execution logs |
| `q` | Quit | Close Neogit tab |
| `?` | Help | Show interactive help menu |

#### Diffview (Side-by-Side Diffs, 3-Way Merge Tool & History)
Commands: `:DiffviewOpen [rev]`, `:DiffviewClose` (`q`), `:DiffviewFileHistory [path]`

| Key | Context | Description |
|---|---|---|
| `j` / `k` (or `<down>` / `<up>`) | File Panel | Move up / down file list |
| `<CR>` / `o` / `l` | File Panel | Open diff for selected file |
| `s` / `-` | File Panel | Stage / unstage selected file |
| `S` / `U` | File Panel | Stage all / unstage all files |
| `X` | File Panel | Restore/discard file changes |
| `L` | File Panel | Open commit log panel |
| `i` / `f` | File Panel | Toggle listing style (`tree`/`list`) / flatten directories |
| `zo` / `zc` / `za` | File Panel | Expand / Collapse / Toggle folder fold |
| `zR` / `zM` | File Panel | Expand all / Collapse all folders |
| `R` | File Panel | Refresh file list |
| `<Tab>` / `<S-Tab>` | File Panel & Diff | Jump to next / previous file diff |
| `[F` / `]F` | File Panel & Diff | Jump to first / last file diff |
| `gf` | File Panel & Diff | Open file in previous tabpage |
| `<C-w><C-f>` / `<C-w>gf` | File Panel & Diff | Open file in split / new tab |
| `<leader>e` / `<leader>b` | Diff Buffers | Focus file panel / Toggle file panel |
| `g<C-x>` | File Panel & Diff | Cycle diff layouts |
| `q` | Any Diffview view | Close Diffview (`:DiffviewClose`) |
| `g?` | Any Diffview view | Open Diffview help panel |

**3-Way Merge Conflict Resolution** (during merge/rebase with `:DiffviewOpen`):
- `]x` / `[x` : Next / previous conflict marker
- `<leader>co` : Keep **OURS** (current conflict hunk)
- `<leader>ct` : Keep **THEIRS** (current conflict hunk)
- `<leader>cb` : Keep **BASE** (current conflict hunk)
- `<leader>ca` : Keep **ALL** versions
- `dx` : Delete conflict region
- `2do` / `3do` : Obtain hunk from OURS (`2`) / THEIRS (`3`)
- `<leader>cO` / `<leader>cT` / `<leader>cB` / `<leader>cA` / `dX` : Choose version for **entire file**

**File History Panel** (`:DiffviewFileHistory %`):
- `<CR>` / `o` / `l` : Open diff of selected commit
- `<C-A-d>` : Open entry in full Diffview
- `y` : Copy commit hash
- `L` : Show commit details
- `X` : Restore file to selected commit state
- `g!` : Open history options panel

#### Snacks Git Pickers
| Key | Function | Description |
|---|---|---|
| `<leader>gb` | `Snacks.picker.git_branches()` | Switch, search, and checkout Git branches |
| `<leader>gl` | `Snacks.picker.git_log()` | Search commit history (fuzzy log) |
| `<leader>gL` | `Snacks.picker.git_log_line()` | Git log for current line |
| `<leader>gf` | `Snacks.picker.git_log_file()` | Git log for current file |
| `<leader>gd` | `Snacks.picker.git_diff()` | Search modified diff hunks |
| `<leader>gS` | `Snacks.picker.git_stash()` | Search and apply git stashes |
| `<leader>fg` | `Snacks.picker.git_files()` | Find tracked Git files |
| `<leader>gg` | `Snacks.lazygit()` | Open Lazygit in floating terminal |
| `<leader>gi` / `<leader>gI` | `Snacks.picker.gh_issue()` | GitHub Issues (open / all) |
| `<leader>gp` / `<leader>gP` | `Snacks.picker.gh_pr()` | GitHub Pull Requests (open / all) |

---

### File Explorers & Managers

| Key | Mode | Function | Description |
|---|---|---|---|
| `-` | Normal | `Oil` | Open parent directory in buffer |
| `<space>-` | Normal | `Oil float` | Open parent directory in floating window |
| `<leader>b` | Normal | `NvimTreeToggle` | Toggle NvimTree file tree |
| `<leader>br` | Normal | `NvimTreeRefresh` | Refresh NvimTree |
| `<leader>n` | Normal | `Yazi` | Open Yazi at current file |
| `<leader>cw` | Normal | `Yazi cwd` | Open Yazi in working directory |
| `<C-Up>` | Normal | `Yazi toggle` | Resume last Yazi session |

---

### Diagnostics & Lists (Trouble & Quickfix)

| Key | Mode | Function | Description |
|---|---|---|---|
| `<leader>xx` | Normal | `Trouble diagnostics toggle` | Toggle Trouble Diagnostics |
| `<leader>xw` | Normal | `Trouble diagnostics toggle` | Workspace Diagnostics (Trouble) |
| `<leader>xd` | Normal | `Trouble filter.buf=0` | Buffer Diagnostics (Trouble) |
| `<leader>xl` | Normal | `Trouble loclist toggle` | Location List (Trouble) |
| `<leader>xq` | Normal | `Trouble qflist toggle` | Quickfix List (Trouble) |
| `<leader>xR` | Normal | `Trouble lsp toggle` | LSP References (Trouble) |
| `<leader>qo` | Normal | `:copen<CR>` | Open quickfix list |
| `<leader>qc` | Normal | `:cclose<CR>` | Close quickfix list |

---

### Completion (nvim-cmp)

| Key | Mode | Description |
|---|---|---|
| `<C-n>` | Insert / Cmdline | Select next completion item |
| `<C-p>` | Insert / Cmdline | Select previous completion item |
| `<C-y>` | Insert / Cmdline | Confirm completion selection |
| `<C-e>` | Insert | Abort completion |
| `<C-f>` / `<C-b>` | Insert | Scroll completion documentation down / up |
| `<C-d>` | Insert | Toggle completion documentation float |
| `<leader>tg` | Normal | Toggle completion ghost text |

---

### Code Annotations (Neogen)

| Key | Mode | Function | Description |
|---|---|---|---|
| `<leader>nf` | Normal | `neogen.generate()` | Generate docstring/annotation for function |
| `<leader>nc` | Normal | `neogen.generate({ type = "class" })` | Generate docstring/annotation for class |

---

### Editing, Surrounds & Motions

| Key | Mode | Function | Description |
|---|---|---|---|
| `J` | Visual | `:m '>+1<CR>gv=gv` | Move selected lines down (keeps selection) |
| `K` | Visual | `:m '<-2<CR>gv=gv` | Move selected lines up (keeps selection) |
| `p` | Visual | `P` | Paste over selection without clobbering register |
| `,r` | Normal | `viwP` | Replace word under cursor with last yank |
| `<leader>ya` | Visual | `yank absolute` | Copy selection prefixed with absolute path |
| `<leader>yr` | Visual | `yank relative` | Copy selection prefixed with cwd-relative path |
| `sa` | Normal / Visual | `mini.surround` | Add surrounding (e.g. `saiw)`) |
| `sd` | Normal | `mini.surround` | Delete surrounding (e.g. `sd'`) |
| `sr` | Normal | `mini.surround` | Replace surrounding (e.g. `sr)'`) |
| ``<leader>` `` | Normal | `ysiW\`` | Surround word under cursor with backticks |
| `va)` / `vi)` | Visual | `mini.ai` | Select around / inside parentheses |
| `F` | Normal | `hop.hint_words` | Jump forward to word on current line |
| `T` | Normal | `hop.hint_char1` | Jump forward to character on current line |
| `<leader>sr` | Normal | `:%s/.../gI` | Replace word under cursor across buffer |
| `<leader>sl` | Normal | `:s/.../gI` | Replace word under cursor on line |

---

### Windows & Buffers

| Key | Mode | Function | Description |
|---|---|---|---|
| `<C-h>` / `<C-j>` / `<C-k>` / `<C-l>` | Normal | Tmux Navigator | Seamless navigation across Neovim splits & Tmux panes |
| `<Up>` / `<Down>` / `<Left>` / `<Right>` | Normal | `<C-w><Up/Down/...>` | Navigate between split windows |
| `<leader>>` / `<leader><` | Normal | `vertical resize +/-10` | Widen / narrow split window |
| `<leader>+` / `<leader>-` | Normal | `resize +/-10` | Taller / shorter split window |
| `<C-^>` | Normal | `:b#<CR>` | Switch to alternate buffer |
| `<leader>Q` | Normal | `:qall!<CR>` | Discard changes & quit all |
| `<leader>W` | Normal | `:wqall<CR>` | Write all buffers & quit |
| `<space>t` | Normal | `:Inspect<CR>` | Treesitter highlight inspection |
| `<Esc>` | Terminal | `<C-\><C-n>` | Exit terminal-insert mode |
| `<C-c>` | Insert | `<Esc>` | Escape insert mode (triggers InsertLeave) |

---

## 2. Tmux

**Prefix**: `C-a` (local), `C-b` (remote)

### Sessions & Windows
| Key | Command | Description |
|---|---|---|
| `prefix + C-c` | `new-session` | Create new session |
| `prefix + C-f` | `command-prompt -p find-session ...` | Find and switch session |
| `prefix + r` / `R` | `rename-window` / `rename-session` | Rename window / session |
| `prefix + C-p` / `C-n` | `previous-window` / `next-window` | Previous / next window |
| `prefix + Tab` | `last-window` | Switch to last active window |
| `prefix + S-Left` / `S-Right` | `swap-window -t -1` / `+1` | Swap window position left / right |
| `prefix + x` | `kill-pane` | Kill current pane |
| `prefix + X` | `kill-window` | Kill current window |
| `prefix + C-x` | `kill-window -a` | Kill all other windows (with confirm) |
| `prefix + Q` | `kill-session` | Kill current session (with confirm) |
| `prefix + s` | `set-option status` | Toggle status bar |

### Panes & Navigation
| Key | Command | Description |
|---|---|---|
| `prefix + -` | `split-window -v` | Split pane horizontally |
| `prefix + |` | `split-window -h` | Split pane vertically |
| `C-h` / `C-j` / `C-k` / `C-l` | `vim-tmux-navigator` | Navigate panes (seamless with Neovim) |
| `prefix + H` / `J` / `K` / `L` | `resize-pane -L/-D/-U/-R 10` | Resize pane by 10 columns/rows |
| `prefix + >` / `<` | `swap-pane -D` / `-U` | Swap pane with next / previous pane |
| `prefix + C-p` | `display-popup -E "ipython"` | Open IPython floating popup |
| `prefix + C-M-l` | `clear-history` | Clear both screen and pane scrollback |

### Copy Mode & Buffers
| Key | Command | Description |
|---|---|---|
| `prefix + Enter` | `copy-mode` | Enter copy mode |
| `v` / `C-v` (copy mode) | `begin-selection` / `rectangle-toggle` | Start selection / rectangular selection |
| `y` (copy mode) | `copy-selection-and-cancel` | Copy selection to system clipboard |
| `Escape` (copy mode) | `send -X cancel` | Cancel copy mode |
| `H` / `L` (copy mode) | `start-of-line` / `end-of-line` | Jump to start / end of line |
| `prefix + /` / `?` | Search | Incremental search forward / backward |
| `prefix + b` | `list-buffers` | List paste buffers |
| `prefix + p` | `paste-buffer` | Paste top buffer |
| `prefix + P` | `choose-buffer` | Choose paste buffer interactively |

---

## 3. AeroSpace (Tiling Window Manager)

AeroSpace manages windows and workspaces on macOS using `alt` (`Option`) bindings.

### Layout Controls
| Key | Command | Description |
|---|---|---|
| `alt - /` | `layout tiles vertical horizontal` | Toggle tiling orientation (vertical / horizontal) |
| `alt - ,` | `layout accordion vertical horizontal` | Toggle accordion layout |
| `alt - f` | `fullscreen` | Toggle fullscreen for focused window |

### Focus Navigation (Vim Mnemonics)
| Key | Command | Description |
|---|---|---|
| `alt - h` | `focus left` | Focus window to the left |
| `alt - j` | `focus down` | Focus window below |
| `alt - k` | `focus up` | Focus window above |
| `alt - l` | `focus right` | Focus window to the right |

### Window Movement
| Key | Command | Description |
|---|---|---|
| `alt - shift - h` | `move left` | Move window left |
| `alt - shift - j` | `move down` | Move window down |
| `alt - shift - k` | `move up` | Move window up |
| `alt - shift - l` | `move right` | Move window right |

### Multi-Monitor Navigation
| Key | Command | Description |
|---|---|---|
| `alt - ctrl - h` | `focus-monitor left` | Focus monitor to the left |
| `alt - ctrl - j` | `focus-monitor down` | Focus monitor below |
| `alt - ctrl - k` | `focus-monitor up` | Focus monitor above |
| `alt - ctrl - l` | `focus-monitor right` | Focus monitor to the right |
| `alt - ctrl - shift - h` | `move-node-to-monitor left` | Move window to monitor on the left |
| `alt - ctrl - shift - j` | `move-node-to-monitor down` | Move window to monitor below |
| `alt - ctrl - shift - k` | `move-node-to-monitor up` | Move window to monitor above |
| `alt - ctrl - shift - l` | `move-node-to-monitor right` | Move window to monitor on the right |

### Window Resizing
| Key | Command | Description |
|---|---|---|
| `alt - -` | `resize smart -50` | Shrink focused window |
| `alt - =` | `resize smart +50` | Enlarge focused window |

### Workspaces
Workspaces are mapped to dedicated workflows:

| Key | Workspace | Assigned Applications |
|---|---|---|
| `alt - 1` | **1: Development** | Alacritty, Cursor |
| `alt - 2` | **2: Browsers** | Arc, Google Chrome, Safari, Claude |
| `alt - 3` | **3: Notes** | Obsidian, Notion |
| `alt - 4` | **4: General** | General applications |
| `alt - 5` | **5: Productivity** | Apple Calendar |
| `alt - c` | **C: Communications** | WeChat, Apple Mail, Discord, Slack, Messages, WhatsApp |
| `alt - d` | **D: Default** | Catch-all default workspace |
| `alt - s` | **S: Secondary** | Secondary display / Laptop built-in screen |

#### Move Window to Workspace (Focus Follows Window)
| Key | Description |
|---|---|
| `alt - shift - 1` | Move window to Workspace 1 (Dev) |
| `alt - shift - 2` | Move window to Workspace 2 (Browsers) |
| `alt - shift - 3` | Move window to Workspace 3 (Notes) |
| `alt - shift - 4` | Move window to Workspace 4 (General) |
| `alt - shift - 5` | Move window to Workspace 5 (Productivity) |
| `alt - shift - c` | Move window to Workspace C (Communications) |
| `alt - shift - d` | Move window to Workspace D (Default) |
| `alt - shift - s` | Move window to Workspace S (Secondary display) |

#### Workspace Switching
| Key | Command | Description |
|---|---|---|
| `alt - tab` | `workspace-back-and-forth` | Switch to previously active workspace |
| `alt - shift - tab` | `move-workspace-to-monitor --wrap-around next` | Move entire workspace to next monitor |

### Service Mode (`alt - shift - ;`)
Enters modal service mode for management and layout maintenance:

| Key | Command | Description |
|---|---|---|
| `esc` | `reload-config` | Reload AeroSpace config & return to main mode |
| `r` | `flatten-workspace-tree` | Reset / flatten layout tree & return to main mode |
| `f` | `layout floating tiling` | Toggle floating vs tiling for focused window |
| `backspace` | `close-all-windows-but-current` | Close all other windows in workspace |
| `alt - shift - h` | `join-with left` | Join container with window on the left |
| `alt - shift - j` | `join-with down` | Join container with window below |
| `alt - shift - k` | `join-with up` | Join container with window above |
| `alt - shift - l` | `join-with right` | Join container with window on the right |
| `up` / `down` | `volume up` / `volume down` | Adjust system volume |
| `shift - down` | `volume set 0` | Mute system volume |

---

## 4. Karabiner-Elements

Hardware remappings applied at the system level:

| Key | Remapped To | Description |
|---|---|---|
| `caps_lock` | `Cmd + Ctrl + Opt + Shift` | **Hyper Key** for system-wide shortcuts |
| `fn` | `left_control` | Remaps `Fn` key to standard `Left Control` |
