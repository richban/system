local null_ls = require("null-ls")

local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics
local code_actions = null_ls.builtins.code_actions

null_ls.setup({
  sources = {
    --  formatting
    formatting.alejandra,
    formatting.prettier,
    formatting.black.with({ extra_args = { "--fast" } }),
    formatting.isort,
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
    formatting.codespell.with({ filetypes = { "markdown" } }), -- Markdown
    -- formatting.lua_format.with({
    --   extra_args = {
    --     "--no-keep-simple-function-one-line",
    --     "--no-break-after-operator",
    --     "--column-limit=100",
    --     "--break-after-table-lb",
    --     "--indent-width=2",
    --   },
    -- }),

    -- diagnostics
    diagnostics.deadnix,
    diagnostics.statix,
    diagnostics.mypy,
    diagnostics.ruff.with({ extra_args = { "--max-line-length=180" } }),
    diagnostics.editorconfig_checker,
    diagnostics.gitlint,
    diagnostics.write_good,
    diagnostics.shellcheck,
    diagnostics.proselint,
    diagnostics.markdownlint,
    -- diagnostics.misspell,

    -- code actions
    code_actions.statix,
    code_actions.shellcheck,
    code_actions.proselint,
    code_actions.gitsigns,
    code_actions.gitrebase,
  },
})
