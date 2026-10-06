--[[
LSP keymaps
===========
Buffer-local keymaps that are set when a language server attaches to a buffer.

Entry point: `M.on_attach(client, bufnr)` (called from rb/plugins/lsp.lua).

How to read this file:
  1. Helpers           – small utilities used by the keymap groups
  2. Keymap groups     – one function per topic (navigation, diagnostics, ...)
  3. on_attach         – wires the groups together; read this first for an overview
]]

local M = {}

---------------------------------------------------------------------------
-- 1. Helpers
---------------------------------------------------------------------------

--- Create a `map` function bound to one client + buffer.
---
--- Usage: map(lhs, rhs, desc, opts?)
---   rhs   function, or a string which is run as an Ex command (e.g. "Lspsaga code_action")
---   opts  { mode = "n"|"i"|{...}, expr = bool, method = "textDocument/..." }
---         `method`: only create the mapping if the server supports that LSP method.
---@param client vim.lsp.Client
---@param bufnr integer
---@param prefix string shown in the keymap description, e.g. "LSP" -> "LSP: Rename"
local function make_mapper(client, bufnr, prefix)
  return function(lhs, rhs, desc, opts)
    opts = opts or {}

    if opts.method and not client:supports_method(opts.method, bufnr) then
      return
    end

    if type(rhs) == "string" then
      rhs = "<cmd>" .. rhs .. "<CR>"
    end

    vim.keymap.set(opts.mode or "n", lhs, rhs, {
      buffer = bufnr,
      silent = true,
      expr = opts.expr,
      desc = prefix .. ": " .. desc,
    })
  end
end

--- Open a Snacks picker if snacks.nvim is loaded, otherwise use the built-in LSP function.
---@param snacks_picker string name of the picker, e.g. "lsp_definitions"
---@param fallback function built-in alternative, e.g. vim.lsp.buf.definition
local function picker(snacks_picker, fallback)
  return function()
    if _G.Snacks then
      Snacks.picker[snacks_picker]()
    else
      fallback()
    end
  end
end

--- Jump to the next (count = 1) or previous (count = -1) diagnostic, optionally of one severity.
---@param count integer
---@param severity? "ERROR"|"WARN"|"INFO"|"HINT"
local function jump_diagnostic(count, severity)
  return function()
    vim.diagnostic.jump({
      count = count,
      float = true,
      severity = severity and vim.diagnostic.severity[severity] or nil,
    })
  end
end

--- Rename the symbol under the cursor.
--- Used as an `expr` mapping, so it returns the keys to execute.
--- Preference: inc-rename.nvim > Lspsaga > built-in.
local function rename()
  if pcall(require, "inc_rename") then
    return ":IncRename " .. vim.fn.expand("<cword>")
  end

  -- Lspsaga's rename is much better than the built-in one for project-wide renames
  if pcall(require, "lspsaga") then
    return ":Lspsaga rename<CR>"
  end

  -- Defer to avoid "Not allowed to change text or change window" inside an expr mapping
  vim.defer_fn(vim.lsp.buf.rename, 10)
  return ""
end

local function toggle_signature_help()
  require("lsp_signature").toggle_float_win()
end

local function toggle_virtual_lines()
  local enabled = not vim.diagnostic.config().virtual_lines
  vim.diagnostic.config({ virtual_lines = enabled })
end

local function toggle_virtual_text()
  if vim.diagnostic.config().virtual_text then
    vim.diagnostic.config({ virtual_text = false })
    vim.notify("Virtual text diagnostics disabled")
  else
    vim.diagnostic.config({
      virtual_text = { spacing = 4, prefix = require("rb.icons").diagnostics.BoldInformation },
    })
    vim.notify("Virtual text diagnostics enabled")
  end
end

---------------------------------------------------------------------------
-- 2. Keymap groups
---------------------------------------------------------------------------

