local M = {}

function M.on_attach(client, buffer)
  local self = M.new(client, buffer)
  local opts = { noremap = true, silent = true }

  local map = function(keys, func, desc)
    vim.keymap.set("n", keys, func, { buffer = buffer, desc = "LSP: " .. desc })
  end

  --[[ Navigation
  Key mappings for code navigation and jumping between symbols:
  gd - Jump to definition of symbol under cursor
  gD - Jump to declaration (useful in header files)
  gr - Find all references of symbol under cursor
  gI - Jump to implementation (useful for interfaces)
  <leader>D - Jump to type definition
  --]]
  self:map("gd", "Telescope lsp_definitions", { desc = "Goto Definition" })
  map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
  self:map("gr", "Telescope lsp_references", { desc = "Find References" })
  map("gI", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")
  map("<leader>D", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")

  --[[ Documentation
  Key mappings for viewing documentation and signatures:
  K - Show hover documentation for symbol under cursor
  gK - Show signature help (useful when writing function calls)
  --]]
  map("K", vim.lsp.buf.hover, "Hover Documentation")
  self:map("gK", vim.lsp.buf.signature_help, { desc = "Signature Help", has = "signatureHelp" })

  --[[ Symbols
  Key mappings for symbol search and navigation:
  <leader>ds - List all symbols in current document
  <leader>ws - List all symbols in current workspace/project
  --]]
  map("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
  map("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")

  self:map("[d", M.diagnostic_goto(true), { desc = "Next Diagnostic" })
  self:map("]d", M.diagnostic_goto(false), { desc = "Prev Diagnostic" })
  self:map("]e", M.diagnostic_goto(true, "ERROR"), { desc = "Next Error" })
  self:map("[e", M.diagnostic_goto(false, "ERROR"), { desc = "Prev Error" })
  self:map("]w", M.diagnostic_goto(true, "WARNING"), { desc = "Next Warning" })
  self:map("[w", M.diagnostic_goto(false, "WARNING"), { desc = "Prev Warning" })

  --[[ Code Actions
  Key mappings for code modifications and refactoring:
  <leader>ca - Show available code actions (fixes, refactorings)
  <leader>rn - Rename symbol under cursor (uses inc_rename if available)
  <leader>cw - Toggle inline diagnostic messages
  --]]
  self:map("<leader>ca", "Lspsaga code_action", { desc = "Code Action", mode = { "n", "v" }, has = "codeAction" })
  self:map("<leader>rn", M.rename, { expr = true, desc = "Rename", has = "rename" })
  self:map("<leader>cw", require("rb.lsp.utils").toggle_diagnostics, { desc = "Toggle Inline Diagnostics" })

  --[[ LSP Information
  Key mappings for LSP debugging and information:
  gh - Show definition and references in Lspsaga
  <leader>li - Show active LSP client information
  <leader>ll - Show LSP log file path
  --]]
  vim.keymap.set("n", "gh", "<cmd>Lspsaga lsp_finder<CR>", { buffer = buffer, desc = "LSP: Show Definition & References" })
  vim.keymap.set("n", "<leader>li", ":lua print(vim.inspect(vim.lsp.get_active_clients()))<CR>", { buffer = buffer, desc = "LSP: Show Info" })
  vim.keymap.set("n", "<leader>ll", ":lua print(vim.lsp.get_log_path())<CR>", { buffer = buffer, desc = "LSP: Show Log Path" })

  --[[ TypeScript Specific
  Key mappings only active in TypeScript files:
  <leader>to - Organize imports automatically
  <leader>tc - Fix current code issue
  <leader>ti - Import all missing imports
  --]]
  if client.name == "tsserver" then
    vim.keymap.set("n", "<leader>to", ":TSLspOrganize<CR>", { buffer = buffer, desc = "TS: Organize Imports" })
    vim.keymap.set("n", "<leader>tc", ":TSLspFixCurrent<CR>", { buffer = buffer, desc = "TS: Fix Current" })
    vim.keymap.set("n", "<leader>ti", ":TSLspImportAll<CR>", { buffer = buffer, desc = "TS: Import All" })
  end
end

function M.new(client, buffer)
  return setmetatable({ client = client, buffer = buffer }, { __index = M })
end

function M:has(cap)
  return self.client.server_capabilities[cap .. "Provider"]
end

function M:map(lhs, rhs, opts)
  opts = opts or {}
  if opts.has and not self:has(opts.has) then
    return
  end
  vim.keymap.set(
    opts.mode or "n",
    lhs,
    type(rhs) == "string" and ("<cmd>%s<cr>"):format(rhs) or rhs,
    ---@diagnostic disable-next-line: no-unknown
    { silent = true, buffer = self.buffer, expr = opts.expr, desc = opts.desc }
  )
end

function M.rename()
  if pcall(require, "inc_rename") then
    return ":IncRename " .. vim.fn.expand("<cword>")
  else
    vim.lsp.buf.rename()
  end
end

function M.diagnostic_goto(next, severity)
  local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
  severity = severity and vim.diagnostic.severity[severity] or nil
  return function()
    go({ severity = severity })
  end
end

return M
