local settings = {}

require('os')
local path_sep = vim.loop.os_uname().sysname == "Windows" and "\\" or "/"
local function path_join(...)
    return table.concat(vim.tbl_flatten {...}, path_sep)
end

function settings.setup()
    if vim.fn.has('vim_starting') == 1 then
        vim.cmd('syntax enable')
    end

    vim.o.nu = true
    vim.o.mouse = 'a'
    vim.o.hidden = true
    vim.o.errorbells = false
    vim.o.encoding= 'utf-8'
    vim.o.inccommand = 'split'
    vim.o.belloff = 'all' -- Just turn the dang bell off

    vim.o.tabstop = 2
    vim.o.softtabstop = 2
    vim.o.shiftwidth = 2

    vim.o.expandtab = true
    vim.o.smartindent = true
    vim.o.smarttab = true
    vim.o.autoindent = true
    -- vim.o.wrap = true

    vim.o.breakindent    = true
    vim.o.showbreak      = string.rep(' ', 3) -- Make it so that long lines wrap smartly
    vim.o.linebreak      = true

    vim.o.backspace = 'indent,eol,start'
    vim.o.number = true
    vim.o.relativenumber = true

    vim.o.incsearch = true
    vim.o.hlsearch = true
    vim.o.ignorecase = true
    vim.o.smartcase = true

    vim.o.termguicolors = true
    vim.o.emoji = false

    vim.o.swapfile = false
    vim.o.backup = false
    vim.o.writebackup = false
    vim.o.ttyfast = true
    vim.o.clipboard = 'unnamedplus'

    vim.o.undodir = path_join(os.getenv("HOME"), "/.config/undodir")
    vim.o.undofile = true

    vim.o.scrolloff = 8
    -- lsp and git column
    vim.o.signcolumn = 'yes:2'
    vim.o.colorcolumn = '80'

    vim.o.scl = 'yes'
    vim.o.inccommand     = 'split'
    vim.o.showtabline = 1
    vim.o.showmatch      = true  -- show matching brackets when text indicator is over them
    -- makes scrolling faster
    vim.o.lazyredraw = true
    vim.o.cursorline = true
    vim.o.cursorcolumn = false
    -- menuone: popup even when there's only one match
    -- noinsert: Do not insert text until a selection is made
    -- noselect: Do not select, force user to select one from the menu
    vim.o.completeopt = 'menuone,noinsert,noselect'
    -- Don't show the dumb matching stuff.
    vim.cmd [[set shortmess+=c]]
    -- Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
    -- delays and poor user experience.
    vim.o.updatetime = 50
    vim.g.mapleader = ' '
    -- providers
    vim.g.python_host_prog = path_join(os.getenv("HOME"), ".pyenv/versions/neovim2/bin/python")
    vim.g.python3_host_prog = path_join(os.getenv("HOME"), ".pyenv/versions/neovim3/bin/python")
    vim.g.pydocstring_doq_path = path_join(os.getenv("HOME"), ".pyenv/versions/neovim3/bin/doq")
    vim.g.pydocstring_formatter = "google"
    vim.g.lsp_settings_servers_dir = vim.fn.stdpath("cache") .. "/lspconfig"

    -- shows spaces
    vim.o.list = true
    vim.o.listchars= 'eol:¬,tab:>·,trail:~,extends:>,precedes:<'

    vim.g.markdown_fenced_languages = { "html", "javascript", "typescript", "css", "scss", "lua", "vim" }
    vim.g.cursorhold_updatetime = 100

    -- Give more space for displaying messages.
    vim.o.cmdheight = 1

    -- using treesitter for folding
    -- vim.wo.foldmethod = 'expr'
    -- vim.wo.foldexpr = 'nvim_treesitter#foldexpr()'

end

return settings
