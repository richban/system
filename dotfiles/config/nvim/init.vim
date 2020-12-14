" -- PLUGINS ------------------------------------------------------------------

" Install plugin manager if not installed already!
if ! filereadable(system('echo -n "${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/plug.vim"'))
	echo "Downloading junegunn/vim-plug to manage plugins..."
	silent !mkdir -p ${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/
	silent !curl "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim" > ${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/plug.vim
	autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin(system('echo -n "${XDG_CONFIG_HOME:-$HOME/.config}/nvim/plugged"'))
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } } | Plug 'junegunn/fzf.vim'
    Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
    Plug 'tpope/vim-fugitive' | Plug 'airblade/vim-gitgutter'
    Plug 'yuttie/comfortable-motion.vim' | Plug 'Lokaltog/vim-easymotion'
    Plug 'christoomey/vim-tmux-navigator'
    Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
    Plug 'glacambre/firenvim', { 'do': { _ -> firenvim#install(1) } }
    Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }
    Plug 'liuchengxu/vista.vim'
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    Plug 'nvim-treesitter/nvim-treesitter'
    " Colors
    Plug 'sainnhe/gruvbox-material' | Plug 'pineapplegiant/spaceduck'
    Plug 'ryanoasis/vim-devicons' | Plug 'kyazdani42/nvim-web-devicons'
    Plug 'sheerun/vim-polyglot'
    Plug 'itchyny/lightline.vim'
    " Text formating
    Plug 'Yggdroot/indentLine'
    Plug 'tpope/vim-commentary'
    Plug 'Raimondi/delimitMate'
    Plug 'godlygeek/tabular'
    Plug 'tpope/vim-surround'
    " LSP
    Plug 'neovim/nvim-lspconfig'
    Plug 'nvim-lua/completion-nvim'
    " Profile Vim startup
    Plug 'tweekmonster/startuptime.vim'
    " Vim statistics
    Plug 'wakatime/vim-wakatime'
    " Jupyter
    Plug 'bfredl/nvim-ipy' | Plug 'hkupty/iron.nvim'
    Plug 'kana/vim-textobj-line' | Plug 'kana/vim-textobj-user'
    Plug 'GCBallesteros/vim-textobj-hydrogen' | Plug 'GCBallesteros/jupytext.vim'
    " Telescope
    Plug 'nvim-lua/popup.nvim'
    Plug 'nvim-lua/plenary.nvim'
    Plug 'nvim-telescope/telescope.nvim'
call plug#end()

" -- GENERAL ------------------------------------------------------------------

filetype plugin indent on
syntax on

set cursorline
"" Formating
set encoding=utf-8
set showcmd
set textwidth=79
set colorcolumn=80
set laststatus=2
set linespace=1
set smartindent
set updatetime=50
set mouse=a
" Give more space for displaying messages.
set cmdheight=1
set termguicolors
""" Whitespace
set nowrap                      " don't wrap lines
set tabstop=4                   " a tab is two spaces (or set this to 4)
set shiftwidth=4                   " a tab is two spaces (or set this to 4)
set expandtab                   " use spaces, not tabs (optional)
set smarttab
set backspace=indent,eol,start  " backspace through everything in insert mode
"" Searching
set hlsearch                   " highlight matches
set incsearch                  " incremental searching
set ignorecase                 " searches are case insensitive...
set smartcase                  " ... unless they contain at least one capital letter
set number
set relativenumber
" set wildmenu " Visual autocomplete for cmd men
" set wildmode=longest,list,full " List as much as possible
set wildcharm=<C-z>            " Juggling with buffers
"" Swap/backup
set backupdir=~/tmp
set noswapfile
set nowritebackup
set nobackup
" Perhaps fix emojis
set noemoji
" Disable automatic comment insertion
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

"" Just softabs for the homies
autocmd Filetype css setlocal  tabstop=2 shiftwidth=2 softtabstop=2  " Set tabs to 2 spaces in html and css
autocmd Filetype html setlocal  tabstop=2 shiftwidth=2 softtabstop=2 " Set tabs to 2 spaces in html and css
autocmd Filetype javascript  setlocal  tabstop=2 shiftwidth=2 softtabstop=2  " Set tabs to 2 spaces in html and css

if has('nvim')
    set clipboard+=unnamedplus
    let g:python_host_prog = "/Users/rbanyi/.pyenv/versions/neovim2/bin/python"
    let g:python3_host_prog = "/Users/rbanyi/.pyenv/versions/neovim3/bin/python"
else
    set ttymouse=sgr
endif

if exists('+termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif

" Gruvbox-material
let g:gruvbox_material_background = 'hard'
let g:gruvbox_material_enable_italic = 1
let g:gruvbox_material_enable_bold = 1
let g:gruvbox_material_better_performance = 1
let g:gruvbox_material_palette = 'mix'
let g:gruvbox_material_sign_column_background = 'none'

colorscheme spaceduck

" -- MAPPINGS -----------------------------------------------------------------

let mapleader=" "
let maplocalleader = '\'

com! W w

tnoremap <Esc> <C-\><C-n>
inoremap <C-c> <esc>

" Join yanked text on a yank (needed for terminal mode copies)
vnoremap yy y<CR>:let @"=substitute(@", '\n', '', 'g')<CR>:call yank#Osc52Yank()<CR>

""" Move selected lines
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" Commonly-used files
nnoremap <leader>cv :e $MYVIMRC<CR>
nnoremap <leader>cz :e ~/.zshrc<CR>
nnoremap <leader>ce :e ~/.zshenv<CR>
nnoremap <leader>ca :e ~/.alias<CR>
nnoremap <leader>cf :e ~/.functions<CR>
nnoremap <leader>ct :e ~/.tmux.conf<CR>
nnoremap <leader>cy :e ~/.yabairc<CR>
nnoremap <leader>cs :e ~/.skhdrc<CR>

" source init.vim
nnoremap <Leader><CR> :so ~/.config/nvim/init.vim<CR>

" Toggle Paste mode
nnoremap <leader>p :set paste!<CR>

" Window navigation
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Adjusting splits
nnoremap <silent> <Leader>> :vertical resize +10<CR>
nnoremap <silent> <Leader>< :vertical resize -10<CR>
nnoremap <silent> <Leader>+ :resize +10<CR>
nnoremap <silent> <Leader>- :resize -10<CR>

" Change directory to current directory
nnoremap <leader>cd :cd %:p:h<CR>:pwd<CR>

"" Move among buffers with CTRL
map <Leader>l :bnext<CR>
map <Leader>h :bprev<CR>

nnoremap <leader>ghw :h <C-R>=expand("<cword>")<CR><CR>
nnoremap <leader>pw :Rg <C-R>=expand("<cword>")<CR><CR>
nnoremap <leader>prw :CocSearch <C-R>=expand("<cword>")<CR><CR>

" -- FIRENVIM -----------------------------------------------------------------

let g:firenvim_config = {
  \ 'globalSettings': {
      \ 'alt': 'all',
  \  },
  \ 'localSettings': {
      \ '.*': {
          \ 'cmdline': 'neovim',
          \ 'priority': 0,
          \ 'selector': 'textarea',
          \ 'takeover': 'always',
      \ },
  \ }
\ }

let fc = g:firenvim_config['localSettings']
let fc['https://youtube.com.*'] = { 'takeover': 'never', 'priority': 1 }
let fc['https?://instagram.com.*'] = { 'takeover': 'never', 'priority': 1 }
let fc['https?://twitter.com.*'] = { 'takeover': 'never', 'priority': 1 }
let fc['https://.*gmail.com.*'] = { 'takeover': 'never', 'priority': 1 }
let fc['https://.*google.com.*'] = { 'takeover': 'never', 'priority': 1 }
let fc['https?://.*twitch.tv.*'] = { 'takeover': 'never', 'priority': 1 }
let fc['https?://notion.so.*'] = { 'takeover': 'never', 'priority': 1 }
let fc['https?://reddit.com.*'] = { 'takeover': 'never', 'priority': 1 }

" -- TMUX-NAVIGATOR -----------------------------------------------------------

" Disable tmux navigator when zooming the Vim pane
let g:tmux_navigator_disable_when_zoomed = 1

" -- ULTISNIPS ----------------------------------------------------------------

let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" -- FZF ----------------------------------------------------------------------

let g:fzf_layout = { 'window': { 'width': 0.8, 'height': 0.8 } }
let $FZF_DEFAULT_OPTS='--reverse'

" -- NERDTree -----------------------------------------------------------------

let g:NERDTreeDirArrowExpandable = ''
let g:NERDTreeDirArrowCollapsible = ''
let g:NERDTreeWinPos = "left"
let NERDTreeNaturalSort = 1
let NERDTreeIgnore = ['\.pyc$', '__pycache__']

nmap <silent> <leader>n :NERDTreeToggle<CR>
nnoremap <silent> <Leader>f :NERDTreeFind<CR>

autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" -- VIM-FUGITIVE -------------------------------------------------------------

nmap <silent> <Leader>gs :Gstatus<CR>
nmap <silent> <Leader>gvd :Gvdiffsplit<CR>
nmap <silent> <leader>gl :diffget //3<CR>
nmap <silent> <leader>gh :diffget //2<CR>

" -- LIGHTLINE  ---------------------------------------------------------------

function! CocCurrentFunction()
    return get(b:, 'coc_current_function', '')
endfunction

let g:lightline = {
      \ 'colorscheme': 'spaceduck',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch','cocstatus', 'readonly', 'relativepath', 'modified', 'method'] ],
      \ 'right': [ [ 'lineinfo' ],
      \            [ 'percent' ],
      \            [ 'fileformat', 'fileencoding', 'filetype' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'gitbranch#name',
      \   'method': 'NearestMethodOrFunction',
      \   'cocstatus': 'coc#status',
      \ }
      \ }

" set showtabline=2 "Always show tabline for bufferline on top

" -- TABULARIZE  ---------------------------------------------------------------

if exists(":Tabularize")
    nmap <Leader>= :Tab /=<CR>
    vmap <Leader>= :Tab /=<CR>
    nmap <Leader>: :Tab /:\zs<CR>
    vmap <Leader>: :Tab /:\zs<CR>
endif

" -- AUTO-COMPLETION ----------------------------------------------------------

let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy']

" Set completeopt to have a better completion experience
set completeopt=menuone,noinsert,noselect

" Enable/Disable auto popup
let g:asyncomplete_auto_completeopt = 0

" Avoid showing message extra message when using completion
set shortmess+=c

" Use <Tab> and <S-Tab> to navigate through popup menu
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" -- LSP ----------------------------------------------------------------------

nnoremap <leader>gd :lua vim.lsp.buf.definition()<CR>
nnoremap <leader>gD :lua vim.lsp.buf.declaration()<CR>
nnoremap <leader>gi :lua vim.lsp.buf.implementation()<CR>
nnoremap <leader>gsh :lua vim.lsp.buf.signature_help()<CR>
nnoremap <leader>grr :lua vim.lsp.buf.references()<CR>
nnoremap <leader>grn :lua vim.lsp.buf.rename()<CR>
nnoremap <leader>gh :lua vim.lsp.buf.hover()<CR>
nnoremap <leader>gca :lua vim.lsp.buf.code_action()<CR>
nnoremap <leader>gsd :lua vim.lsp.util.show_line_diagnostics()<CR>
nnoremap <leader>gtd :lua vim.lsp.buf.type_definition()<CR>
nnoremap <leader>tf :lua vim.lsp.buf.formating()<CR>

:lua << EOF
  local nvim_lsp = require('lspconfig')
  local on_attach = function(_, bufnr)
    require('completion').on_attach()
  end
  local servers = {'jsonls', 'pyls_ms', 'vimls', 'clangd', 'tsserver', 'cssls', 'html'}
  for _, lsp in ipairs(servers) do
    nvim_lsp[lsp].setup {
      on_attach = on_attach,
    }
  end
EOF

" -- EASY MOTION --------------------------------------------------------------

let g:comfortable_motion_scroll_down_key = "j"
let g:comfortable_motion_scroll_up_key = "k"

" -- TELESCOPE ----------------------------------------------------------------

nnoremap <C-p> :lua require('telescope.builtin').git_files()<CR>
nnoremap <leader>fw :lua require('telescope.builtin').grep_string { search = vim.fn.expand("<cword>") }<CR>
nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <leader>fg <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <leader>fb <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap <leader>ft <cmd>lua require('telescope.builtin').help_tags()<cr>

" -- INDENT-LINE --------------------------------------------------------------

let g:indentLine_char = '▏'             " Show Indentation lines
let g:indentLine_color_gui = '#474747'  " Make them pretty-gray-lines
let g:indentLine_enabled = 1            " Just toggle this shit bro

autocmd BufNew,BufEnter *.md,*.markdown,*.wiki execute "set conceallevel=0"
autocmd BufNew,BufEnter *.html,*.css, execute "IndentLinesToggle"

" -- JUPYTEXT -----------------------------------------------------------------

let g:jupytext_fmt = 'py'
let g:jupytext_style = 'hydrogen'

" -- NVIM-IPY -----------------------------------------------------------------

let g:nvim_ipy_perform_mappings = 0
let g:ipy_celldef = '# %%'

map <silent> <c-s> <Plug>(IPy-Run)
map <silent> <leader>c <Plug>(IPy-RunCell)

" -- IRON-REPL ----------------------------------------------------------------

nmap <leader>v <Plug>(iron-visual-send)
nmap <leader>l <Plug>(iron-send-line)

" Send cell to IronRepl and move to next cell.
nmap ]x ctrih/^# %%<CR><CR>

luafile $HOME/.config/nvim/plugins.lua

" -- JUPYTER NOTEBOOK ---------------------------------------------------------

function! GetKernelFromPipenv()
    let l:kernel = tolower(system('basename $(pipenv --venv)'))
    " Remove control characters (most importantly newline)
    return substitute(l:kernel, '[[:cntrl:]]', '', 'g')
endfunction

function! StartConsolePipenv(console)
    let l:flags = '--kernel ' . GetKernelFromPipenv()
    let l:command=a:console . ' ' . l:flags
    call jobstart(l:command)
endfunction

function! AddFilepathToSyspath()
    let l:filepath = expand('%:p:h')
    call IPyRun('import sys; sys.path.append("' . l:filepath . '")')
    echo 'Added ' . l:filepath . ' to pythons sys.path'
endfunction

function! ConnectToPipenvKernel()
    let l:kernel = GetKernelFromPipenv()
    call IPyConnect('--kernel', l:kernel, '--no-window')
endfunction

function! GetPoetryVenv()
    let l:poetry_config = findfile('pyproject.toml', getcwd().';')
    let l:root_path = fnamemodify(l:poetry_config, ':p:h')
    if !empty(l:poetry_config)
        let l:virtualenv_path = system('cd '.l:root_path.' && poetry env list --full-path')
        return l:virtualenv_path
    endif
endfunction

function! GetPipenvVenv()
    let l:pipenv_config = findfile('Pipfile', getcwd().';')
    let l:root_path = fnamemodify(l:pipenv_config, ':p:h')
    if !empty(l:pipenv_config)
        let l:virtualenv_path = system('cd '.l:root_path.' && pipenv --venv 2>/dev/null')
        return l:virtualenv_path
    endif
    return ''
endfunction

function! GetPythonVenv()
    let l:venv_path = GetPoetryVenv()
    if empty(l:venv_path)
        let l:venv_path = GetPipenvVenv()
    endif
    if empty(l:venv_path)
        return v:null
    else
        return l:venv_path
    endif
endfunction

command! -nargs=0 RunQtPipenv call StartConsolePipenv('jupyter qtconsole')
command! -nargs=0 RunQtConsole call jobstart("jupyter qtconsole --existing")
command! -nargs=0 RunPipenvKernel terminal /bin/bash -i -c 'pipenv run python -m ipykernel'
command! -nargs=0 RunPoetryKernel terminal /bin/bash -i -c 'poetry run python -m ipykernel'
command! -nargs=0 ConnectToPipenvKernel call ConnectToPipenvKernel()
command! -nargs=0 ConnectConsole terminal /bin/bash -i -c 'jupyter console --existing'
command! -nargs=0 AddFilepathToSyspath call AddFilepathToSyspath()

" -- VISTA-VIM ----------------------------------------------------------------

function! NearestMethodOrFunction() abort
  return get(b:, 'vista_nearest_method_or_function', '')
endfunction

" How each level is indented and what to prepend.
let g:vista_icon_indent = ["╰─▸ ", "├─▸ "]

" The default icons can't be suitable for all the filetypes, you can extend it as you wish.
let g:vista#renderer#icons = {
\   "function": "\uf794",
\   "variable": "\uf71b",
\  }

"Let Vista run explicitly
autocmd VimEnter * call vista#RunForNearestMethodOrFunction()

fun! TrimWhitespace()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfun

augroup richban
    autocmd!
    autocmd BufWritePre * :call TrimWhitespace()
    " autocmd BufEnter,BufWinEnter,TabEnter *.rs :lua require'lsp_extensions'.inlay_hints{}
    au BufEnter github.com_*.txt set filetype=markdown
augroup END
