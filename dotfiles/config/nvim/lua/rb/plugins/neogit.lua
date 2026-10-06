-- neogit.lua
local M = {
  "NeogitOrg/neogit",
  cmd = "Neogit",
  keys = {
    { "<leader>gs", "<cmd>Neogit kind=tab<CR>", desc = "Neogit" },
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
    "sindrets/diffview.nvim",
  },
  config = function()
    require("neogit").setup({
      integrations = {
        diffview = true,
      },
    })

    local group = vim.api.nvim_create_augroup("mnv_neogit_events", { clear = true })

    vim.api.nvim_create_autocmd("User", {
      pattern = "NeogitPushComplete",
      group = group,
      callback = function()
        require("neogit").close()
      end,
    })
  end,
}

return M
