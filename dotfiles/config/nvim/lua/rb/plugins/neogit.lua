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
      disable_commit_confirmation = true,
      integrations = {
        diffview = true,
      },
    })

    local function augroup(name)
      return vim.api.nvim_create_augroup("mnv_" .. name, { clear = true })
    end

    local group = vim.api.nvim_create_augroup("MyCustomNeogitEvents", { clear = true })

    vim.api.nvim_create_autocmd("User", {
      pattern = "NeogitPushComplete",
      group = group,
      callback = function()
        require("neogit").close()
      end,
    })

    vim.api.nvim_create_autocmd({ "BufWritePost", "BufEnter", "FocusGained", "ShellCmdPost", "VimResume" }, {
      group = augroup("DefaultRefreshEvents"),
      callback = function()
        require("neogit").refresh_manually()
      end,
    })
  end,
}

return M
