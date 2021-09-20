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


-- Normal configuration to show diagnostic messages
-- vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
--   vim.lsp.diagnostic.on_publish_diagnostics, {
--     virtual_text = {
--       spacing = 0,
--       prefix = "■",
--       severity_limit = "Warning",
--     },

--     -- see: ":help vim.lsp.diagnostic.set_signs()"
--     signs = true,

--     update_in_insert = true,
--   }
-- )

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  require('lsp_extensions.workspace.diagnostic').handler, {
    -- see: ":help vim.lsp.diagnostic.set_signs()"
    signs = true,
    virtual_text = {
      spacing = 0,
      prefix = "■",
      severity_limit = "Warning",
    },
  }
)

vim.lsp.handlers["textDocument/hover"] = require('lspsaga.hover').handler

-- Override various utility functions.
-- vim.lsp.diagnostic.show_line_diagnostics = require('lspsaga.diagnostic').show_line_diagnostics

local ns_rename = vim.api.nvim_create_namespace "tj_rename"

function MyLspRename()
  local bufnr = vim.api.nvim_get_current_buf()
  vim.api.nvim_buf_clear_namespace(bufnr, ns_rename, 0, -1)

  local current_word = vim.fn.expand "<cword>"

  local plenary_window = require("plenary.window.float").percentage_range_window(0.5, 0.2)
  vim.api.nvim_buf_set_option(plenary_window.bufnr, "buftype", "prompt")
  vim.fn.prompt_setprompt(plenary_window.bufnr, string.format('Rename "%s" to > ', current_word))
  vim.fn.prompt_setcallback(plenary_window.bufnr, function(text)
    vim.api.nvim_win_close(plenary_window.win_id, true)

    if text ~= "" then
      vim.schedule(function()
        vim.api.nvim_buf_delete(plenary_window.bufnr, { force = true })

        vim.lsp.buf.rename(text)
      end)
    else
      print "Nothing to rename!"
    end
  end)

  vim.cmd [[startinsert]]
end
