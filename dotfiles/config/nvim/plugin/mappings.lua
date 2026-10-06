-- General keymaps.
-- NOTE: `vim.keymap.set` is non-recursive by default (no need for `noremap = true`).
-- Use `remap = true` when the rhs must trigger another mapping (`noremap = false` is ignored).
-- NOTE: plugin keymaps declared via lazy.nvim `keys = {}` are registered before this file is
-- sourced, so anything defined here would silently override them. Check before adding new keys.
local key_map = vim.keymap.set

-- ── Terminal / insert ───────────────────────────────────────────────────────

-- <Esc> in a :terminal buffer leaves terminal-insert mode (back to Normal mode).
-- Caveat: TUI apps running in the terminal (fzf, lazygit, nested nvim) never see <Esc>.
key_map("t", "<Esc>", [[<C-\><C-n>]], { desc = "Exit terminal mode" })

-- Make <C-c> behave exactly like <Esc> in Insert mode (plain <C-c> skips InsertLeave
-- autocmds and abbreviations).
key_map("i", "<C-c>", "<Esc>", { silent = true, desc = "Escape" })

-- ── Editing ─────────────────────────────────────────────────────────────────

-- Visual mode: move the selected lines down (J) / up (K) and re-indent (`=`), keeping the
-- selection (`gv`) so you can press J/K repeatedly.
key_map("x", "J", ":m '>+1<CR>gv=gv", { silent = true, desc = "Move selection down" })
key_map("x", "K", ":m '<-2<CR>gv=gv", { silent = true, desc = "Move selection up" })

-- Replace the word under the cursor with the last yank, without clobbering the register:
-- `viw` selects the inner word, visual `P` replaces it and keeps the register intact.
key_map("n", ",r", "viwP", { desc = "Replace word with last yank" })

-- Paste over a visual selection WITHOUT yanking the replaced text (keeps the register, so you
-- can paste the same text repeatedly). Visual `P` does exactly that natively.
key_map("x", "p", "P", { desc = "Paste without yanking selection" })

-- ── Windows ─────────────────────────────────────────────────────────────────

-- Arrow keys jump between split windows (instead of moving the cursor).
key_map("n", "<Up>", "<C-w><Up>", { desc = "Window up" })
key_map("n", "<Down>", "<C-w><Down>", { desc = "Window down" })
key_map("n", "<Left>", "<C-w><Left>", { desc = "Window left" })
key_map("n", "<Right>", "<C-w><Right>", { desc = "Window right" })

-- Resize the current split by 10 columns/rows.
key_map("n", "<leader>>", "<cmd>vertical resize +10<CR>", { desc = "Wider split" })
key_map("n", "<leader><", "<cmd>vertical resize -10<CR>", { desc = "Narrower split" })
key_map("n", "<leader>+", "<cmd>resize +10<CR>", { desc = "Taller split" })
key_map("n", "<leader>-", "<cmd>resize -10<CR>", { desc = "Shorter split" })

-- ── Quickfix / quitting ─────────────────────────────────────────────────────

key_map("n", "<leader>qo", "<cmd>copen<CR>", { desc = "Open quickfix list" })
key_map("n", "<leader>qc", "<cmd>cclose<CR>", { desc = "Close quickfix list" })

-- (Use the built-in `ZQ` to quit the current window discarding changes.)
key_map("n", "<leader>Q", "<cmd>qall!<CR>", { desc = "Quit all, discard changes" })
key_map("n", "<leader>W", "<cmd>wqall<CR>", { desc = "Write all and quit" })

-- ── Git ─────────────────────────────────────────────────────────────────────

-- Full-file git blame in a scroll-bound split (via gitsigns).
key_map("n", "<leader>gB", "<cmd>Gitsigns blame<CR>", { desc = "Git blame (full file)" })

-- ── Yank with file path ─────────────────────────────────────────────────────
-- Copy the visual selection prefixed with its file path (handy for pasting into chats/issues).

local yank = require("rb.yank")
key_map("x", "<leader>ya", function()
  yank.yank_visual_with_path(yank.get_buffer_absolute(), "absolute")
end, { desc = "[Y]ank selection with [A]bsolute path" })

key_map("x", "<leader>yr", function()
  yank.yank_visual_with_path(yank.get_buffer_cwd_relative(), "relative")
end, { desc = "[Y]ank selection with [R]elative path" })
