-- neogen.lua
local M = {
  "danymat/neogen",
  keys = {
    {
      "<Leader>nc",
      function()
        require("neogen").generate({ type = "class" })
      end,
      desc = "Generate class annotation",
    },
    {
      "<Leader>nf",
      function()
        require("neogen").generate()
      end,
      desc = "Generate function annotation",
    },
  },
  config = function()
    require("neogen").setup({
      enabled = true,
      languages = {
        lua = {
          template = {
            annotation_convention = "emmylua",
          },
        },
      },
    })
  end,
}

return M
