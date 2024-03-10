local M = {}

local telescope_mapper = require("rb.telescope.mappings")

function M.on_attach(client, buffer)
  local self = M.new(client, buffer)
  local opts = { noremap = true, silent = true }

  local map = function(keys, func, desc)
    vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
  end

  -- Jump to the definition of the word under your cursor.
  --  This is where a variable was first declared, or where a function is defined, etc.
  --  To jump back, press <C-T>.
  self:map("gd", "Telescope lsp_definitions", { desc = "Goto Definition" })
  --  For example, in C this would take you to the header
  map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
  -- Find references for the word under your cursor.
  self:map("gr", "Telescope lsp_references", { desc = "References" })
  -- Jump to the implementation of the word under your cursor.
  --  Useful when your language has ways of declaring types without an actual implementation.
  map("gI", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")
  -- self:map("gb", "Telescope lsp_type_definitions", { desc = "Goto Type Definition" })
  -- Jump to the type of the word under your cursor.
  --  Useful when you're not sure what type a variable is and you want to see
  --  the definition of its *type*, not where it was *defined*.
  map("<leader>D", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")
  -- Opens a popup that displays documentation about the word under your cursor
  --  See `:help K` for why this keymap
  -- self:map("K", "Lspsaga hover_doc", { desc = "Hover" })
  map("K", vim.lsp.buf.hover, "Hover Documentation")
  self:map("gK", vim.lsp.buf.signature_help, { desc = "Signature Help", has = "signatureHelp" })

  -- Fuzzy find all the symbols in your current document.
  --  Symbols are things like variables, functions, types, etc.
  map("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")

  -- Fuzzy find all the symbols in your current workspace
  --  Similar to document symbols, except searches over your whole project.
  map("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")

  self:map("[d", M.diagnostic_goto(true), { desc = "Next Diagnostic" })
  self:map("]d", M.diagnostic_goto(false), { desc = "Prev Diagnostic" })
  self:map("]e", M.diagnostic_goto(true, "ERROR"), { desc = "Next Error" })
  self:map("[e", M.diagnostic_goto(false, "ERROR"), { desc = "Prev Error" })
  self:map("]w", M.diagnostic_goto(true, "WARNING"), { desc = "Next Warning" })
  self:map("[w", M.diagnostic_goto(false, "WARNING"), { desc = "Prev Warning" })

  -- Execute a code action, usually your cursor needs to be on top of an error
  -- or a suggestion from your LSP for this to activate.
  map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
  self:map("<leader>ca", "Lspsaga code_action", { desc = "Code Action", mode = { "n", "v" }, has = "codeAction" })

  -- Rename the variable under your cursor
  --  Most Language Servers support renaming across files, etc.
  map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
  -- self:map("<leader>cr", M.rename, { expr = true, desc = "Rename", has = "rename" })

  self:map("<leader>cw", require("rb.lsp.utils").toggle_diagnostics, { desc = "Toggle Inline Diagnostics" })

  -- gives definition & references
  vim.api.nvim_set_keymap("n", "gh", "<cmd>Lspsaga lsp_finder<CR>", opts)
  vim.api.nvim_set_keymap("n", "<leader>lc", ":lua print(vim.inspect(vim.lsp.get_active_clients()))<CR>", opts)
  vim.api.nvim_set_keymap("n", "<leader>lp", ":lua print(vim.lsp.get_log_path())<CR>", opts)

  -- Typescript
  vim.api.nvim_set_keymap("n", "<leader>to", ":TSLspOrganize<CR>", opts)
  vim.api.nvim_set_keymap("n", "<leader>tc", ":TSLspFixCurrent<CR>", opts)
  -- vim.api.nvim_set_keymap("n", "gr", ":TSLspRenameFile<CR>", 'lsp', 'lsp_', '')
  vim.api.nvim_set_keymap("n", "<leader>ti", ":TSLspImportAll<CR>", opts)
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
