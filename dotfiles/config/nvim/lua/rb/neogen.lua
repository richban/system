-- neogen.lua
local M = {
  "danymat/neogen",
  config = function()
    require("neogen").setup({
      enabled = true,
      languages = {
        lua = {
          template = {
            annotation_convention = "emmylua",
          },
        },
      },
    })
    local opts = { noremap = true, silent = true }
    vim.api.nvim_set_keymap("n", "<Leader>nc", ":lua require('neogen').generate({ type = 'class' })<CR>", opts)
    vim.api.nvim_set_keymap("n", "<Leader>nf", ":lua require('neogen').generate()<CR>", opts)
  end,
}

return M
