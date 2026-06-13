return {
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      indent = {
        char = "▏",
      },
      scope = {
        enabled = false, -- Disable active scope highlighting & underlining completely
      },
      exclude = {
        buftypes = { "terminal", "nofile", "quickfix", "prompt" },
        filetypes = {
          "NvimTree",
          "Startify",
          "dashboard",
          "help",
          "telescope",
          "lazy",
          "mason",
          "notify",
          "toggleterm",
        },
      },
    },
  },
}
