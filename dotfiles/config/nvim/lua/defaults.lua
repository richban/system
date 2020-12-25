vim.cmd("syntax on")
vim.cmd("filetype plugin indent on")

vim.o.mouse = 'a'
vim.o.cursorline = true
vim.o.hidden = true
vim.o.errorbells = false
vim.o.encoding= 'utf-8'
vim.o.inccommand = 'split'

vim.o.tabstop = 2
vim.o.softtabstop = 2
vim.o.shiftwidth = 2
vim.o.expandtab = true
vim.o.smartindent = true
vim.o.smarttab = true
vim.o.wrap = false
vim.o.backspace = 'indent,eol,start'

vim.o.number = true
vim.o.relativenumber = true

vim.o.incsearch = true
vim.o.hlsearch = true
vim.o.ignorecase = true
vim.o.smartcase = true

vim.o.termguicolors = true
vim.emoji = false

vim.o.swapfile = false
vim.o.backup = false
vim.o.writebackup = false

vim.o.ttyfast = true

-- menuone: popup even when there's only one match
-- noinsert: Do not insert text until a selection is made
-- noselect: Do not select, force user to select one from the menu
vim.o.completeopt = 'menuone,noinsert,noselect'

-- Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
-- delays and poor user experience.
vim.o.updatetime = 50

-- GLOBALS --------------------------------------------------------------------

vim.g.mapleader = ' '

-- python
vim.g.python_host_prog = '/Users/rbanyi/.pyenv/versions/neovim2/bin/python'
vim.g.python3_host_prog = '/Users/rbanyi/.pyenv/versions/neovim3/bin/python'

-- theme

vim.cmd('colorscheme spaceduck')

vim.g.gruvbox_material_background = 'hard'
vim.g.gruvbox_material_enable_italic = 1
vim.g.gruvbox_material_enable_bold = 1
vim.g.gruvbox_material_better_performance = 1
vim.g.gruvbox_material_palette = 'mix'
vim.g.gruvbox_material_sign_column_background = 'none'

-- MAPPINGS--------------------------------------------------------------------

map('t', '<ESC>', 'C-\\><C-n>')
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
map('n', '<Leader><CR>', ':so ~/.config/nvim/init.lua<CR>')

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

