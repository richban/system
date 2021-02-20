local mappings = {}

function mappings.setup()
    vim.cmd [[tnoremap <Esc> '<C-\><C-n>' ]]
    map('i', '<C-c>', '<ESC>')
    -- Join yanked text on a yank (needed for terminal mode copies)
    map("v", "yy", "y<CR>:let @\"=substitute(@\", \'\\n\', \'\', \'g\')<CR>:call yank#Osc52Yank()<CR>")
    -- Move selected lines
    map('v', 'J', ':m \'>+1<CR>gv=gv')
    map('v', 'K', ':m \'<-2<CR>gv=gv')
    -- Commonly-used files
    map('n', '<leader>cv', ':e $MYVIMRC<CR>')
    map('n', '<leader>cz', ':e ~/.zshrc<CR>')
    map('n', '<leader>ce', ':e ~/.zshenv<CR>')
    map('n', '<leader>ca', ':e ~/.alias<CR>')
    map('n', '<leader>cf', ':e ~/.functions<CR>')
    map('n', '<leader>ct', ':e ~/.tmux.conf<CR>')
    map('n', '<leader>cy', ':e ~/.yabairc<CR>')
    map('n', '<leader>cs', ':e ~/.skhdrc<CR>')
    -- resource init.vim
    -- map('n', '<Leader><CR>', ':source $MYVIMRC<CR>', { noremap = true, silent = false })
    map('n', '<leader><CR>', ':lua reload()<CR>')
    -- Toggle Paste mode
    map('n', '<leader>p', ':set paste!<CR>')
    -- Window navigation
    map('', '<C-J>', '<C-W><C-J>')
    map('', '<C-K>', '<C-W><C-K>')
    map('', '<C-L>', '<C-W><C-L>')
    map('', '<C-H>', '<C-W><C-H>')
    -- Adjusting splits
    map('n', '<silent> <Leader>>', ':vertical resize +10<CR>')
    map('n', '<silent> <Leader><', ':vertical resize -10<CR>')
    map('n', '<silent> <Leader>+', ':resize +10<CR>')
    map('n', '<silent> <Leader>-', ':resize -10<CR>')
    -- Change directory to current directory
    map('n', '<leader>cd', ':cd %:p:h<CR>:pwd<CR>')
    -- map <leader>ghw :h <C-R>=expand("<cword>")<CR><CR>
    -- map <leader>pw :Rg <C-R>=expand("<cword>")<CR><CR>
    -- map <leader>prw :CocSearch <C-R>=expand("<cword>")<CR><CR>
end

return mappings
