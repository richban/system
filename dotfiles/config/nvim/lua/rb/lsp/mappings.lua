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
  grr - Find all references of symbol under cursor (0.11 default)
  gri - Jump to implementation (0.11 default)
  <leader>D - Jump to type definition
  --]]
  self:map("gd", "Telescope lsp_definitions", { desc = "Goto Definition" })
  map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
  self:map("grr", "Telescope lsp_references", { desc = "Find References" })
  map("gri", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")
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
  gO - List all symbols in current document (0.11 default)
  <leader>ds - List all symbols in current document (kept for compatibility)
  <leader>ws - List all symbols in current workspace/project
  --]]
  map("gO", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
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
  gra - Show available code actions (0.11 default)
  grn - Rename symbol under cursor (0.11 default)
  <leader>ca - Show available code actions (kept for compatibility)
  <leader>rn - Rename symbol under cursor (kept for compatibility)
  <leader>cw - Toggle virtual lines diagnostics
  <leader>cv - Toggle virtual text diagnostics
  --]]
  self:map("gra", "Lspsaga code_action", { desc = "Code Action", mode = { "n", "v" }, has = "codeAction" })
  self:map("grn", M.rename, { expr = true, desc = "Rename", has = "rename" })
  self:map("<leader>ca", "Lspsaga code_action", { desc = "Code Action", mode = { "n", "v" }, has = "codeAction" })
  self:map("<leader>rn", M.rename, { expr = true, desc = "Rename", has = "rename" })
  self:map("<leader>cw", function()
    local new_config = not vim.diagnostic.config().virtual_lines
    vim.diagnostic.config({ virtual_lines = new_config })
  end, { desc = "Toggle Virtual Lines Diagnostics" })
  self:map("<leader>cv", function()
    local current_config = vim.diagnostic.config()
    if current_config.virtual_text then
      vim.diagnostic.config({ virtual_text = false })
      print("Virtual text diagnostics disabled")
    else
      vim.diagnostic.config({
        virtual_text = {
          spacing = 4,
          prefix = require("rb.icons").diagnostics.BoldInformation,
        },
      })
      print("Virtual text diagnostics enabled")
    end
  end, { desc = "Toggle Virtual Text Diagnostics" })

  --[[ LSP Information
  Key mappings for LSP debugging and information:
  gh - Show definition and references in Lspsaga
  <leader>li - Show active LSP client information
  <leader>ll - Show LSP log file path
  --]]
  vim.keymap.set(
    "n",
    "gh",
    "<cmd>Lspsaga lsp_finder<CR>",
    { buffer = buffer, desc = "LSP: Show Definition & References" }
  )
  vim.keymap.set(
    "n",
    "<leader>li",
    ":lua print(vim.inspect(vim.lsp.get_clients()))<CR>",
    { buffer = buffer, desc = "LSP: Show Info" }
  )
  vim.keymap.set(
    "n",
    "<leader>ll",
    ":lua print(vim.lsp.get_log_path())<CR>",
    { buffer = buffer, desc = "LSP: Show Log Path" }
  )

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

  --[[ Python Specific
  Key mappings only active in Python files:
  <leader>po - Organize imports with ruff
  <leader>pc - Run ruff check on current file
  <leader>pf - Run ruff format on current file
  <leader>pt - Run tests for current file
  <leader>pv - Show virtual environment info
  --]]
  if client.name == "pylsp" then
    vim.keymap.set("n", "<leader>po", function()
      vim.cmd("silent !ruff check --select I --fix " .. vim.fn.expand("%"))
      vim.cmd("edit!")
    end, { buffer = buffer, desc = "Python: Organize Imports" })

    vim.keymap.set("n", "<leader>pc", function()
      vim.cmd("!ruff check " .. vim.fn.expand("%"))
    end, { buffer = buffer, desc = "Python: Check with Ruff" })

    vim.keymap.set("n", "<leader>pf", function()
      vim.cmd("silent !ruff format " .. vim.fn.expand("%"))
      vim.cmd("edit!")
    end, { buffer = buffer, desc = "Python: Format with Ruff" })

    vim.keymap.set("n", "<leader>pt", function()
      local file = vim.fn.expand("%")
      if file:match("test_.*%.py$") or file:match(".*_test%.py$") then
        vim.cmd("!python -m pytest " .. file .. " -v")
      else
        local test_file = file:gsub("%.py$", "_test.py"):gsub("^(.*/)", "%1test_")
        if vim.fn.filereadable(test_file) == 1 then
          vim.cmd("!python -m pytest " .. test_file .. " -v")
        else
          print("No test file found for " .. file)
        end
      end
    end, { buffer = buffer, desc = "Python: Run Tests" })

    vim.keymap.set("n", "<leader>pv", function()
      local venv = os.getenv("VIRTUAL_ENV")
      if venv then
        print("Virtual environment: " .. venv)
      else
        print("No virtual environment active")
      end
    end, { buffer = buffer, desc = "Python: Show Virtual Env" })
  end

  --[[ Formatting
  Key mappings for code formatting:
  <leader>cf - Format current buffer
  <leader>cF - Format selected region (visual mode)
  --]]
  -- self:map("<leader>cf", function()
  --   vim.lsp.buf.format({ async = true })
  -- end, { desc = "Format Document", has = "documentFormatting" })
  -- self:map("<leader>cF", function()
  --   vim.lsp.buf.format({ async = true })
  -- end, { desc = "Format Range", mode = "v", has = "documentRangeFormatting" })

  --[[ Workspace
  Key mappings for workspace management:
  <leader>wa - Add folder to workspace
  <leader>wr - Remove folder from workspace
  <leader>wl - List workspace folders
  --]]
  self:map("<leader>wa", vim.lsp.buf.add_workspace_folder, { desc = "Workspace Add Folder" })
  self:map("<leader>wr", vim.lsp.buf.remove_workspace_folder, { desc = "Workspace Remove Folder" })
  self:map("<leader>wl", function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, { desc = "Workspace List Folders" })

  --[[ Diagnostics
  Additional diagnostic mappings:
  <leader>cd - Open diagnostic float
  <leader>cl - Show diagnostics in line
  <leader>cq - Add diagnostic to quickfix
  --]]
  self:map("<leader>cd", vim.diagnostic.open_float, { desc = "Line Diagnostics" })
  self:map("<leader>cl", vim.diagnostic.setloclist, { desc = "Location List" })
  self:map("<leader>cq", vim.diagnostic.setqflist, { desc = "Quickfix List" })

  --[[ Code Navigation
  Additional code navigation mappings:
  gi - Go to implementation (kept for muscle memory)
  <leader>ci - Show incoming calls
  <leader>co - Show outgoing calls
  --]]
  self:map("gi", "Telescope lsp_implementations", { desc = "Goto Implementation" })
  self:map("<leader>ci", "Lspsaga incoming_calls", { desc = "Incoming Calls" })
  self:map("<leader>co", "Lspsaga outgoing_calls", { desc = "Outgoing Calls" })

  --[[ Code Lens
  Code lens actions:
  <leader>cl - Run code lens action
  --]]
  self:map("<leader>cl", vim.lsp.codelens.run, { desc = "Code Lens", has = "codeLens" })

  --[[ Additional Features
  Enhanced code interaction:
  <leader>ch - Highlight symbol occurrences
  <leader>cs - Document structure
  --]]
  self:map("<leader>ch", vim.lsp.buf.document_highlight, { desc = "Highlight Symbol" })
  self:map("<leader>cs", "Telescope lsp_document_symbols", { desc = "Document Symbols" })

  -- Auto highlight references when cursor holds
  if client.server_capabilities.documentHighlightProvider then
    vim.api.nvim_create_augroup("lsp_document_highlight", { clear = true })
    vim.api.nvim_create_autocmd("CursorHold", {
      group = "lsp_document_highlight",
      buffer = buffer,
      callback = vim.lsp.buf.document_highlight,
    })
    vim.api.nvim_create_autocmd("CursorMoved", {
      group = "lsp_document_highlight",
      buffer = buffer,
      callback = vim.lsp.buf.clear_references,
    })
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
    -- Use defer_fn to avoid the "Not allowed to change text or change window" error
    vim.defer_fn(function()
      vim.lsp.buf.rename()
    end, 10)
    return ""
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
