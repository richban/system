return {
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    keys = {
      { "<leader>tg", mode = { "n", "i" }, desc = "Toggle completion ghost text" },
    },
    dependencies = {
      "onsails/lspkind.nvim",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-buffer",
      {
        "L3MON4D3/LuaSnip",
        dependencies = { "rafamadriz/friendly-snippets" },
        build = "make install_jsregexp",
      },
      "saadparwaiz1/cmp_luasnip",
      "windwp/nvim-autopairs",
    },
    config = function()
      require("rb.nvim-cmp")
    end,
  },
}
