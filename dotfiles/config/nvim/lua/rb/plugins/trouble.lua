return {
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    lazy = true,
    opts = {},
    keys = {
      {
        "<leader>xx",
        mode = "n",
        "<cmd>Trouble diagnostics toggle<cr>",
        desc = "Diagnostics (Trouble)",
      },
      {
        "<leader>xw",
        mode = "n",
        "<cmd>Trouble diagnostics toggle<cr>",
        desc = "Workspace Diagnostics (Trouble)",
      },
      {
        "<leader>xd",
        mode = "n",
        "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
        desc = "Buffer Diagnostics (Trouble)",
      },
      {
        "<leader>xl",
        mode = "n",
        "<cmd>Trouble loclist toggle<cr>",
        desc = "Location List (Trouble)",
      },
      {
        "<leader>xq",
        mode = "n",
        "<cmd>Trouble qflist toggle<cr>",
        desc = "Quickfix List (Trouble)",
      },
      {
        "<leader>xR",
        mode = "n",
        "<cmd>Trouble lsp toggle focus=false<cr>",
        desc = "LSP References (Trouble)",
      },
    },
  },
}
