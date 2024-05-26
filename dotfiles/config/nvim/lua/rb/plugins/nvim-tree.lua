return {
  {
    "nvim-tree/nvim-tree.lua",
    config = function()
      local key_map = vim.api.nvim_set_keymap
      -- following options are the default
      -- each of these are documented in `:help nvim-tree.OPTION_NAME`
      require("nvim-tree").setup()

      key_map("n", "<leader>b", ":NvimTreeToggle<CR>", { noremap = true, silent = true })
      key_map("n", "<leader>br", ":NvimTreeRefresh<CR>", { noremap = true, silent = false })
    end,
  },
}
