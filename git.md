# Git in Neovim

A simple, unified reference for Git workflows in Neovim using **Gitsigns**, **Neogit**, **Diffview**, and **Snacks.nvim**.

---

## 🚀 Quick Start / Common Workflows

### 1. Daily Staging & Committing
1. **In buffer**: Jump between changes with `]h` / `[h`.
2. Preview changes with `<leader>hp` or stage individual hunks with `<leader>hs`.
3. Open the Git dashboard: `<leader>gs` (opens **Neogit** in a tab).
4. Stage files/hunks with `s` (or `S` to stage all).
5. Press `c c` to write a commit message (`:wq` to finalize).
6. Press `p p` to push (auto-closes Neogit when push finishes).

### 2. Side-by-Side Diff & Code Review
1. Run `:DiffviewOpen` (or `:DiffviewOpen HEAD~1`, `:DiffviewOpen main...feature`).
2. Navigate modified files in the left panel with `j` / `k` (or `<Tab>` / `<S-Tab>`).
3. Press `s` or `-` to stage/unstage files, or `X` to discard changes.
4. Press `q` to close Diffview.

### 3. Resolving Merge Conflicts
1. In a conflicted repository, run `:DiffviewOpen`.
2. Diffview enters 3-way merge mode automatically (`diff3_horizontal`).
3. Jump between conflicts using `]x` and `[x`.
4. Choose version for the hunk:
   - `<leader>co` -> Keep **OURS** (your branch)
   - `<leader>ct` -> Keep **THEIRS** (incoming branch)
   - `<leader>cb` -> Keep **BASE**
   - `<leader>ca` -> Keep **ALL**
   - `dx` -> Delete conflict marker/region
5. Or choose for the entire file: `<leader>cO` (ours) or `<leader>cT` (theirs).
6. Save the file (`:w`), stage it with `s`, and close with `q`.

### 4. Blame & History
- **Line blame popup**: `<leader>hb` (shows author, commit hash, date, message).
- **Live inline blame**: `<leader>tb` (toggle virtual text at end of line).
- **Full file blame**: `<leader>gB` (opens scroll-bound side-by-side blame split).
- **File history / commits**: `:DiffviewFileHistory %` or `<leader>gf`.

---

## 1. Gitsigns (Buffer & Hunk Editing)

Signs shown in the gutter:
- `│` Added / Modified line
- `_` / `‾` Deleted line
- `~` Changed and deleted line

### Navigation
| Key | Mode | Description |
|---|---|---|
| `]h` | Normal | Jump to next hunk |
| `[h` | Normal | Jump to previous hunk |

### Hunk Staging & Resetting
| Key | Mode | Function | Description |
|---|---|---|---|
| `<leader>hs` | Normal / Visual | `stage_hunk` | Stage hunk (in visual mode: stage only selected lines) |
| `<leader>hr` | Normal / Visual | `reset_hunk` | Revert / reset hunk (in visual mode: revert selection) |
| `<leader>hS` | Normal | `stage_buffer` | Stage entire buffer |
| `<leader>hu` | Normal | `undo_stage_hunk` | Undo last staged hunk |
| `<leader>hR` | Normal | `reset_buffer` | Reset entire buffer back to HEAD |

### Hunk Inspection & Blame
| Key | Mode | Function | Description |
|---|---|---|---|
| `<leader>hp` | Normal | `preview_hunk` | Floating popup preview of the hunk under cursor |
| `<leader>hb` | Normal | `blame_line({ full = true })` | Detailed blame popup for current line |
| `<leader>gB` | Normal | `:Gitsigns blame` | Full-file blame in scroll-bound split window |
| `<leader>hd` | Normal | `diffthis` | Diff current buffer against git index |
| `<leader>hD` | Normal | `diffthis("~")` | Diff current buffer against previous commit (`HEAD~1`) |

### Toggles & Text Objects
| Key | Mode | Function | Description |
|---|---|---|---|
| `<leader>tb` | Normal | `toggle_current_line_blame` | Toggle live inline blame virtual text |
| `<leader>td` | Normal | `toggle_deleted` | Toggle inline display of deleted lines |
| `ih` | Visual / Operator | `select_hunk` | Hunk text object (e.g. `vih` to select, `dih` to delete) |

