return {
  {
    "baliestri/aura-theme",
    lazy = false,
    priority = 1000,
    config = function(plugin)
      vim.opt.rtp:append(plugin.dir .. "/packages/neovim")
      -- vim.cmd.colorscheme("aura-dark")

      -- vim.defer_fn(function()
      --   vim.api.nvim_set_hl(0, "DiffAdd", { fg = "#5a9d7a", bg = "#15141b", reverse = true })
      --   vim.api.nvim_set_hl(0, "DiffDelete", { fg = "#a75757", bg = "#15141b", reverse = true })
      -- end, 50)
    end,
  },
  {
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

      -- vim.cmd.colorscheme("catppuccin")
    end,
  },
  {
    "dguo/blood-moon",
    priority = 100,
    build = function()
      vim.opt.rtp:append(vim.fn.stdpath("data") .. "/lazy/blood-moon/applications/vim")
    end,
    config = function()
      -- Add the vim subdirectory to runtime path
      vim.opt.rtp:append(vim.fn.stdpath("data") .. "/lazy/blood-moon/applications/vim")
      -- Uncomment the line below to use blood-moon instead of catppuccin
      -- vim.cmd.colorscheme("blood-moon")
    end,
  },
  {
    "projekt0n/github-nvim-theme",
    name = "github-theme",
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      require("github-theme").setup({
        -- ...
      })

      -- vim.cmd("colorscheme github_dark_tritanopia")
    end,
  },
  {
    "nyoom-engineering/oxocarbon.nvim",
    config = function()
      vim.opt.background = "dark" -- set this to dark or light
      vim.cmd("colorscheme oxocarbon")
    end,
  },
}
