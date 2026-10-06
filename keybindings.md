# Keybindings

## Neovim

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
| `<leader>gb` | `Snacks.picker.git_branches()` | Git Branches |
| `<leader>gl` | `Snacks.picker.git_log()` | Git Log |
| `<leader>gL` | `Snacks.picker.git_log_line()` | Git Log Line |
| `<leader>gs` | `Snacks.picker.git_status()` | Git Status |
| `<leader>gS` | `Snacks.picker.git_stash()` | Git Stash |
| `<leader>gd` | `Snacks.picker.git_diff()` | Git Diff (Hunks) |
| `<leader>gf` | `Snacks.picker.git_log_file()` | Git Log File |
| `<leader>gi` / `<leader>gI` | `Snacks.picker.gh_issue()` | GitHub Issues (open / all) |
| `<leader>gp` / `<leader>gP` | `Snacks.picker.gh_pr()` | GitHub Pull Requests (open / all) |
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
| `<leader>gB` | `Snacks.gitbrowse()` | Open in GitHub/Browser |
| `<leader>gg` | `Snacks.lazygit()` | Lazygit |
| `<leader>un` | `Snacks.notifier.hide()` | Dismiss Notifications |
| `<c-/>` | `Snacks.terminal()` | Toggle Floating Terminal |
| `]]` / `[[` | `Snacks.words.jump()` | Next / Prev Reference |
| `<leader>u[s/w/d/l/c/T/b/h/g/D]` | `Snacks.toggle.*` | Quick Option Toggles |


### LSP

#### General Navigation & Pickers (via Snacks.nvim)
| Key | Function | Description |
|---|---|---|
| `gd` | `Snacks.picker.lsp_definitions()` | Goto Definition |
| `gD` | `Snacks.picker.lsp_declarations()` | Goto Declaration |
| `gr` | `Snacks.picker.lsp_references()` | Find References |
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
| `gra` / `<leader>ca` | `Lspsaga code_action` | Code Action |
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
| `<leader>cv` | Virtualenv Info | Python: Show Virtual Env (`vim.notify`) |


### General

| Key | Function | Description |
|---|---|---|
| `<Esc>` | `<C-\><C-n>` | Exit terminal mode |
| `<C-c>` | `<ESC>` | |
| `yy` | `y<CR>:let @"=substitute(@", '\n', '', 'g')<CR>:call yank#Osc52Yank()<CR>` | Join yanked text on a yank |
| `J` | `:m '>+1<CR>gv=gv` | Move selected lines down |
| `K` | `:m '<-2<CR>gv=gv` | Move selected lines up |
| `<leader>p` | `:set paste!<CR>` | Toggle Paste mode |
| `<C-J>` | `<C-W><C-J>` | Window navigation |
| `<C-K>` | `<C-W><C-K>` | Window navigation |
| `<C-L>` | `<C-W><C-L>` | Window navigation |
| `<C-H>` | `<C-W><C-H>` | Window navigation |
| `<leader>>` | `:vertical resize +10<CR>` | Adjusting splits |
| `<leader><` | `:vertical resize -10<CR>` | Adjusting splits |
| `<leader>+` | `:resize +10<CR>` | Adjusting splits |
| `<leader>-` | `:resize -10<CR>` | Adjusting splits |
| `<leader>pd` | `:cd %:p:h<CR>:pwd<CR>` | Change directory to current buffer directory |
| `<C-^>` | `:b#<CR>` | |
| `<Leader>Q` | `:qall!<CR>` | Discard all changed buffers & quit |
| `<Leader>W` | `:wqall<CR>` | write all and quit |
| `<space>t` | `:Inspect<CR>` | Treesitter highlight inspection |
| `<leader>qo` | `:cope<cr>` | Open quickfix |
| `<leader>qc` | `:cclose<cr>` | Close quickfix |
| ``<leader>` `` | `ysiW` | Surround word under cursor w/ backticks |
| `,r` | `"_diwhp` | REPLACE: delete inner word & replace with last yanked |
| `<up>` | `<C-w><up>` | Move between Windows |
| `<down>` | `<C-w><down>` | Move between Windows |
| `<left>` | `<C-w><left>` | Move between Windows |
| `<right>` | `<C-w><right>` | Move between Windows |
| `<leader>sr` | `:%s/<C-R><C-W>//gI<left><left><left>` | Replace word under cursor in Buffer (case-sensitive) |
| `<leader>sl` | `:s/<C-R><C-W>//gI<left><left><left>` | Replace word under cursor on Line (case-sensitive) |
| `F` | `require'hop'.hint_words({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true })` | |
| `T` | `require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true, hint_offset = -1 })` | |
| `p` | `"_dP` | Paste over currently selected text without yanking it |
| `<leader>gd` | `Gvdiffsplit` | |
| `<leader>gb` | `Git blame` | |
| `<leader>gh` | `0Gclog!` | |
| `<leader>gj` | `diffget //2` | |
| `<leader>gk` | `diffget //3` | |

