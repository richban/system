return {
  {
    "nvim-tree/nvim-tree.lua",
    cmd = { "NvimTreeToggle", "NvimTreeRefresh", "NvimTreeFindFile", "NvimTreeOpen" },
    keys = {
      { "<leader>b", "<cmd>NvimTreeToggle<CR>", desc = "Toggle NvimTree" },
      { "<leader>br", "<cmd>NvimTreeRefresh<CR>", desc = "Refresh NvimTree" },
    },
    config = function()
      require("nvim-tree").setup()
    end,
  },
}
