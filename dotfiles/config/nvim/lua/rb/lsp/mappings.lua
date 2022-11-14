local M = {}

local telescope_mapper = require("rb.telescope.mappings")

function M.set(client)
  local opts = { noremap = true, silent = true }

  -- gives definition & references
  vim.api.nvim_set_keymap("n", "gh", "<cmd>Lspsaga lsp_finder<CR>", opts)

  vim.api.nvim_set_keymap("n", "<leader>h", "<cmd>Lspsaga hover_doc<CR>", opts)
  vim.api.nvim_set_keymap("n", "<leader>gs", "<cmd>Lspsaga signature_help<CR>", opts)

  -- Outline
  vim.api.nvim_set_keymap("n", "<leader>o", "<cmd>LSoutlineToggle<CR>", { silent = true })

  -- Diagnostic
  vim.api.nvim_set_keymap("n", "<leader>cd", "<cmd>Lspsaga show_line_diagnostics<CR>",
    { silent = true })
  vim.api.nvim_set_keymap("n", "<leader>cd", "<cmd>Lspsaga show_cursor_diagnostics<CR>",
    { silent = true })

  vim.api.nvim_set_keymap('n', '[d', "<cmd><Lspsaga diagnostic_jump_prev<CR>", opts)
  vim.api.nvim_set_keymap('n', ']d', "<cmd>Lspsaga diagnostic_jump_next<CR>", opts);

  -- Only jump to error
  vim.keymap.set("n", "[e", function()
    require("lspsaga.diagnostic").goto_prev({ severity = vim.diagnostic.severity.ERROR })
  end, opts)
  vim.keymap.set("n", "]e", function()
    require("lspsaga.diagnostic").goto_next({ severity = vim.diagnostic.severity.ERROR })
  end, opts)
  --

  -- Workspaces
  vim.api.nvim_set_keymap("n", "<space>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", opts)
  vim.api.nvim_set_keymap("n", "<space>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>",
    opts)
  vim.api.nvim_set_keymap("n", "<space>wl",
    "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>",
    opts)
  vim.api.nvim_set_keymap("n", "<C-l>", "<cmd>Telescope workspaces<CR>", opts)

  vim.api.nvim_set_keymap("n", "<leader>lc",
    ":lua print(vim.inspect(vim.lsp.get_active_clients()))<CR>", opts)
  vim.api.nvim_set_keymap("n", "<leader>lp", ":lua print(vim.lsp.get_log_path())<CR>", opts)

  if client.definitionProvider then
    vim.api.nvim_set_keymap("n", "gd", "<cmd>Lspsaga preview_definition<CR>", opts)
    vim.api.nvim_set_keymap("n", "gt", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
  end

  if client.implementationProvider then
    vim.api.nvim_set_keymap("n", "<leader>gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
  end

  if client.referencesProvider then
    -- vim.api.nvim_set_keymap('n','<leader>tr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    vim.api.nvim_set_keymap("n", "<leader>gr",
      "<cmd>lua require('telescope.builtin').lsp_references()<CR>", opts)
  end

  vim.api.nvim_set_keymap("n", "<leader>ca",
    "<cmd>lua require('telescope.builtin').lsp_code_actions({ timeout = 1000 })<CR>",
    opts)
  vim.api.nvim_set_keymap("v", "<leader>car",
    "<cmd>lua require('telescope.builtin').lsp_range_code_actions({ timeout = 1000 })<CR>",
    opts)
  vim.api.nvim_set_keymap("n", "<leader>ca", "<cmd>Lspsaga code_action<CR>", opts)
  vim.api.nvim_set_keymap("v", "<leader>ca", "<cmd><C-U>Lspsaga range_code_action<CR>", opts)

  if client.renameProvider then
    -- vim.api.nvim_set_keymap('n','<leader>rr','<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    vim.api.nvim_set_keymap("n", "gr", "<cmd>Lspsaga rename<CR>", opts)
  end

  vim.api.nvim_set_keymap("n", "<leader>bf", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)

  if client.documentRangeFormattingProvider then
    vim.api.nvim_set_keymap("n", "<leader>bF", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", opts)
  end

  -- Typescript
  vim.api.nvim_set_keymap("n", "<leader>to", ":TSLspOrganize<CR>", opts)
  vim.api.nvim_set_keymap("n", "<leader>tc", ":TSLspFixCurrent<CR>", opts)
  -- vim.api.nvim_set_keymap("n", "gr", ":TSLspRenameFile<CR>", 'lsp', 'lsp_', '')
  vim.api.nvim_set_keymap("n", "<leader>ti", ":TSLspImportAll<CR>", opts)

  -- Telescope
  telescope_mapper("gr", "lsp_references", nil, true)
  telescope_mapper("gI", "lsp_implementations", nil, true)
  telescope_mapper("<space>wd", "lsp_document_symbols", { ignore_filename = true }, true)
  telescope_mapper("<space>ww", "lsp_dynamic_workspace_symbols", { ignore_filename = true }, true)
  -- telescope_mapper("<space>ca", "lsp_code_actions", nil, true)
end

return M