## Tmux

| Key | Command | Description |
|---|---|---|
| `C-a` | `prefix` | local prefix |
| `C-b` | `send-prefix` | remote prefix |
| `C-c` | `new-session` | create session |
| `C-f` | `command-prompt -p find-session 'switch-client -t %%'` | find session |
| `-` | `split-window -v` | split current window horizontally |
| `|` | `split-window -h` | split current window vertically |
| `H` | `resize-pane -L 10` | pane resizing |
| `J` | `resize-pane -D 10` | pane resizing |
| `K` | `resize-pane -U 10` | pane resizing |
| `L` | `resize-pane -R 10` | pane resizing |
| `C-p` | `previous-window` | select previous window |
| `C-n` | `next-window` | select next window |
| `Tab` | `last-window` | move to last active window |
| `S-Left` | `swap-window -t -1` | |
| `S-Right` | `swap-window -t +1` | |
| `>` | `swap-pane -D` | swap current pane with the next one |
| `<` | `swap-pane -U` | swap current pane with the previous one |
| `x` | `kill-pane` | |
| `X` | `kill-window` | |
| `C-x` | `confirm-before -p "kill other windows? (y/n)" "kill-window -a"` | |
| `Q` | `confirm-before -p "kill-session #S? (y/n)" kill-session` | |
| `r` | `command-prompt -I "#{window_name}" "rename-window '%%'"` | Rename session and window |
| `R` | `command-prompt -I "#{session_name}" "rename-session '%%'"` | Rename session and window |
| `s` | `set-option status` | toggle statusbar |
| `Enter` | `copy-mode` | enter copy mode |
| `v` | `send -X begin-selection` | |
| `C-v` | `send -X rectangle-toggle` | |
| `y` | `send -X copy-selection-and-cancel` | |
| `Escape` | `send -X cancel` | |
| `H` | `send -X start-of-line` | |
| `L` | `send -X end-of-line` | |
| `y` | `run -b "tmux save-buffer - | pbcopy"` | copy to macOS clipboard |
| `y` | `run -b "tmux save-buffer - | reattach-to-user-namespace pbcopy"` | copy to macOS clipboard |
| `y` | `run -b "tmux save-buffer - | xsel -i -b"` | copy to X11 clipboard |
| `y` | `run -b "tmux save-buffer - | xclip -i -selection clipboard >/dev/null 2>&1"` | copy to X11 clipboard |
| `y` | `run -b "tmux save-buffer - | clip.exe"` | copy to Windows clipboard |
| `y` | `run -b "tmux save-buffer - > /dev/clipboard"` | copy to Windows clipboard |
| `DoubleClick1Pane` | `select-pane \; send -X select-word \; send -X copy-pipe-no-clear "yank -i"` | Double-clicking to select a word |
| `DoubleClick1Pane` | `select-pane \; copy-mode -M \; send -X select-word \; send -X copy-pipe-no-clear "yank -i"` | Double-clicking to select a word |
| `TripleClick1Pane` | `select-pane \; send -X select-line \; send -X copy-pipe-no-clear "yank -i"` | triple-clicking to select a line |
| `TripleClick1Pane` | `select-pane \; copy-mode -M \; send -X select-line \; send -X copy-pipe-no-clear "yank -i"` | triple-clicking to select a line |
| `Y` | `send-keys -X copy-pipe 'yank > #{pane_tty}'` | transfer copied text to attached terminal with yank |
| `M-y` | `run-shell 'tmux save-buffer - | yank > #{pane_tty}'` | transfer most-recently copied text to attached terminal with yank |
| `M-Y` | `choose-buffer 'run-shell "tmux save-buffer -b "%%%" - | yank > #{pane_tty}"'` | transfer previously copied text (chosen from a menu) to attached terminal |
| `/` | `command-prompt -i -p "(search down)" "send -X search-forward-incremental "%%%""` | incremental search forward |
| `?` | `command-prompt -i -p "(search up)" "send -X search-backward-incremental "%%%""` | incremental search backward |
| `b` | `list-buffers` | list paste buffers |
| `p` | `paste-buffer` | paste from the top paste buffer |
| `P` | `choose-buffer` | choose which buffer to paste from |
| `C-M-l` | `send-keys C-l \; run 'sleep 0.1' \; clear-history` | clear both screen and history |

## skhd

