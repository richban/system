# Keybindings

## Neovim

### Telescope

| Key | Function | Description |
|---|---|---|
| `<leader>sh` | `builtin.help_tags` | [S]earch [H]elp |
| `<leader>sk` | `builtin.keymaps` | [S]earch [K]eymaps |
| `<leader>sf` | `builtin.find_files` | [S]earch [F]iles |
| `<leader>ss` | `builtin.builtin` | [S]earch [S]elect Telescope |
| `<leader>sw` | `builtin.grep_string` | [S]earch current [W]ord |
| `<leader>sg` | `builtin.live_grep` | [S]earch by [G]rep |
| `<leader>sd` | `builtin.diagnostics` | [S]earch [D]iagnostics |
| `<leader>sr` | `builtin.resume` | [S]earch [R]esume |
| `<leader>s.` | `builtin.oldfiles` | [S]earch Recent Files ("." for repeat) |
| `<C-b>` | `builtin.buffers` | [ ] Find existing buffers |
| `<leader><leader>` | `Telescope frecency` | |
| `<leader>/` | `builtin.current_buffer_fuzzy_find` | [/] Fuzzily search in current buffer |
| `<leader>s/` | `builtin.live_grep` | [S]earch [/] in Open Files |
| `<leader>f/` | `grep_last_search` | |
| `<C-p>` | `git_files` | |
| `<leader>sc` | `git_commits` | |
| `<leader>sb` | `git_branches` | |
| `<leader>so` | `vim_options` | |
| `<leader>/c` | `commands` | |
| `<leader>/r` | `registers` | |
| `<leader>/m` | `marks` | |
| `<leader>/t` | `treesitter` | |
| `<leader>fB` | `builtin` | |

### LSP

