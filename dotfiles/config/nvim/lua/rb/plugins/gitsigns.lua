return {
  {
    "lewis6991/gitsigns.nvim",
    lazy = true,
    event = { "BufReadPost" },
    cmd = { "Gitsigns" },
    config = function()
      require("rb.gitsigns")
    end,
  },
}
