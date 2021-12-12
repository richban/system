local M = {}

local telescope_mapper = require "rb.telescope.mappings"

function M.set(client)
  local function buf_set_keymap(...)
    vim.api.nvim_buf_set_keymap(0, ...)
  end
  local opts = {noremap = true, silent = true}

  local mapper = function(mode, key, result)
    vim.api.nvim_buf_set_keymap(0, mode, key, "<cmd>lua " .. result .. "<CR>", {noremap = true, silent = true})
  end

  -- install servers
  buf_set_keymap('n', '<leader>lsp', "<cmd>lua require('rb.lsp.install_servers').lsp_install_servers()<CR>", opts)
  -- gives definition & references
  buf_set_keymap('n', '<leader>gr', "<cmd>Lspsaga lsp_finder<CR>", opts)

  -- buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  -- buf_set_keymap('n','<leader>th', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', '<leader>H', "<cmd>Lspsaga hover_doc<CR>", opts)
  buf_set_keymap('n', '<leader>gs', "<cmd>Lspsaga signature_help<CR>", opts)

  -- Diagnostic
  -- buf_set_keymap('n','<leader>fe', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  -- buf_set_keymap('n','<leader>fe', '<cmd>:LspDiagnostics 0<CR>', opts)
  buf_set_keymap('n', '<leader>dd', "<cmd>lua require('rb.lsp.functions').show_diagnostics()<CR>", opts)
  -- buf_set_keymap('n','<leader>fE', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '<leader>d', "<cmd>Lspsaga show_line_diagnostics<CR>", opts)
  -- buf_set_keymap('n','[e', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  -- buf_set_keymap('n',']e', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '[d', "<cmd><Lspsaga diagnostic_jump_prev<CR>", opts)
  buf_set_keymap('n', ']d', "<cmd>Lspsaga diagnostic_jump_next<CR>", opts);

  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)

  buf_set_keymap('n', '<leader>Lc', ':lua print(vim.inspect(vim.lsp.get_active_clients()))<CR>', opts)
  buf_set_keymap('n', '<leader>Ll', ":lua print(vim.lsp.get_log_path())<CR>", opts)
  -- buf_set_keymap('n','<leader>fcl', ":lua vim.cmd('e'..vim.lsp.get_log_path())<CR>", opts)
  buf_set_keymap('n', '<leader>Li', ':LspInfo()<CR>', opts)

  buf_set_keymap("n", "gd", ":lua vim.lsp.buf.definition()<CR>", opts)

  if client.definitionProvider then
    buf_set_keymap('n', 'gD', "<cmd>Lspsaga preview_definition<CR>", opts)
    buf_set_keymap('n', 'gt', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  end

  if client.implementationProvider then buf_set_keymap('n', '<leader>gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts) end

  if client.referencesProvider then
    -- buf_set_keymap('n','<leader>tr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    buf_set_keymap('n', '<leader>gr', "<cmd>lua require('telescope.builtin').lsp_references()<CR>", opts)
  end

  -- buf_set_keymap('n','<leader>fa', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  -- buf_set_keymap('v', '<leader>fa', "<cmd>'<,'>lua vim.lsp.buf.range_code_action()<cr>", opts)
  buf_set_keymap('n', '<leader>ca', "<cmd>lua require('telescope.builtin').lsp_code_actions({ timeout = 1000 })<CR>", opts)
  buf_set_keymap('v', '<leader>car', "<cmd>lua require('telescope.builtin').lsp_range_code_actions({ timeout = 1000 })<CR>", opts)
  buf_set_keymap('n', 'gx', "<cmd>Lspsaga code_action<CR>", opts)
  -- buf_set_keymap('v', '<leader>fa', "<cmd>'<,'>lua require('lspsaga.codeaction').range_code_action()<CR>", opts) ]]

  mapper('n', '<space>cr', 'MyLspRename()')
  if client.renameProvider then
    -- buf_set_keymap('n','<leader>rr','<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    buf_set_keymap('n', '<leader>rr', "<cmd>Lspsaga rename<CR>", opts)
  end

  buf_set_keymap('n', '<leader>bf', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)

  if client.documentRangeFormattingProvider then buf_set_keymap('n', '<leader>bF', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts) end

  -- Typescript
  buf_set_keymap("n", "<leader>to", ":TSLspOrganize<CR>", opts)
  buf_set_keymap("n", "<leader>tc", ":TSLspFixCurrent<CR>", opts)
  -- buf_set_keymap("n", "gr", ":TSLspRenameFile<CR>", 'lsp', 'lsp_', '')
  buf_set_keymap("n", "<leader>ti", ":TSLspImportAll<CR>", opts)

  -- Telescope
  telescope_mapper("gr", "lsp_references", nil, true)
  telescope_mapper("gI", "lsp_implementations", nil, true)
  telescope_mapper("<space>wd", "lsp_document_symbols", {ignore_filename = true}, true)
  telescope_mapper("<space>ww", "lsp_dynamic_workspace_symbols", {ignore_filename = true}, true)
  -- telescope_mapper("<space>ca", "lsp_code_actions", nil, true)
end

return M
