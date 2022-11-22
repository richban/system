-- go to last location when opening buffer
vim.cmd([[
    autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | execute "normal! g`\"" | endif
]])
-- Highlight on yank
vim.api.nvim_exec([[
    augroup YankHighlight
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank()
    augroup end
]], false)

-- vim.api.nvim_exec([[
--     augroup Format
--       autocmd!
--       autocmd BufWritePost * Format
--     augroup END
--   ]], false)

vim.api.nvim_exec([[
  augroup Format
    autocmd!
    autocmd BufWritePre *.ts TSLspOrganize
  augroup END
]], false)

-- set markdown FTs
vim.api.nvim_exec([[
  augroup SetMarkdownFt
    autocmd!
    autocmd BufNewFile,BufFilePre,BufRead *.markdown,*.mdown,*.mkd,*.mkdn,*.mdwn,*.md,*.MD  set ft=markdown
  augroup end
]], false)

-- windows to close with 'q'
vim.cmd(
  [[autocmd FileType help,qf,fugitive,fugitiveblame,netrw nnoremap <buffer><silent> q :close<CR>]])

-- windows to close with 'q'
vim.cmd(
  [[autocmd FileType help,qf,fugitive,fugitiveblame,netrw nnoremap <buffer><silent> q :close<CR>]])

function vim.fn.TrimWhiteSpace()
  local l = vim.fn.line(".")
  local c = vim.fn.col(".")
  vim.cmd("%s/\\s\\+$//e")
  vim.fn.cursor(l, c)
end

vim.cmd("autocmd BufWritePre * :lua vim.fn.TrimWhiteSpace()")
