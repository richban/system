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
    lazy = false,
    priority = 1000,
    config = function()
      require("catppuccin").setup({
        flavour = "mocha",
        background = {
          light = "latte",
          dark = "mocha",
        },
        custom_highlights = function(colors)
          return {
            Normal = { bg = "#000000" },
            NormalNC = { bg = "#000000" },
            NormalFloat = { bg = "#000000" },
            FloatBorder = { bg = "#000000" },
            TelescopeNormal = { bg = "#000000" },
            TelescopeBorder = { bg = "#000000" },
            SignColumn = { bg = "#000000" },

            -- Git Plugins (Neogit & Diffview)
            NeogitNormal = { bg = "#000000" },
            NeogitPopupNormal = { bg = "#000000" },
            DiffviewNormal = { bg = "#000000" },
            DiffviewStatusNormal = { bg = "#000000" },
            DiffviewFilePanelTitle = { bg = "#000000" },

            -- 1. The "Unchanged Context"
            -- Removes the huge grey boxes behind unchanged code around diffs
            NeogitDiffContext = { bg = "#000000" }, -- unfocused
            NeogitDiffContextHighlight = { bg = "#000000" }, -- focused

            -- 2. The Hunk Headers
            -- Makes the "@@ -23,7 +23,7 @@" lines float nicely with pure black
            NeogitHunkHeader = { bg = "#000000" },
            NeogitHunkHeaderHighlight = { bg = "#000000" },

            -- 3. The Added Code (Green lines)
            -- Commented out so you keep Catppuccin's default dark green backgrounds!
            -- NeogitDiffAdd = { bg = "#000000" },
            -- NeogitDiffAddHighlight = { bg = "#000000" },
            -- DiffAdd = { bg = "#000000" },

            -- 4. The Deleted Code (Red lines)
            -- Commented out so you keep Catppuccin's default dark red backgrounds!
            -- NeogitDiffDelete = { bg = "#000000" },
            -- NeogitDiffDeleteHighlight = { bg = "#000000" },
            -- DiffDelete = { bg = "#000000" },

            -- DiffChange = { bg = "#000000" },
            -- DiffText = { bg = "#000000" },
          }
        end,
        integrations = {
          -- Completion
          cmp = true,

          -- Git
          gitsigns = true,
          diffview = true,
          neogit = true,

          -- File tree / navigation
          nvimtree = true,
          telescope = { enabled = true },

          -- UI chrome
          notify = true,
          lualine = true,
          bufferline = true,
          fidget = true,
          lspsaga = true,

          -- Editing / motion
          treesitter = true,
          indent_blankline = {
            enabled = true,
            colored_indent_levels = false, -- v2 tag: no coloured levels
          },
          mini = { enabled = true, indentscope_color = "" },
          neoscroll = true,

          -- Diagnostics / debugging
          lsp_trouble = true,
          dap = true,
          dap_ui = true,
          todo_comments = true,

          -- Disabled (plugins not active)
          alpha = false,
          barbar = false,
          beacon = false,
          blink_cmp = false,
          colorful_winsep = { enabled = false, color = "red" },
          dashboard = false,
          noice = false,
          neotest = false,
          navic = { enabled = false },
          overseer = false,
          aerial = false,
        },
      })

      vim.cmd.colorscheme("catppuccin")
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

      -- vim.cmd("colorscheme github_dark_default")
    end,
  },
  {
    "nyoom-engineering/oxocarbon.nvim",
    config = function()
      vim.opt.background = "dark" -- set this to dark or light
      -- vim.cmd("colorscheme oxocarbon")
    end,
  },
}
