local protocol = require "vim.lsp.protocol"

vim.lsp.handlers["textDocument/definition"] = function(_, _, result)
  if not result or vim.tbl_isempty(result) then
    print "[LSP] Could not find definition"
    return
  end

  if vim.tbl_islist(result) then
    vim.lsp.util.jump_to_location(result[1])
  else
    vim.lsp.util.jump_to_location(result)
  end
end

-- vim.lsp.handlers["textDocument/definition"] = vim.lsp.with(
--   vim.lsp.handlers.location, {
--     location_callback = function(location)
--       vim.cmd [[vsplit]]
--       vim.lsp.util.jump_to_location(location)
--     end
--   }
-- )

vim.g.diagnostics_active = true

function _G.toggle_diagnostics()
  if vim.g.diagnostics_active then
    vim.g.diagnostics_active = false
    vim.lsp.diagnostic.clear(0)
    vim.lsp.handlers["textDocument/publishDiagnostics"] = function()
    end
  else
    vim.g.diagnostics_active = true
    vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
      virtual_text = true,
      signs = true,
      underline = true,
      update_in_insert = false
    })
  end
end

vim.api.nvim_set_keymap('n', '<leader>tt', ':call v:lua.toggle_diagnostics()<CR>', {noremap = true, silent = true})

-- Normal configuration to show diagnostic messages
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
  virtual_text = {spacing = 0, prefix = "■", severity_limit = "Warning"},
  -- see: ":help vim.lsp.diagnostic.set_signs()"
  signs = true,
  update_in_insert = true
})

vim.lsp.handlers["textDocument/hover"] = require('lspsaga.hover').handler

-- Override various utility functions.
-- vim.lsp.diagnostic.show_line_diagnostics = require('lspsaga.diagnostic').show_line_diagnostics
