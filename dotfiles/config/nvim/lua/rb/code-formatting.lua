local null_ls = require("null-ls")

local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics
local code_actions = null_ls.builtins.code_actions

null_ls.setup({
  sources = {
    -- Nix
    diagnostics.deadnix,
    diagnostics.statix,
    code_actions.statix,
    formatting.prettier,
    formatting.black,
    formatting.gofmt,
    formatting.shfmt,
    formatting.clang_format,
    formatting.cmake_format,
    formatting.bean_format,
    formatting.fixjson,
    formatting.sqlformat,
    formatting.terrafmt,
    formatting.terraform_fmt,
    formatting.trim_whitespace,
    diagnostics.editorconfig_checker,
    diagnostics.gitlint,
    -- Shell scripts
    code_actions.shellcheck,
    diagnostics.shellcheck,
    diagnostics.write_good,
    formatting.lua_format.with({
      extra_args = {
        "--no-keep-simple-function-one-line",
        "--no-break-after-operator",
        "--column-limit=100",
        "--break-after-table-lb",
        "--indent-width=2",
      },
    }),
    formatting.isort,
    formatting.codespell.with({ filetypes = { "markdown" } }),
    -- Markdown
    code_actions.proselint,
    diagnostics.proselint,
    diagnostics.markdownlint,
    diagnostics.misspell,
  },
  on_attach = function(client)
    if client.resolved_capabilities.document_formatting then
      vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()")
    end

    if client.resolved_capabilities.document_highlight then
      vim.cmd([[
        augroup document_highlight
          autocmd! * <buffer>
          autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
          autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
        augroup END
      ]])
    end
  end,
})
