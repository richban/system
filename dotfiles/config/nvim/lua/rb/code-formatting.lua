local null_ls = require("null-ls")

local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics
local code_actions = null_ls.builtins.code_actions

null_ls.setup({
  sources = {
    -- Nix
    formatting.alejandra,
    diagnostics.deadnix,
    diagnostics.statix,
    code_actions.statix,
    formatting.prettier,
    formatting.black,
    formatting.isort,
    diagnostics.mypy,
    diagnostics.ruff.with({ extra_args = { "--max-line-length=180" } }),
    formatting.gofmt,
    formatting.shfmt.with({
      extra_args = { "-i=2" },
    }),
    formatting.clang_format,
    formatting.cmake_format,
    formatting.bean_format,
    formatting.fixjson,
    formatting.sqlformat,
    formatting.terrafmt,
    formatting.terraform_fmt,
    formatting.trim_whitespace,
    diagnostics.editorconfig_checker,
    diagnostics.gitlint, -- Shell scripts
    code_actions.shellcheck,
    diagnostics.shellcheck,
    diagnostics.write_good,
    -- formatting.lua_format.with({
    --   extra_args = {
    --     "--no-keep-simple-function-one-line",
    --     "--no-break-after-operator",
    --     "--column-limit=100",
    --     "--break-after-table-lb",
    --     "--indent-width=2",
    --   },
    -- }),
    formatting.codespell.with({ filetypes = { "markdown" } }), -- Markdown
    code_actions.proselint,
    diagnostics.proselint,
    diagnostics.markdownlint,
    -- diagnostics.misspell,
  },
})
