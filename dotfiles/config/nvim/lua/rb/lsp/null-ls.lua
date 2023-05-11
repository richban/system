local M = {}

local null_ls = require("null-ls")
local nls_utils = require("null-ls.utils")

local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics
local code_actions = null_ls.builtins.code_actions

local with_diagnostics_code = function(builtin)
  return builtin.with({
    diagnostics_format = "#{m} [#{c}]",
  })
end

local with_root_file = function(builtin, file)
  return builtin.with({
    condition = function(utils)
      return utils.root_has_file(file)
    end,
  })
end

local sources = {
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
  -- with_root_file(formatting.stylua, "stylua.toml"),

  -- diagnostics
  diagnostics.deadnix,
  diagnostics.statix,
  diagnostics.mypy,
  diagnostics.ruff.with({ extra_args = { "--max-line-length=180" } }),
  diagnostics.editorconfig_checker,
  diagnostics.gitlint,
  diagnostics.write_good,
  with_diagnostics_code(diagnostics.shellcheck),
  diagnostics.proselint,
  diagnostics.markdownlint,
  -- diagnostics.misspell,

  -- code actions
  code_actions.statix,
  code_actions.shellcheck,
  code_actions.proselint,
  code_actions.gitsigns,
  code_actions.gitrebase,
}

function M.setup(opts)
  null_ls.setup({
    -- debug = true,
    debounce = 150,
    save_after_format = false,
    sources = sources,
    on_attach = opts.on_attach,
    root_dir = nls_utils.root_pattern(".git"),
  })
end

return M