---

## 2. Neogit (Status & Git Dashboard)

Launch Neogit:
```
<leader>gs    -> :Neogit kind=tab (opens in a dedicated tabpage)
```
*Note: Neogit automatically closes on successful push.*

### Status Buffer Navigation & Staging
| Key | Action | Description |
|---|---|---|
| `j` / `k` | Navigate | Move cursor up / down |
| `<Tab>` | Toggle | Expand / collapse file diff or section |
| `<CR>` | Open | Go to file under cursor |
| `s` | Stage | Stage file, hunk, or visual selection under cursor |
| `u` | Unstage | Unstage file, hunk, or visual selection under cursor |
| `S` | Stage All | Stage all untracked and modified files |
| `U` | Unstage All | Unstage all staged files |
| `x` | Discard | Discard changes (with confirmation prompt) |
| `R` | Refresh | Refresh repository status |
| `$` / `<C-x>` | Command Log | Show Git command execution history |
| `q` | Quit | Close Neogit tab |
| `?` | Help | Show interactive help menu |

### Action Menus (Magit Popups)
Press the menu key, then the action key:

| Menu Key | Popup | Common Sub-commands |
|---|---|---|
| `c` | **Commit** | `c c` Commit staged changes<br>`c a` Amend previous commit<br>`c e` Extend commit (amend without editing message)<br>`c f` Fixup commit |
| `p` | **Push** | `p p` Push to current remote/branch<br>`p u` Push and set upstream<br>`p f` Force push (with lease) |
| `F` | **Pull** | `F p` Pull from remote<br>`F r` Pull with rebase (`--rebase`) |
| `f` | **Fetch** | `f p` Fetch from remote<br>`f a` Fetch all remotes |
| `b` | **Branch** | `b b` Checkout branch<br>`b c` Create and checkout new branch<br>`b d` Delete branch<br>`b r` Rename branch |
| `m` | **Merge** | `m m` Merge branch into current<br>`m a` Abort in-progress merge |
| `r` | **Rebase** | `r r` Rebase onto branch<br>`r i` Interactive rebase<br>`r c` Continue rebase<br>`r a` Abort rebase |
| `z` | **Stash** | `z z` Stash both staged and unstaged<br>`z p` Pop stash<br>`z a` Apply stash<br>`z d` Drop stash |
| `d` | **Diff** | Open diff menu (integrated with Diffview) |
| `l` | **Log** | `l l` Log HEAD<br>`l a` Log all branches |

---

## 3. Diffview (Diffs, Merge Tool & History)

### Commands
- `:DiffviewOpen` - Open side-by-side diff of current unstaged/staged changes.
- `:DiffviewOpen [rev]` - Diff against revision (e.g. `:DiffviewOpen HEAD~1`, `:DiffviewOpen main`).
- `:DiffviewClose` - Close Diffview (or press `q`).
- `:DiffviewFileHistory [path]` - Open commit history (e.g. `:DiffviewFileHistory %` for current file).
- `:DiffviewToggleFiles` - Toggle file list panel (`<leader>b`).
- `:DiffviewFocusFiles` - Focus file list panel (`<leader>e`).

---

### In File Panel (Left Panel)
| Key | Action | Description |
|---|---|---|
| `j` / `k` (or `<down>` / `<up>`) | Navigate | Next / previous file |
| `<CR>` / `o` / `l` | Select | Open diff for file |
| `s` / `-` | Toggle Stage | Stage / unstage file |
| `S` | Stage All | Stage all files |
| `U` | Unstage All | Unstage all files |
| `X` | Restore | Restore/discard file changes |
| `L` | Commit Log | Open commit log panel |
| `i` | Listing Style | Toggle between `tree` and `list` view |
| `f` | Flatten | Toggle flattening empty directories in tree |
| `zo` / `zc` / `za` | Folds | Expand / Collapse / Toggle folder |
| `zR` / `zM` | All Folds | Expand all / Collapse all folders |
| `R` | Refresh | Refresh file list |
| `<Tab>` / `<S-Tab>` | Cycle Diffs | Jump to next / previous file diff |
| `[F` / `]F` | First / Last | Jump to first / last file diff |
| `gf` | Go to File | Open file in previous tabpage |
| `<C-w><C-f>` / `<C-w>gf` | Open File | Open in split / new tab |
| `g<C-x>` | Cycle Layout | Switch between diff layouts |
| `q` | Quit | Close Diffview |
| `g?` | Help | Open help panel |

