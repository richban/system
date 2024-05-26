-- neogit.lua
local M = {
  "TimUntersberger/neogit",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "sindrets/diffview.nvim",
  },
  config = function()
    require("neogit").setup({
      disable_commit_confirmation = true,
      integrations = {
        diffview = true,
      },
    })
    vim.api.nvim_set_keymap("n", "<leader>gs", "<cmd>Neogit kind=tab<CR>", { noremap = true, silent = true })
  end,
}

return M
