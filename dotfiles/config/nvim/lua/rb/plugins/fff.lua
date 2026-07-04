return {
  {
    "dmtrKovalenko/fff.nvim",
    build = function()
      require("fff.download").download_or_build_binary()
    end,
    opts = {
      debug = {
        enabled = false,
        show_scores = true,
      },
    },
    lazy = false,
    keys = {
      {
        "<leader>ff",
        function()
          require("fff").find_files()
        end,
        desc = "FFF Find Files",
      },
      {
        "<leader>fg",
        function()
          require("fff").live_grep()
        end,
        desc = "FFF Live Grep",
      },
      {
        "<leader>fz",
        function()
          require("fff").live_grep({ grep = { modes = { "fuzzy", "plain" } } })
        end,
        desc = "FFF Fuzzy Grep",
      },
      {
        "<leader>fc",
        function()
          require("fff").live_grep({ query = vim.fn.expand("<cword>") })
        end,
        desc = "FFF Search Word Under Cursor",
      },
    },
  },
}