---

### In Diff Editor Buffers
| Key | Action | Description |
|---|---|---|
| `<Tab>` / `<S-Tab>` | Cycle Files | Open diff for next / previous file |
| `[F` / `]F` | First / Last | Open diff for first / last file |
| `gf` | Edit | Jump to file in previous tabpage |
| `<leader>e` | Focus Panel | Focus file panel |
| `<leader>b` | Toggle Panel | Toggle file panel |
| `g<C-x>` | Layout | Cycle layouts |
| `q` | Quit | Close Diffview |
| `g?` | Help | Open help panel |

---

### 3-Way Merge Tool & Conflict Resolution
When opening Diffview during a merge or rebase conflict:

#### Per-Conflict Hunk Operations (in diff buffer):
| Key | Action | Description |
|---|---|---|
| `]x` / `[x` | Jump Conflict | Jump to next / previous conflict |
| `<leader>co` | Choose Ours | Select **OURS** version for current conflict |
| `<leader>ct` | Choose Theirs | Select **THEIRS** version for current conflict |
| `<leader>cb` | Choose Base | Select **BASE** version for current conflict |
| `<leader>ca` | Choose All | Keep all versions of conflict |
| `dx` | Delete Region | Delete conflict region entirely |
| `2do` | Diffget Ours | Obtain hunk from OURS version |
| `3do` | Diffget Theirs | Obtain hunk from THEIRS version |

#### Whole-File Conflict Operations (in buffer or file panel):
| Key | Action | Description |
|---|---|---|
| `<leader>cO` | Choose Ours (All) | Select **OURS** version for the entire file |
| `<leader>cT` | Choose Theirs (All) | Select **THEIRS** version for the entire file |
| `<leader>cB` | Choose Base (All) | Select **BASE** version for the entire file |
| `<leader>cA` | Choose All (All) | Keep all versions for the entire file |
| `dX` | Delete Conflict (All) | Delete conflict regions for the entire file |

---

### In File History Panel (`:DiffviewFileHistory`)
| Key | Action | Description |
|---|---|---|
| `j` / `k` | Navigate | Next / previous commit |
| `<CR>` / `o` / `l` | Select | View diff for selected commit |
| `<C-A-d>` | Diffview | Open commit in full Diffview |
| `y` | Copy Hash | Copy commit hash to clipboard |
| `L` | Commit Details | Open commit log details |
| `X` | Restore | Revert file back to state at this commit |
| `g!` | Options | Open history options panel |
| `q` | Quit | Close history view |
| `g?` | Help | Open help panel |

---

## 4. Snacks.nvim Git Pickers

Fuzzy-search Git resources across the workspace with Snacks:

| Key | Picker | Description |
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

## 💡 Summary Cheat Sheet

| Task | Shortcut / Command |
|---|---|
| **Open Git Dashboard** | `<leader>gs` |
| **Inspect / Stage Diff Side-by-Side** | `:DiffviewOpen` (navigate with `j`/`k`, stage with `s`, quit with `q`) |
| **Resolve Merge Conflicts** | `:DiffviewOpen` -> `]x` / `[x` -> `<leader>co` (ours) or `<leader>ct` (theirs) |
| **Jump Hunks in Code** | `]h` (next) / `[h` (prev) |
| **Stage Current Hunk** | `<leader>hs` |
| **Preview Current Hunk** | `<leader>hp` |
| **Revert Current Hunk** | `<leader>hr` |
| **Blame Current Line** | `<leader>hb` |
| **Full File Blame** | `<leader>gB` |
| **File Commit History** | `:DiffviewFileHistory %` |
| **Switch Branches** | `<leader>gb` |
| **Search Commit Log** | `<leader>gl` |
