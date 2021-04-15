local M = {}

function M.set(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end
  local opts = { noremap=true, silent=true }

  local mapper = function(mode, key, result)
    vim.api.nvim_buf_set_keymap(0, mode, key, "<cmd>lua " .. result .. "<CR>", {noremap = true, silent = true})
  end

  mapper('n', '<space>cr', 'MyLspRename()')

  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- install servers
  buf_set_keymap('n', '<leader>li', "<cmd>lua require('rb.lsp.install_servers').lsp_install_servers()<CR>", opts)
  -- gives definition & references
  buf_set_keymap('n', '<leader>gr', "<cmd>lua require'lspsaga.provider'.lsp_finder()<CR>", opts)

  -- buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  -- buf_set_keymap('n','<leader>th', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', '<leader>H', "<cmd>lua require('lspsaga.hover').render_hover_doc()<CR>", opts)
  buf_set_keymap('n', '<leader>gs', "<cmd>lua require('lspsaga.signaturehelp').signature_help()<CR>", opts)

  -- Diagnostic
  -- buf_set_keymap('n','<leader>fe', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  -- buf_set_keymap('n','<leader>fe', '<cmd>:LspDiagnostics 0<CR>', opts)
  buf_set_keymap('n','<leader>fd', "<cmd>lua require('rb.lsp.functions').show_diagnostics()<CR>", opts)
  -- buf_set_keymap('n','<leader>fE', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n','<leader>fD', "<cmd>lua require'lspsaga.diagnostic'.show_line_diagnostics()<CR>", opts)
  -- buf_set_keymap('n','[e', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  -- buf_set_keymap('n',']e', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '[d', "<cmd>lua require'lspsaga.diagnostic'.lsp_jump_diagnostic_prev()<CR>", opts)
  buf_set_keymap('n', ']d', "<cmd>lua require'lspsaga.diagnostic'.lsp_jump_diagnostic_next()<CR>", opts);

  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)

  buf_set_keymap('n','<leader>Lc', ':lua print(vim.inspect(vim.lsp.get_active_clients()))<CR>', opts)
  buf_set_keymap('n','<leader>Ll', ":lua print(vim.lsp.get_log_path())<CR>", opts)
  -- buf_set_keymap('n','<leader>fcl', ":lua vim.cmd('e'..vim.lsp.get_log_path())<CR>", opts)
  buf_set_keymap('n','<leader>Li', ':LspInfo()<CR>', opts)

  if client.definitionProvider then
    buf_set_keymap('n', '<leader>gD', "<cmd>lua require'lspsaga.provider'.preview_definition()<CR>", opts)
    buf_set_keymap('n', '<leader>gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
    buf_set_keymap('n','<leader>gtd', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  end

  if client.implementationProvider then
    buf_set_keymap('n','<leader>gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  end

  if client.referencesProvider then
    -- buf_set_keymap('n','<leader>tr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    buf_set_keymap('n','<leader>gR', "<cmd>lua require('telescope.builtin').lsp_references()<CR>", opts)
  end

  if client.codeActionProvider then
    -- buf_set_keymap('n','<leader>fa', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
    -- buf_set_keymap('v', '<leader>fa', "<cmd>'<,'>lua vim.lsp.buf.range_code_action()<cr>", opts)
    buf_set_keymap('n','<leader>fa', "<cmd>lua require('telescope.builtin').lsp_code_actions({ timeout = 1000 })<CR>", opts)
    buf_set_keymap('v', '<leader>fa', "<cmd>lua require('telescope.builtin').lsp_range_code_actions({ timeout = 1000 })<CR>", opts)
    -- buf_set_keymap('n', '<leader>fa', "<cmd>lua require('lspsaga.codeaction').code_action()<CR>", opts)
    -- buf_set_keymap('v', '<leader>fa', "<cmd>'<,'>lua require('lspsaga.codeaction').range_code_action()<CR>", opts) ]]
    buf_set_keymap('n', '<leader>fo', '<cmd>lua require("rb.lsp.functions").organize_imports()<CR>', opts)
  end

  if client.renameProvider then
    -- buf_set_keymap('n','<leader>rr','<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    buf_set_keymap('n','<leader>rr', "<cmd>lua require('lspsaga.rename').rename()<CR>", opts)
  end

  if client.documentFormattingProvider then
    buf_set_keymap('n','<leader>ff', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
  elseif client.documentRangeFormattingProvider then
    buf_set_keymap('n','<leader>ff', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
  end

  vim.api.nvim_exec(
  [[
  inoremap <silent><expr> <C-p> compe#complete()
  inoremap <silent><expr> <Tab> compe#complete()
  inoremap <silent><expr> <CR>  compe#confirm('<CR>')
  ]],
  true)

  -- using tab for navigating in completion
  vim.api.nvim_exec(
  [[
  inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
  inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
  ]],
  true)

end

return M
