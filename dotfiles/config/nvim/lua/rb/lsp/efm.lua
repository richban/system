-- TODO: https://github.com/mattn/efm-langserver do we need this?
local lsp = require('lspconfig')

local luaformat = require "rb.lsp.formatters.luafmt"
local prettier_d = require "rb.lsp.formatters.prettier_d"
local eslint_d = require "rb.lsp.linters.eslint_d"

local formatter = prettier_d
local linter = eslint_d

local languages = {
  lua = {luaformat},
  typescript = {formatter, linter},
  javascript = {formatter, linter},
  typescriptreact = {formatter, linter},
  ['typescript.tsx'] = {formatter, linter},
  javascriptreact = {formatter, linter},
  ['javascript.jsx'] = {formatter, linter},
  vue = {formatter, linter},
  yaml = {formatter},
  json = {formatter},
  html = {formatter},
  scss = {formatter},
  css = {formatter},
  markdown = {formatter}
}

return function()
  return {
    root_dir = function(fname)
      local cwd = lsp.util.root_pattern("tsconfig.json")(fname) or lsp.util.root_pattern(".eslintrc.json", ".git")(fname)
                      or lsp.util.root_pattern("package.json", ".git/", ".zshrc")(fname);
      return cwd
    end,
    filetypes = vim.tbl_keys(languages),
    init_options = {documentFormatting = true},
    settings = {rootMarkers = {"package.json", ".git"}, lintDebounce = 500, languages = languages}
  }
end