| Key | Command |
|---|---|
| `alt - w` | `yabai tiling::window --close` |
| `shift + alt - h` | `yabai -m window --warp west` |
| `shift + alt - j` | `yabai -m window --warp south` |
| `shift + alt - k` | `yabai -m window --warp north` |
| `shift + alt - l` | `yabai -m window --warp east` |
| `alt - h` | `yabai -m window --focus west` |
| `alt - j` | `yabai -m window --focus south` |
| `alt - k` | `yabai -m window --focus north` |
| `alt - l` | `yabai -m window --focus east` |
| `lctrl + alt - h` | `yabai -m window --resize left:-80:0 ; yabai -m window --resize right:-80:0` |
| `lctrl + alt - j` | `yabai -m window --resize bottom:0:80 ; yabai -m window --resize top:0:80` |
| `lctrl + alt - k` | `yabai -m window --resize top:0:-80 ; yabai -m window --resize bottom:0:-80` |
| `lctrl + alt - l` | `yabai -m window --resize right:80:0 ; yabai -m window --resize left:80:0` |
| `shift + alt - m` | `yabai -m window --space last && yabai -m space --focus last` |
| `shift + alt - p` | `yabai -m window --space prev && yabai -m space --focus prev` |
| `shift + alt - n` | `yabai -m window --space next && yabai -m space --focus next` |
| `shift + alt - 1` | `yabai -m window --space 1 && yabai -m space --focus 1` |
| `shift + alt - 2` | `yabai -m window --space 2 && yabai -m space --focus 2` |
| `shift + alt - 3` | `yabai -m window --space 3 && yabai -m space --focus 3` |
| `shift + alt - 4` | `yabai -m window --space 4 && yabai -m space --focus 4` |
| `shift + alt - 5` | `yabai -m window --space 5 && yabai -m space --focus 5` |
| `shift + alt - 6` | `yabai -m window --space 6 && yabai -m space --focus 6` |
| `hyper - 1` | `yabai -m window --space 1` |
| `hyper - 2` | `yabai -m window --space 2` |
| `hyper - 3` | `yabai -m window --space 3` |
| `hyper - 4` | `yabai -m window --space 4` |
| `hyper - 5` | `yabai -m window --space 5` |
| `hyper - 6` | `yabai -m window --space 6` |
| `shift + alt - c` | `yabai -m window --toggle float; yabai -m window --toggle zoom-fullscreen` |
| `hyper - c` | `yabai -m window --toggle float && yabai -m window --grid 4:4:1:0:2:4` |
| `alt - c` | `yabai -m window --grid 4:4:1:0:2:4` |
| `shift + alt - t` | `yabai -m window --toggle float --grid 4:4:1:0:2:4` |
| `lctrl + alt - 0` | `yabai -m space --balance` |
| `lctrl + alt - g` | `yabai -m space --toggle padding; yabai -m space --toggle gap` |
| `alt - r` | `yabai -m space --rotate 90` |
| `shift + alt - r` | `yabai -m space --rotate 270` |
| `shift + alt - x` | `yabai -m space --mirror x-axis` |
| `shift + alt - y` | `yabai -m space --mirror y-axis` |
| `shift + lctrl + alt - h` | `yabai -m window --insert west` |
| `shift + lctrl + alt - j` | `yabai -m window --insert south` |
| `shift + lctrl + alt - k` | `yabai -m window --insert north` |
| `shift + lctrl + alt - l` | `yabai -m window --insert east` |
| `shift + alt - space` | `yabai -m window --toggle float` |
| `shift + lctrl + alt - f` | `yabai -m config layout float` |
| `cmd + alt - 1` | `yabai -m space --focus 1` |
| `cmd + alt - 2` | `yabai -m space --focus 2` |
| `cmd + alt - 3` | `yabai -m space --focus 3` |
| `cmd + alt - 4` | `yabai -m space --focus 4` |
| `cmd + alt - 5` | `yabai -m space --focus 5` |
| `cmd + alt - m` | `yabai -m space --focus recent` |
| `cmd + alt - p` | `yabai -m space --focus prev` |
| `cmd + alt - n` | `yabai -m space --focus next` |
| `cmd + alt - c` | `yabai -m space --create` |
| `cmd + alt - d` | `yabai -m space --destroy` |
| `hyper - b` | `yabai -m space --layout bsp` |
| `hyper - f` | `yabai -m space --layout float` |
| `hyper - up` | `yabai -m window --swap west` |
| `hyper - down` | `yabai -m window --swap east` |
| `hyper - 0x21` | `yabai -m space --move prev` |
| `hyper - 0x1E` | `yabai -m space --move next` |
| `shift + alt - y` | `yabai -m space --mirror y-axis` |
| `shift + alt - x` | `yabai -m space --mirror x-axis` |
| `shift + lctrl + alt - y` | `terminal-notifier -title Yabai -message "Restarting Yabai" -sound default; launchctl kickstart -k "gui/$( id -u )/org.nixos.yabai"` |
| `shift + lctrl + alt - s` | `terminal-notifier -title Skhd -message "Restarting Skhd" -sound default; launchctl kickstart -k "gui/$( id -u )/org.nixos.skhd"` |

## Karabiner

| From | To | Description |
|---|---|---|
| `caps_lock` | `command+control+option+shift` | Change caps_lock to command+control+option+shift. |
| `fn` | `left_control` | Remap FN key to Left Control |
