local setup = function()
    -- vim.api.nvim_exec([[
    --   call plug#begin('~/.vim/plugged')
    --     Plug  'untitled-ai/jupyter_ascending.vim'
    --     Plug  'bfredl/nvim-ipy'
    --     Plug  'hkupty/iron.nvim'
    --     Plug  'Vimjas/vim-python-pep8-indent'
    --     Plug  'heavenshell/vim-pydocstring'
    --     Plug  'GCBallesteros/jupytext.vim'
    --     Plug  'kana/vim-textobj-line'
    --     Plug  'kana/vim-textobj-user'
    --     Plug  'GCBallesteros/vim-textobj-hydrogen'
    --   call plug#end()
    -- ]], true)
    require('utils')
    require'settings'.setup()
    require'mappings'.setup()
    require'autocmd'.setup()
    require'plugins'
    require('plugins/init')
end

setup()
