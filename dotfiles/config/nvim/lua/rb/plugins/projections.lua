return {
  "gnikdroy/projections.nvim",
  dependencies = {
    "nvim-telescope/telescope.nvim",
  },
  branch = "pre_release",
  config = function()
    require("rb.projections")
  end,
}
