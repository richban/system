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
        enabled = true,
        show_start = true,
        show_end = false,
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
