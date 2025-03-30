local M = {}

local icons = require("rb.icons")

function M.lsp_init()
  -- LSP handlers configuration
  local config = {
    diagnostic = {
      virtual_text = {
        spacing = 4,
        prefix = icons.diagnostics.BoldInformation,
      },
      signs = {
        text = {
          [vim.diagnostic.severity.ERROR] = icons.diagnostics.Error,
          [vim.diagnostic.severity.WARN] = icons.diagnostics.Warn,
          [vim.diagnostic.severity.INFO] = icons.diagnostics.Info,
          [vim.diagnostic.severity.HINT] = icons.diagnostics.Hint,
        },
        numhl = {
          [vim.diagnostic.severity.ERROR] = "DiagnosticSignError",
          [vim.diagnostic.severity.WARN] = "DiagnosticSignWarn",
          [vim.diagnostic.severity.INFO] = "DiagnosticSignInfo",
          [vim.diagnostic.severity.HINT] = "DiagnosticSignHint",
        },
        priority = 8,
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
    },
  }

  -- Apply diagnostic configuration
  vim.diagnostic.config(config.diagnostic)

  -- Hover configuration with float options
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
