vim.g.diagnostics_active = true

function _G.toggle_diagnostics()
  if vim.g.diagnostics_active then
    vim.g.diagnostics_active = false
    vim.lsp.diagnostic.clear(0)
    vim.lsp.handlers["textDocument/publishDiagnostics"] = function() end
  else
    vim.g.diagnostics_active = true
    vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
      virtual_text = true,
      signs = true,
      underline = true,
      update_in_insert = false,
    })
  end
end

vim.api.nvim_set_keymap("n", "<leader>tt", ":call v:lua.toggle_diagnostics()<CR>", { noremap = true, silent = true })

-- LSP Enable diagnostics
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
  -- virtual_text = false,
  virtual_text = { spacing = 0, prefix = "■", severity_limit = "Warning" },
  underline = true,
  signs = true,
  update_in_insert = true,
  severity_sort = true,
})

vim.lsp.handlers["textDocument/hover"] = require("lspsaga.hover").handler
-- Override various utility functions.
vim.lsp.diagnostic.show_line_diagnostics = require("lspsaga.diagnostic").show_line_diagnostics
