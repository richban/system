return {
  {
    "baliestri/aura-theme",
    lazy = false,
    priority = 1000,
    config = function(plugin)
      vim.opt.rtp:append(plugin.dir .. "/packages/neovim")
      vim.cmd.colorscheme("aura-dark")

      -- Fix NeoGit colors using actual Aura theme palette
      vim.defer_fn(function()
        -- Aura theme colors with muted diff colors for better readability
        local aura = {
          purple = "#a277ff",
          green = "#4a9d7a", -- Muted green for diff additions
          orange = "#ffca85",
          red = "#c75757", -- Muted red for diff deletions
          pink = "#f694ff",
          white = "#edecee",
          gray = "#6d6d6d",
          black = "#15141b",
          blue = "#82e2ff",
        }

        -- Core diff colors (matching Aura theme's DiffAdd, DiffChange, etc.)
        vim.api.nvim_set_hl(0, "DiffAdd", { fg = aura.green, bg = aura.black, reverse = true })
        vim.api.nvim_set_hl(0, "DiffChange", { fg = aura.blue, bg = aura.black, reverse = true })
        vim.api.nvim_set_hl(0, "DiffDelete", { fg = aura.red, bg = aura.black, reverse = true })
        vim.api.nvim_set_hl(0, "DiffText", { fg = aura.orange, bg = aura.black, reverse = true })

        -- NeoGit diff highlights using Aura colors
        vim.api.nvim_set_hl(0, "NeogitDiffAdd", { fg = aura.green })
        vim.api.nvim_set_hl(0, "NeogitDiffDelete", { fg = aura.red })
        vim.api.nvim_set_hl(0, "NeogitDiffContext", { fg = aura.white })
        vim.api.nvim_set_hl(0, "NeogitDiffContextHighlight", { fg = aura.white, bg = aura.black })
        vim.api.nvim_set_hl(0, "NeogitDiffAddHighlight", { fg = aura.green, bg = aura.black, reverse = true })
        vim.api.nvim_set_hl(0, "NeogitDiffDeleteHighlight", { fg = aura.red, bg = aura.black, reverse = true })
        vim.api.nvim_set_hl(0, "NeogitHunkHeader", { fg = aura.orange, bg = aura.black, bold = true })
        vim.api.nvim_set_hl(
          0,
          "NeogitHunkHeaderHighlight",
          { fg = aura.orange, bg = aura.black, bold = true, reverse = true }
        )

        -- NeoGit status highlights using Aura colors
        vim.api.nvim_set_hl(0, "NeogitBranch", { fg = aura.pink, bold = true })
        vim.api.nvim_set_hl(0, "NeogitRemote", { fg = aura.blue })
        vim.api.nvim_set_hl(0, "NeogitUnstagedchanges", { fg = aura.orange })
        vim.api.nvim_set_hl(0, "NeogitStagedchanges", { fg = aura.green })
        vim.api.nvim_set_hl(0, "NeogitUntrackedfiles", { fg = aura.red })
        vim.api.nvim_set_hl(0, "NeogitUnpushedTo", { fg = aura.blue })
        vim.api.nvim_set_hl(0, "NeogitUnmergedInto", { fg = aura.red })
        vim.api.nvim_set_hl(0, "NeogitRecentcommits", { fg = aura.purple })

        -- File status colors using Aura palette
        vim.api.nvim_set_hl(0, "NeogitChangeModified", { fg = aura.orange })
        vim.api.nvim_set_hl(0, "NeogitChangeAdded", { fg = aura.green })
        vim.api.nvim_set_hl(0, "NeogitChangeDeleted", { fg = aura.red })
        vim.api.nvim_set_hl(0, "NeogitChangeRenamed", { fg = aura.blue })
        vim.api.nvim_set_hl(0, "NeogitChangeUpdated", { fg = aura.pink })
        vim.api.nvim_set_hl(0, "NeogitChangeCopied", { fg = aura.blue })
        vim.api.nvim_set_hl(0, "NeogitChangeBothModified", { fg = aura.orange })
        vim.api.nvim_set_hl(0, "NeogitChangeNewFile", { fg = aura.green })
      end, 100)
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
  x,
}
