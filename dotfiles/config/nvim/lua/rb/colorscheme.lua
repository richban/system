-- rose-pine.lua
local M = {
  "rose-pine/neovim",
  config = function()
    require("rose-pine").setup({
      dark_variant = "main",
      bold_vert_split = false,
      dim_nc_background = false,
      disable_background = false,
      disable_float_background = false,
      disable_italics = false,

      groups = {
        background = "base",
        panel = "surface",
        border = "highlight_med",
        comment = "muted",
        link = "iris",
        punctuation = "subtle",

        error = "love",
        hint = "iris",
        info = "foam",
        warn = "gold",

        headings = {
          h1 = "iris",
          h2 = "foam",
          h3 = "rose",
          h4 = "gold",
          h5 = "pine",
          h6 = "foam",
        },
        -- or set all headings at once
        -- headings = 'subtle'
      },

      -- Change specific vim highlight groups
      highlight_groups = {
        ColorColumn = { bg = "highlight_low" },
      },
    })

    vim.cmd("colorscheme rose-pine")
  end,
}

return M
