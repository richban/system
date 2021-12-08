local prettier_d = require "rb.lsp.formatters.prettier_d"
local eslint_d = require "rb.lsp.linters.eslint_d"

local prettier = require "rb.lsp.formatters.prettier"

local formatter = prettier
local linter = eslint_d

local M = {}

M.options = {
  cmd = {"diagnostic-languageserver", "--stdio"},
  filetypes = {'javascript', 'javascriptreact', 'javascript.jsx', 'typescript', 'typescriptreact', 'typescript.tsx'},
  init_options = {
    filetypes = {
      javascript = 'eslint',
      javascriptreact = 'eslint',
      ["javascript.jsx"] = 'eslint',
      typescript = 'eslint',
      typescriptreact = 'eslint',
      ["typescript.tsx"] = 'eslint'
    },
    formatFiletypes = {
      javascript = 'prettier',
      javascriptreact = 'prettier',
      ["javascript.jsx"] = 'prettier',
      typescript = 'prettier',
      typescriptreact = 'prettier',
      ["typescript.tsx"] = 'prettier'
    },
    linters = {eslint = linter},
    formatters = {
      -- prettier_standard = prettier_standard,
      prettier = formatter
    }
  }
}

return M
