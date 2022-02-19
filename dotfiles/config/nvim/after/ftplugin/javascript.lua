-- typescript-language-server: 0.9.1
vim.opt_local.linebreak = true
vim.opt_local.colorcolumn = "81"
vim.opt_local.spell = false

-- treesitter Folding
vim.opt_local.foldmethod = "expr"
vim.opt_local.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt_local.foldnestmax = 3
vim.opt_local.foldlevel = 1

vim.b.vsnip_snippet_dir = vim.fn.expand "~/.config/nvim/snippets/javascript/"

-- Setup cmp source buffer configuration
local cmp = require "cmp"
cmp.setup.buffer {
  sources = {
    { name = "nvim_lsp" },
    { name = "treesitter" },
    { name = "vsnip" },
    {
      name = "buffer",
      option = {
        get_bufnrs = function()
          return vim.api.nvim_list_bufs()
        end,
      },
    },
    { name = "path" },
  },
}

