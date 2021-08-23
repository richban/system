-- completion.nvim
-- vim.g.completion_confirm_key = ""
-- vim.g.completion_matching_strategy_list = {'exact', 'substring', 'fuzzy'}
-- vim.g.completion_enable_snippet = 'vim-vsnip'
-- vim.g.completion_trigger_keyword_length = 2

-- -- using tab for navigating in completion
-- vim.api.nvim_exec([[
-- inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
-- inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

-- imap <Tab> <Plug>(completion_smart_tab)
-- imap <S-Tab> <Plug>(completion_smart_s_tab)
-- ]], true)

require'compe'.setup {
  enabled = true,
  debug = true,
  min_length = 2,
  -- enabled = true,
  -- autocomplete = true,
  -- debug = false,
  -- min_length = 1,
  -- preselect = "enable",
  -- throttle_time = 200,
  -- source_timeout = 200,
  -- incomplete_delay = 400,
  -- allow_prefix_unmatch = false,

  source = {
    vsnip = {
      filetypes = {'markdown', 'json', 'yaml', 'css', 'scss', 'javascript', 'typescript', 'javascriptreact', 'typescriptreact', 'typescript.tsx'},
      sticky_char = '0'
    },
    nvim_lua = { 'lua' },
    nvim_lsp = {
      filetypes = {'markdown', 'json', 'yaml', 'css', 'scss', 'javascript', 'typescript', 'javascriptreact', 'typescriptreact' ,'typescript.tsx'}
    },
    path = true,
    buffer =  true,
  }
}
