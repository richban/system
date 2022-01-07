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

  vim.api.nvim_exec([[
      function! s:PyPreSave()
        execute "silent !black " . bufname("%")
        execute "e"
      endfunction

      function! s:PyPostSave()
          execute "silent !tidy-imports --black --quiet --replace-star-imports --action REPLACE " . bufname("%")
          execute "e"
      endfunction

      :command! PyPreSave :call s:PyPreSave()
      :command! PyPostSave :call s:PyPostSave()

      augroup waylonwalker
          autocmd!
          autocmd BufWritePost * Format
          autocmd bufwritepost *.py execute 'PyPostSave'
          autocmd bufwritepost .tmux.conf execute ':!tmux source-file %'
          autocmd bufwritepost .tmux.local.conf execute ':!tmux source-file %'
          autocmd bufwritepost *.vim execute ':source %'
      augroup end

  ]], false)

  -- vimdows to close with 'q'
  vim.cmd [[autocmd FileType help,qf,fugitive,fugitiveblame,netrw nnoremap <buffer><silent> q :close<CR>]]

  nvim_create_augroups(definitions)
end

return autocmd
