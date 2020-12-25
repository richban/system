local custom = {}
custom.organize_imports_sync = function(timeout_ms)
  print('test')
  -- local context = { source = { organizeImports = true } }
  -- vim.validate { context = { context, 't', true } }
  -- local params = vim.lsp.util.make_range_params()
  -- params.context = context

  -- local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, timeout_ms)
  -- if not result then return end
  -- result = result[1].result
  -- if not result then return end
  -- edit = result[1].edit
  -- vim.lsp.util.apply_workspace_edit(edit)
end

-- function Lint()
--   silent :CocCommand eslint.executeAutofix
-- endfunction

map('n', '<leader>ld', '<cmd>lua vim.lsp.buf.definition()<CR>')
map('n', '<leader>ltd', '<cmd>lua vim.lsp.buf.type_definition()<CR>')
-- map('n', 'gd', '<cmd>lua vim.lsp.buf.declaration()<CR>')
map('n', '<leader>li', '<cmd>lua vim.lsp.buf.implementation()<CR>')
map('n', '<leader>lr', '<cmd>lua vim.lsp.buf.references()<CR>')
map('n', '<leader>lh', '<cmd>lua vim.lsp.buf.hover()<CR>')
	-- map('n','<leader>gW','<cmd>lua vim.lsp.buf.workspace_symbol()<CR>')
map('n', '<leader>lds', '<cmd>lua vim.lsp.buf.document_symbol()<CR>')

map('n', '<leader>la', '<cmd>lua vim.lsp.buf.code_action()<CR>')
map('n', '<leader>lsd', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>')
map('n', '<leader>ld0', '<cmd>:LspDiagnostics 0<CR>')

map('n', '<leader>lf', '<cmd>lua vim.lsp.buf.formatting()<CR>')
map('n', '<leader>oi', '<cmd>lua custom.organize_import_sync()<CR>')

map('n', '<leader>lr','<cmd>lua vim.lsp.buf.rename()<CR>')

-- using tab for navigating in completion
vim.api.nvim_exec([[
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
imap <Tab> <Plug>(completion_smart_tab)
imap <S-Tab> <Plug>(completion_smart_s_tab)
]], true)


	-- map('n','gs','<cmd>lua vim.lsp.buf.signature_help()<CR>')
	-- map('n','gi','<cmd>lua vim.lsp.buf.implementation()<CR>')
	-- map('n','gt','<cmd>lua vim.lsp.buf.type_definition()<CR>')
	-- map('n','<leader>ah','<cmd>lua vim.lsp.buf.hover()<CR>')
	-- map('n','<leader>af','<cmd>lua vim.lsp.buf.code_action()<CR>')
	-- map('n','<leader>ee','<cmd>lua vim.lsp.util.show_line_diagnostics()<CR>')
	-- map('n','<leader>ai','<cmd>lua vim.lsp.buf.incoming_calls()<CR>')
	-- map('n','<leader>ao','<cmd>lua vim.lsp.buf.outgoing_calls()<CR>')
  --