| Key | Function | Description |
|---|---|---|
| `gd` | `Telescope lsp_definitions` | Goto Definition |
| `gD` | `vim.lsp.buf.declaration` | [G]oto [D]eclaration |
| `gr` | `Telescope lsp_references` | Find References |
| `gI` | `require("telescope.builtin").lsp_implementations` | [G]oto [I]mplementation |
| `<leader>D` | `require("telescope.builtin").lsp_type_definitions` | Type [D]efinition |
| `K` | `vim.lsp.buf.hover` | Hover Documentation |
| `gK` | `vim.lsp.buf.signature_help` | Signature Help |
| `<leader>ds` | `require("telescope.builtin").lsp_document_symbols` | [D]ocument [S]ymbols |
| `<leader>ws` | `require("telescope.builtin").lsp_dynamic_workspace_symbols` | [W]orkspace [S]ymbols |
| `[d` | `M.diagnostic_goto(true)` | Next Diagnostic |
| `]d` | `M.diagnostic_goto(false)` | Prev Diagnostic |
| `]e` | `M.diagnostic_goto(true, "ERROR")` | Next Error |
| `[e` | `M.diagnostic_goto(false, "ERROR")` | Prev Error |
| `]w` | `M.diagnostic_goto(true, "WARNING")` | Next Warning |
| `[w` | `M.diagnostic_goto(false, "WARNING")` | Prev Warning |
| `<leader>ca` | `Lspsaga code_action` | Code Action |
| `<leader>rn` | `M.rename` | Rename |
| `<leader>cw` | `Toggle Virtual Lines Diagnostics` | |
| `gh` | `Lspsaga lsp_finder` | Show Definition & References |
| `<leader>li` | `print(vim.inspect(vim.lsp.get_clients()))` | Show Info |
| `<leader>ll` | `print(vim.lsp.get_log_path())` | Show Log Path |
| `<leader>to` | `:TSLspOrganize` | TS: Organize Imports |
| `<leader>tc` | `:TSLspFixCurrent` | TS: Fix Current |
| `<leader>ti` | `:TSLspImportAll` | TS: Import All |
| `<leader>po` | `Organize Imports with ruff` | Python: Organize Imports |
| `<leader>pc` | `Check with Ruff` | Python: Check with Ruff |
| `<leader>pf` | `Format with Ruff` | Python: Format with Ruff |
| `<leader>pt` | `Run Tests` | Python: Run Tests |
| `<leader>pv` | `Show Virtual Env` | Python: Show Virtual Env |
| `<leader>wa` | `vim.lsp.buf.add_workspace_folder` | Workspace Add Folder |
| `<leader>wr` | `vim.lsp.buf.remove_workspace_folder` | Workspace Remove Folder |
| `<leader>wl` | `print(vim.inspect(vim.lsp.buf.list_workspace_folders()))` | Workspace List Folders |
| `<leader>cd` | `vim.diagnostic.open_float` | Line Diagnostics |
| `<leader>cl` | `vim.diagnostic.setloclist` | Location List |
| `<leader>cq` | `vim.diagnostic.setqflist` | Quickfix List |
| `gi` | `Telescope lsp_implementations` | Goto Implementation |
| `<leader>ci` | `Lspsaga incoming_calls` | Incoming Calls |
| `<leader>co` | `Lspsaga outgoing_calls` | Outgoing Calls |
| `<leader>cl` | `vim.lsp.codelens.run` | Code Lens |
| `<leader>ch` | `vim.lsp.buf.document_highlight` | Highlight Symbol |
| `<leader>cs` | `Telescope lsp_document_symbols` | Document Symbols |

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
| `<leader>cd` | `:cd %:p:h<CR>:pwd<CR>` | Change directory to current directory |
| `<C-^>` | `:b#<CR>` | |
| `<Leader>Q` | `:qall!<CR>` | Discard all changed buffers & quit |
| `<Leader>W` | `:wqall<CR>` | write all and quit |
| `<space>t` | `:TSHighlightCapturesUnderCursor<CR>` | |
| `<leader>co` | `:cope<cr>` | open quickfix |
| `<leader>cl` | `:cclose<cr>` | close quickfix |
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
| `fn + a` | `left_control + a` | Change fn + letter to left_control + letter |
| `fn + b` | `left_control + b` | Change fn + letter to left_control + letter |
| `fn + c` | `left_control + c` | Change fn + letter to left_control + letter |
| `fn + d` | `left_control + d` | Change fn + letter to left_control + letter |
| `fn + e` | `left_control + e` | Change fn + letter to left_control + letter |
| `fn + f` | `left_control + f` | Change fn + letter to left_control + letter |
| `fn + g` | `left_control + g` | Change fn + letter to left_control + letter |
| `fn + h` | `left_control + h` | Change fn + letter to left_control + letter |
| `fn + i` | `left_control + i` | Change fn + letter to left_control + letter |
| `fn + j` | `left_control + j` | Change fn + letter to left_control + letter |
| `fn + k` | `left_control + k` | Change fn + letter to left_control + letter |
| `fn + l` | `left_control + l` | Change fn + letter to left_control + letter |
| `fn + m` | `left_control + m` | Change fn + letter to left_control + letter |
| `fn + n` | `left_control + n` | Change fn + letter to left_control + letter |
| `fn + o` | `left_control + o` | Change fn + letter to left_control + letter |
| `fn + p` | `left_control + p` | Change fn + letter to left_control + letter |
| `fn + q` | `left_control + q` | Change fn + letter to left_control + letter |
| `fn + r` | `left_control + r` | Change fn + letter to left_control + letter |
| `fn + s` | `left_control + s` | Change fn + letter to left_control + letter |
| `fn + t` | `left_control + t` | Change fn + letter to left_control + letter |
| `fn + u` | `left_control + u` | Change fn + letter to left_control + letter |
| `fn + v` | `left_control + v` | Change fn + letter to left_control + letter |
| `fn + w` | `left_control + w` | Change fn + letter to left_control + letter |
| `fn + x` | `left_control + x` | Change fn + letter to left_control + letter |
| `fn + y` | `left_control + y` | Change fn + letter to left_control + letter |
| `fn + z` | `left_control + z` | Change fn + letter to left_control + letter |
