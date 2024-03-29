local key_map = vim.keymap.set

vim.cmd([[tnoremap <Esc> <C-\><C-n> ]])
key_map("i", "<C-c>", "<ESC>", { noremap = true, silent = true })
-- Join yanked text on a yank (needed for terminal mode copies)
key_map(
  "v",
  "yy",
  "y<CR>:let @\"=substitute(@\", '\\n', '', 'g')<CR>:call yank#Osc52Yank()<CR>",
  { noremap = true, silent = true }
)
-- Move selected lines
key_map("v", "J", ":m '>+1<CR>gv=gv", { noremap = true, silent = true })
key_map("v", "K", ":m '<-2<CR>gv=gv", { noremap = true, silent = true })
-- Toggle Paste mode
key_map("n", "<leader>p", ":set paste!<CR>", { noremap = true, silent = true })
-- Window navigation
key_map("", "<C-J>", "<C-W><C-J>", { noremap = true, silent = true })
key_map("", "<C-K>", "<C-W><C-K>", { noremap = true, silent = true })
key_map("", "<C-L>", "<C-W><C-L>", { noremap = true, silent = true })
key_map("", "<C-H>", "<C-W><C-H>", { noremap = true, silent = true })
-- Adjusting splits
key_map("n", "<silent> <leader>>", ":vertical resize +10<CR>", { noremap = true, silent = true })
key_map("n", "<silent> <leader><", ":vertical resize -10<CR>", { noremap = true, silent = true })
key_map("n", "<silent> <leader>+", ":resize +10<CR>", { noremap = true, silent = true })
key_map("n", "<silent> <leader>-", ":resize -10<CR>", { noremap = true, silent = true })
-- Change directory to current directory
key_map("n", "<leader>cd", ":cd %:p:h<CR>:pwd<CR>", { noremap = true, silent = true })

-- map <leader>ghw :h <C-R>=expand("<cword>")<CR><CR>
-- map <leader>pw :Rg <C-R>=expand("<cword>")<CR><CR>

-- this should be a default
key_map("n", "<C-^>", ":b#<CR>", { noremap = true, silent = true })

-- use ZQ for :q! (quit & discard changes)
-- Discard all changed buffers & quit
key_map("n", "<Leader>Q", ":qall!<CR>", { noremap = true, silent = true })
-- write all and quit
key_map("n", "<Leader>W", ":wqall<CR>", { noremap = true, silent = true })

key_map("n", "<space>t", ":TSHighlightCapturesUnderCursor<CR>", { noremap = true, silent = true })

-- open quickfix / close
key_map("n", "<leader>co", ":cope<cr>", { noremap = false, silent = true })
key_map("n", "<leader>cl", ":cclose<cr>", { noremap = false, silent = true })

-- Surround word under cursor w/ backticks (required vim-surround)
key_map("n", "<leader>`", "ysiW`", { noremap = false })
-- REPLACE: delete inner word & replace with last yanked (including system)
key_map("n", ",r", '"_diwhp', { noremap = true })

-- Move between Windows
key_map("n", "<up>", "<C-w><up>", { noremap = false })
key_map("n", "<down>", "<C-w><down>", { noremap = false })
key_map("n", "<left>", "<C-w><left>", { noremap = false })
key_map("n", "<right>", "<C-w><right>", { noremap = false })

-- Replace word under cursor in Buffer (case-sensitive
key_map("n", "<leader>sr", ":%s/<C-R><C-W>//gI<left><left><left>", { noremap = false })
-- Replace word under cursor on Line (case-sensitive)
key_map("n", "<leader>sl", ":s/<C-R><C-W>//gI<left><left><left>", { noremap = false })

key_map(
  "n",
  "F",
  "<cmd>lua require'hop'.hint_words({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true })<cr>",
  {}
)
-- key_map('n', 'F', "<cmd>lua require'hop'.hint_words({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true })<cr>", {})
key_map(
  "n",
  "T",
  "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true, hint_offset = -1 })<cr>",
  {}
)
-- key_map('n', 'T', "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true, hint_offset = 1 })<cr>", {})

-- Auto indent
-- key_map("n", "i", function()
--   if #vim.fn.getline(".") == 0 then
--     return [["_cc]]
--   else
--     return "i"
--   end
-- end, { expr = true })

-- Paste over currently selected text without yanking it
key_map("v", "p", '"_dP')

vim.api.nvim_set_keymap("n", "<leader>gd", "<cmd>Gvdiffsplit<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>gb", "<cmd>Git blame<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>gh", "<cmd>0Gclog!<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>gj", "<cmd>diffget //2<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>gk", "<cmd>diffget //3<CR>", { noremap = true, silent = true })
