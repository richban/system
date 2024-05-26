return {
  {
    "lewis6991/gitsigns.nvim",
    lazy = true,
    tag = "v0.8.0",
    event = { "BufReadPost" },
    config = function()
      require("rb.gitsigns")
    end,
  },
}