--- Jumping to definitions, references, implementations and symbols.
local function navigation(map)
  map("gd", picker("lsp_definitions", vim.lsp.buf.definition), "Goto Definition")
  map("gD", vim.lsp.buf.declaration, "Goto Declaration")
  map("grr", picker("lsp_references", vim.lsp.buf.references), "Find References")
  map("<leader>D", picker("lsp_type_definitions", vim.lsp.buf.type_definition), "Type Definition")

  -- Implementation: `gri` is the Neovim 0.11 default, `gi` kept for muscle memory
  local implementations = picker("lsp_implementations", vim.lsp.buf.implementation)
  map("gri", implementations, "Goto Implementation")
  map("gi", implementations, "Goto Implementation")

  -- Document symbols: `gO` is the Neovim 0.11 default, the others are aliases
  local document_symbols = picker("lsp_symbols", vim.lsp.buf.document_symbol)
  map("gO", document_symbols, "Document Symbols")
  map("<leader>ds", document_symbols, "Document Symbols")
  map("<leader>cs", document_symbols, "Document Symbols")

  map("<leader>ws", picker("lsp_workspace_symbols", vim.lsp.buf.workspace_symbol), "Workspace Symbols")

  -- Call hierarchy
  map("<leader>ci", "Lspsaga incoming_calls", "Incoming Calls")
  map("<leader>co", "Lspsaga outgoing_calls", "Outgoing Calls")
  map("gh", "Lspsaga lsp_finder", "Show Definition & References")
end

--- Hover docs and function signatures.
local function documentation(map)
  map("K", vim.lsp.buf.hover, "Hover Documentation")

  local sig = { method = "textDocument/signatureHelp" }
  map("gK", toggle_signature_help, "Signature Help", sig)
  map("<C-k>", toggle_signature_help, "Signature Help", vim.tbl_extend("force", sig, { mode = "i" }))
  map("<C-s>", toggle_signature_help, "Signature Help", vim.tbl_extend("force", sig, { mode = "i" }))
end

--- Moving between and displaying diagnostics. Convention: `]` = next, `[` = previous.
local function diagnostics(map)
  map("]d", jump_diagnostic(1), "Next Diagnostic")
  map("[d", jump_diagnostic(-1), "Prev Diagnostic")
  map("]e", jump_diagnostic(1, "ERROR"), "Next Error")
  map("[e", jump_diagnostic(-1, "ERROR"), "Prev Error")
  map("]w", jump_diagnostic(1, "WARN"), "Next Warning")
  map("[w", jump_diagnostic(-1, "WARN"), "Prev Warning")

  map("<leader>cd", vim.diagnostic.open_float, "Line Diagnostics")
  map("<leader>cl", vim.diagnostic.setloclist, "Diagnostics to Location List")
  map("<leader>cq", vim.diagnostic.setqflist, "Diagnostics to Quickfix List")

  map("<leader>cw", toggle_virtual_lines, "Toggle Virtual Lines Diagnostics")
  map("<leader>cv", toggle_virtual_text, "Toggle Virtual Text Diagnostics")
end

--- Code actions, rename, code lens.
local function code_actions(map)
  -- `gra` / `grn` are the Neovim 0.11 defaults, `<leader>ca` / `<leader>rn` kept as aliases
  local code_action = { mode = { "n", "v" }, method = "textDocument/codeAction" }
  map("gra", "Lspsaga code_action", "Code Action", code_action)
  map("<leader>ca", "Lspsaga code_action", "Code Action", code_action)

  local rename_opts = { expr = true, method = "textDocument/rename" }
  map("grn", rename, "Rename", rename_opts)
  map("<leader>rn", rename, "Rename", rename_opts)

  map("grx", vim.lsp.codelens.run, "Run Code Lens", { method = "textDocument/codeLens" })
  map("<leader>ch", vim.lsp.buf.document_highlight, "Highlight Symbol")

  -- Formatting is handled by conform.nvim (see rb/plugins/formaters.lua)
end

--- Workspace folders and LSP debugging info.
local function workspace(map)
  map("<leader>wa", vim.lsp.buf.add_workspace_folder, "Workspace Add Folder")
  map("<leader>wr", vim.lsp.buf.remove_workspace_folder, "Workspace Remove Folder")
  map("<leader>wl", function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, "Workspace List Folders")

  map("<leader>li", function()
    print(vim.inspect(vim.lsp.get_clients({ bufnr = 0 })))
  end, "Show Attached Clients")
  map("<leader>ll", function()
    print(vim.lsp.get_log_path())
  end, "Show Log Path")
end

--- TypeScript-only keymaps (tsserver / ts_ls).
local function typescript(map, client)
  map("<leader>to", function()
    client:exec_cmd({
      title = "Organize Imports",
      command = "_typescript.organizeImports",
      arguments = { vim.api.nvim_buf_get_name(0) },
    })
  end, "Organize Imports")

  map("<leader>tc", function()
    vim.lsp.buf.code_action({ context = { only = { "quickfix" } }, apply = true })
  end, "Fix Current")

  map("<leader>ti", function()
    vim.lsp.buf.code_action({ context = { only = { "source.addMissingImports" } }, apply = true })
  end, "Import All")
