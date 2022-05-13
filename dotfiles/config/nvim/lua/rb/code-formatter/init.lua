-- require'format'.setup {
--   html = {{cmd = {"prettier -w"}}},
--   css = {{cmd = {"prettier -w"}}},
--   json = {{cmd = {"prettier -w"}}},
--   yaml = {{cmd = {"prettier -w"}}},
--   javascript = {{cmd = {"prettier -w", "./node_modules/.bin/eslint --fix"}}},
--   javascriptreact = {{cmd = {"prettier -w", "./node_modules/.bin/eslint --fix"}}},
--   typescript = {{cmd = {"prettier -w", "./node_modules/.bin/eslint --fix"}}},
--   typescriptreact = {{cmd = {"prettier -w", "./node_modules/.bin/eslint --fix"}}},
--   lua = {
--     {
--       cmd = {
--         function(file)
--           return string.format(
--                      'lua-format -i --no-keep-simple-function-one-line --no-break-after-operator --column-limit=150 --break-after-table-lb --indent-width=2 %s',
--                      file)
--         end
--       }
--     }
--   },
--   python = {
--     {
--       cmd = {
--         function(file)
--           return string.format('black --quiet %s', file)
--         end
--       }
--     }
--   },
--   go = {
--     {
--       cmd = {
--         function(file)
--           return string.format("gofmt -w %s", file)
--         end
--       },
--       tempfile_postfix = ".tmp"
--     }
--   },
--   ruby = {
--     {
--       cmd = {
--         function(file)
--           return string.format("rufo %s", file)
--         end
--       },
--       tempfile_postfix = ".tmp"
--     }
--   },
--   vue = {
--     {
--       cmd = {
--         function(file)
--           return string.format("vue-beautify %s", file)
--         end
--       },
--       tempfile_postfix = ".tmp"
--     }
--   },
--   php = {
--     {
--       cmd = {
--         function(file)
--           return string.format("php-formatter formatter:use:sort --quiet %s", file)
--         end
--       },
--       tempfile_postfix = ".tmp"
--     }
--   },
--   markdown = {{cmd = {"prettier -w"}}, {cmd = {"black"}, start_pattern = "^```python$", end_pattern = "^```$", target = "current"}}
-- }
-- vim.cmd('autocmd BufWritePost * FormatWrite')
local null_ls = require("null-ls")

local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics

null_ls.setup({
	sources = {
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
		diagnostics.markdownlint,
		diagnostics.misspell,
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
