vim.api.nvim_exec(
	[[
  let g:beancount_separator_col=70
  au FileType beancount nnoremap <buffer> <leader>c vip:AlignCommodity<CR>
  au FileType beancount nnoremap <buffer> <leader>g vip:GetContext<CR>

  autocmd FileType beancount inoremap <buffer> <Tab> <C-x><C-o>
]],
	false
)