end

--- Run a conform.nvim formatter; if conform isn't installed, run a shell command instead.
---@param formatter string conform formatter name
---@param shell_cmd string fallback command; the current file path is appended
---@param reload boolean reload the buffer after the shell command (it edits the file on disk)
local function conform_or_shell(formatter, shell_cmd, reload)
  return function()
    local ok, conform = pcall(require, "conform")
    if ok then
      conform.format({ formatters = { formatter }, async = true })
      return
    end
    vim.cmd("silent !" .. shell_cmd .. " " .. vim.fn.shellescape(vim.fn.expand("%")))
    if reload then
      vim.cmd("edit!")
    end
  end
end

--- Find the pytest file for the current buffer (or the buffer itself if it's a test).
---@return string|nil
local function find_python_test_file()
  local file = vim.fn.expand("%")
  local name = vim.fn.fnamemodify(file, ":t:r") -- "foo" for "src/foo.py"
  local dir = vim.fn.fnamemodify(file, ":h")

  if name:match("^test_") or name:match("_test$") then
    return file
  end

  local candidates = {
    dir .. "/test_" .. name .. ".py",
    dir .. "/" .. name .. "_test.py",
    "tests/test_" .. name .. ".py",
  }
  for _, candidate in ipairs(candidates) do
    if vim.fn.filereadable(candidate) == 1 then
      return candidate
    end
  end
  return nil
end

--- Print the active virtualenv, or one found in the project root.
local function show_python_venv()
  local active = os.getenv("VIRTUAL_ENV")
  if active then
    print("Virtual environment (active): " .. active)
    return
  end

  local venv_names = { ".venv", "venv", "env" }
  local root = vim.fs.root(0, venv_names)
  if root then
    for _, name in ipairs(venv_names) do
      local path = root .. "/" .. name
      if vim.fn.isdirectory(path) == 1 then
        print("Virtual environment (detected): " .. path)
        return
      end
    end
  end
  print("No virtual environment active or detected")
end

--- Python-only keymaps (basedpyright / pyright).
local function python(map)
  map("<leader>po", conform_or_shell("ruff_organize_imports", "ruff check --select I --fix", true), "Organize Imports")
  map("<leader>pc", conform_or_shell("ruff_fix", "ruff check --fix", true), "Auto-Fix Errors")
  map("<leader>pf", conform_or_shell("ruff_format", "ruff format", true), "Format Buffer")

  map("<leader>pt", function()
    local test_file = find_python_test_file()
    if test_file then
      vim.cmd("!python -m pytest " .. vim.fn.shellescape(test_file) .. " -v")
    else
      print("No test file found for " .. vim.fn.expand("%"))
    end
  end, "Run Tests")

  map("<leader>pv", show_python_venv, "Show Virtual Env")
end

--- Highlight other occurrences of the symbol under the cursor after a short pause.
local function highlight_references_on_hold(client, bufnr)
  if not client:supports_method("textDocument/documentHighlight", bufnr) then
    return
  end

  -- One group per buffer, so attaching to a new buffer doesn't wipe out the others
  local group = vim.api.nvim_create_augroup("rb_lsp_highlight_" .. bufnr, { clear = true })
  vim.api.nvim_create_autocmd("CursorHold", {
    group = group,
    buffer = bufnr,
    callback = vim.lsp.buf.document_highlight,
  })
  vim.api.nvim_create_autocmd("CursorMoved", {
    group = group,
    buffer = bufnr,
    callback = vim.lsp.buf.clear_references,
  })
end

---------------------------------------------------------------------------
-- 3. on_attach
---------------------------------------------------------------------------

local TYPESCRIPT_SERVERS = { tsserver = true, ts_ls = true }
local PYTHON_SERVERS = { basedpyright = true, pyright = true }

---@param client vim.lsp.Client
---@param bufnr integer
function M.on_attach(client, bufnr)
  local map = make_mapper(client, bufnr, "LSP")

  navigation(map)
  documentation(map)
  diagnostics(map)
  code_actions(map)
  workspace(map)

  if TYPESCRIPT_SERVERS[client.name] then
    typescript(make_mapper(client, bufnr, "TS"), client)
  end

  if PYTHON_SERVERS[client.name] then
    python(make_mapper(client, bufnr, "Python"))
  end

  highlight_references_on_hold(client, bufnr)
end

return M
