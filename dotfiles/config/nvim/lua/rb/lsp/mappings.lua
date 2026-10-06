--[[
LSP keymaps
===========
Buffer-local keymaps configured when a language server attaches.

General LSP pickers (definitions, references, implementations, type definitions,
symbols, calls, workspace diagnostics) are delegated to `snacks.nvim`.

This file only handles buffer-local LSP operations:
  - Hover & Signature help
  - Diagnostics navigation (jump next/prev & line float)
  - Code actions, Rename & Code Lens
  - Language-specific workflows (TypeScript & Python)
]]

local M = {}

---------------------------------------------------------------------------
-- Helpers
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

--- Jump to next/prev diagnostic.
---@param count integer 1 for next, -1 for prev
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
  if pcall(require, "lspsaga") then
    return ":Lspsaga rename<CR>"
  end
  vim.defer_fn(vim.lsp.buf.rename, 10)
  return ""
end

---------------------------------------------------------------------------
-- Keymap Groups
---------------------------------------------------------------------------

--- Hover documentation & signature help
local function documentation(map)
  map("K", vim.lsp.buf.hover, "Hover Documentation")
  map("<C-k>", vim.lsp.buf.signature_help, "Signature Help", { mode = "i", method = "textDocument/signatureHelp" })
  -- Lspsaga definition & reference finder popup
  map("gh", "Lspsaga lsp_finder", "Show Definition & References")
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
end

--- Code actions, rename, and code lens
local function code_actions(map)
  -- `gra` / `grn` are the Neovim 0.11 defaults, `<leader>ca` / `<leader>rn` kept as aliases
  local code_action = { mode = { "n", "v" }, method = "textDocument/codeAction" }
  map("gra", "Lspsaga code_action", "Code Action", code_action)
  map("<leader>ca", "Lspsaga code_action", "Code Action", code_action)

  local rn_opts = { expr = true, method = "textDocument/rename" }
  map("grn", rename, "Rename", rn_opts)
  map("<leader>rn", rename, "Rename", rn_opts)

  map("grx", vim.lsp.codelens.run, "Run Code Lens", { method = "textDocument/codeLens" })
end

--- LSP information / debugging using vim.notify
local function lsp_info(map, bufnr)
  map("<leader>li", function()
    local clients = vim.lsp.get_clients({ bufnr = bufnr })
    local names = vim.tbl_map(function(c)
      return c.name
    end, clients)
    local msg = #names > 0 and ("Attached clients: " .. table.concat(names, ", ")) or "No LSP clients attached"
    vim.notify(msg, vim.log.levels.INFO, { title = "LSP" })
  end, "Show Attached Clients")

  map("<leader>ll", function()
    vim.notify("Log path: " .. vim.lsp.get_log_path(), vim.log.levels.INFO, { title = "LSP Log" })
  end, "Show Log Path")
end

--- TypeScript specific keymaps (tsserver / ts_ls)
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
    vim.notify("Virtual environment (active): " .. active, vim.log.levels.INFO, { title = "Python Venv" })
    return
  end

  local venv_names = { ".venv", "venv", "env" }
  local root = vim.fs.root(0, venv_names)
  if root then
    for _, name in ipairs(venv_names) do
      local path = root .. "/" .. name
      if vim.fn.isdirectory(path) == 1 then
        vim.notify("Virtual environment (detected): " .. path, vim.log.levels.INFO, { title = "Python Venv" })
        return
      end
    end
  end
  vim.notify("No virtual environment active or detected", vim.log.levels.WARN, { title = "Python Venv" })
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
      vim.notify("No test file found for " .. vim.fn.expand("%"), vim.log.levels.WARN, { title = "Pytest" })
    end
  end, "Run Tests")

  map("<leader>pv", show_python_venv, "Show Virtual Env")
end

---------------------------------------------------------------------------
-- Entry Point
---------------------------------------------------------------------------

local TYPESCRIPT_SERVERS = { tsserver = true, ts_ls = true }
local PYTHON_SERVERS = { basedpyright = true, pyright = true }

---@param client vim.lsp.Client
---@param bufnr integer
function M.on_attach(client, bufnr)
  local map = make_mapper(client, bufnr, "LSP")

  documentation(map)
  diagnostics(map)
  code_actions(map)
  lsp_info(map, bufnr)

  if TYPESCRIPT_SERVERS[client.name] then
    typescript(make_mapper(client, bufnr, "TS"), client)
  end

  if PYTHON_SERVERS[client.name] then
    python(make_mapper(client, bufnr, "Python"))
  end
end

return M
