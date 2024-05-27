return {
  {
    "lukas-reineke/indent-blankline.nvim",
    tag = "v2.20.8",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      space_char_blankline = " ",
      show_current_context = true,
      show_current_context_start = true,
      show_end_of_line = true,
      use_treesitter = true,
      enabled = true,
      buftype_exclude = { "terminal", "help", "telescope", "NvimTree", "Startify", "dashboard", "packer" },
      filetype_exclude = { "NvimTree", "Startify", "dashboard" },
      context_patterns = {
        "class",
        "return",
        "function",
        "method",
        "^if",
        "^while",
        "jsx_element",
        "^for",
        "^object",
        "^table",
        "block",
        "arguments",
        "if_statement",
        "else_clause",
        "jsx_element",
        "jsx_self_closing_element",
        "try_statement",
        "catch_clause",
        "import_statement",
        "operation_type",
      },
    },
  },
}
