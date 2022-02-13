local autocmd = {}

function autocmd.setup()
  local definitions = {
    wins = {
      {'BufNewFile,BufRead', '*.jsx', 'set filetype=javascript.jsx'}, {'BufNewFile,BufRead', ' *.tsx', 'set filetype=typescript.tsx'},
      {'BufNew,BufEnter', '*.md,*.markdown,*.wiki', 'set conceallevel=0'}, {'TextYankPost', '*', 'lua vim.highlight.on_yank()'},
      {'VimEnter', '*', 'call vista#RunForNearestMethodOrFunction()'}, {'BufWritePre', '*', 'call TrimWhitespace()'},
      {'BufWritePre', '*.ts', 'TSLspOrganize'}, -- show diagnostic popup on cursor hold
      -- {'CursorHold', '<Buffer>', 'lua vim.lsp.diagnostic.show_line_diagnostics({ show_header = false })'},
      {'BufWritePost', 'plugins.lua', 'PackerCompile'}
    },
    ft = {
      {'FileType', '*', 'setlocal formatoptions-=c formatoptions-=r formatoptions-=o'},
      {'FileType', 'css,html,html,javascript,typescript', 'setlocal  tabstop=2 shiftwidth=2 softtabstop=2'}
    }
  }

  -- go to last location when openingna buffer
  vim.cmd [[
        autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | execute "normal! g`\"" | endif
    ]]

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

  -- vimdows to close with 'q'
  vim.cmd [[autocmd FileType help,qf,fugitive,fugitiveblame,netrw nnoremap <buffer><silent> q :close<CR>]]

  nvim_create_augroups(definitions)
end

return autocmd
