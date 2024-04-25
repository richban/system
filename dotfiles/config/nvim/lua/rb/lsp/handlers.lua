local M = {}

local icons = require("rb.icons")

function M.lsp_init()
  local signs = {
    { name = "DiagnosticSignError", text = icons.diagnostics.Error },
    { name = "DiagnosticSignWarn", text = icons.diagnostics.Warning },
    { name = "DiagnosticSignHint", text = icons.diagnostics.Hint },
    { name = "DiagnosticSignInfo", text = icons.diagnostics.Info },
  }
  for _, sign in ipairs(signs) do
    vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = sign.name })
  end

  -- LSP handlers configuration
  local config = {
    float = {
      focusable = true,
      style = "minimal",
      border = "rounded",
    },

    diagnostic = {
      -- virtual_text = false,
      virtual_text = { spacing = 4, prefix = "●" },
      -- virtual_text = {
      --   severity = {
      --     min = vim.diagnostic.severity.ERROR,
      --   },
      -- },
      signs = {
        active = signs,
      },
      underline = false,
      update_in_insert = false,
      severity_sort = true,
      float = {
        focusable = true,
        style = "minimal",
        border = "rounded",
        source = "always",
        header = "",
        prefix = "",
      },
      -- virtual_lines = true,
    },
  }
  -- Override various utility functions.
  -- vim.lsp.diagnostic.show_line_diagnostics = require("lspsaga.diagnostic").show_line_diagnostics

  -- Diagnostic configuration
  vim.diagnostic.config(config.diagnostic)

  -- Hover configuration
  -- vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, config.float)
  vim.lsp.handlers["textDocument/hover"] = require("lspsaga.hover").handler

  -- Signature help configuration
  -- vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, config.float)

  -- Jump directly to the first available definition every time.
  -- vim.lsp.handlers["textDocument/definition"] = function(_, result)
  --   if not result or vim.tbl_isempty(result) then
  --     print("[LSP] Could not find definition")
  --     return
  --   end
  --
  --   if vim.tbl_islist(result) then
  --     vim.lsp.util.jump_to_location(result[1], "utf-8")
  --   else
  --     vim.lsp.util.jump_to_location(result, "utf-8")
  --   end
  -- end
end

return M
