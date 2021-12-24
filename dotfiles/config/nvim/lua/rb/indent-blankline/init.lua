-- vim.g.indentLine_char = '▏'
-- vim.g.indentLine_color_gui = '#474747'
-- vim.g.indentLine_enabled = 1
-- vim.g.indentLine_setConceal = 0

-- vim.g.vim_json_syntax_conceal = 0
-- vim.g.vim_markdown_conceal = 0
-- vim.g.vim_markdown_conceal_code_blocks = 0

-- Simple
-- vim.opt.list = true
-- vim.opt.listchars = {
--     eol = "↴",
-- }

-- require("indent_blankline").setup {
--     show_end_of_line = true,
-- }

-- With context indent highlighted by treesitter
vim.opt.list = true
vim.opt.listchars = {space = "⋅", eol = "↴", trail = ""}

require("indent_blankline").setup {
  space_char_blankline = " ",
  show_end_of_line = true,
  show_current_context = true,
  show_current_context_start = true,
  use_treesitter = true,
  enabled = true,
  buftype_exclude = {"terminal", "help", "telescope", "NvimTree", "Startify", "dashboard"},
  filetype_exclude = {"NvimTree", "Startify", "dashboard"},
  context_patterns = {
    "class", "return", "function", "method", "^if", "^while", "jsx_element", "^for", "^object", "^table", "block", "arguments", "if_statement",
    "else_clause", "jsx_element", "jsx_self_closing_element", "try_statement", "catch_clause", "import_statement", "operation_type"
  }
}