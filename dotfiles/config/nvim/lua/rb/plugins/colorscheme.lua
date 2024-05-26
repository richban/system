local M = {
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 100,
  config = function()
    require("catppuccin").setup({
      flavour = "mocha",
      background = {
        light = "latte",
        dark = "mocha",
      },
    })

    vim.cmd.colorscheme("catppuccin")
  end,
}

return M
