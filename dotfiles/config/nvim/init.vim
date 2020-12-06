set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc

" Jupytext
let g:jupytext_fmt = 'py'
let g:jupytext_style = 'hydrogen'

let g:nvim_ipy_perform_mappings = 0
let g:ipy_celldef = '# %%'
map <silent> <c-s> <Plug>(IPy-Run)
map <silent> <leader>c <Plug>(IPy-RunCell)

tnoremap <Esc> <C-\><C-n>

" Send cell to IronRepl and move to next cell.
" Depends on the text object defined in vim-textobj-hydrogen
" You first need to be connected to IronRepl
nmap ]x ctrih/^# %%<CR><CR>

luafile $HOME/.config/nvim/plugins.lua
