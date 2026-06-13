return {
  {
    "stevearc/oil.nvim",
    cmd = "Oil",
    keys = {
      { "-", "<CMD>Oil<CR>", desc = "Open parent directory" },
      {
        "<space>-",
        function()
          require("oil").toggle_float()
        end,
        desc = "Open parent directory in floating window",
      },
    },
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("oil").setup({
        columns = { "icon" },
        keymaps = {
          ["<C-h>"] = false,
          ["<M-h>"] = "actions.select_split",
        },
        view_options = {
          show_hidden = true,
        },
      })
    end,
  },
}
