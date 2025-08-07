-- Python-specific settings
vim.opt_local.colorcolumn = "88"
vim.opt_local.textwidth = 88
vim.opt_local.expandtab = true
vim.opt_local.tabstop = 4
vim.opt_local.shiftwidth = 4
vim.opt_local.softtabstop = 4

-- Python-specific keymaps
local keymap = vim.keymap.set
local opts = { buffer = true, silent = true }

-- Run current Python file
keymap("n", "<leader>pe", ":!python %<CR>", vim.tbl_extend("force", opts, { desc = "Run Python file" }))

-- Interactive Python REPL
keymap("n", "<leader>pi", ":!python -i %<CR>", vim.tbl_extend("force", opts, { desc = "Python interactive" }))

-- Add common Python snippets shortcuts
keymap(
  "n",
  "<leader>pdb",
  "iimport pdb; pdb.set_trace()<Esc>",
  vim.tbl_extend("force", opts, { desc = "Add pdb breakpoint" })
)
keymap(
  "n",
  "<leader>pprint",
  "iimport pprint; pprint.pprint()<Esc>hi",
  vim.tbl_extend("force", opts, { desc = "Add pprint" })
)

-- Set up better folding for Python classes and functions
vim.opt_local.foldmethod = "indent"
vim.opt_local.foldlevel = 99

-- Better concealing for Python
vim.opt_local.conceallevel = 0
