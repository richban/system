-- Only non-default options live here. See `:help vim_diff` for Nvim's defaults
-- (hidden, autoindent, incsearch, hlsearch, smarttab, belloff=all, backspace, termguicolors, ...).

vim.o.shell = "zsh"
vim.o.mouse = "a"
vim.o.clipboard = "unnamedplus"

-- Line numbers
vim.o.number = true
vim.o.relativenumber = true
vim.o.cursorline = true

-- Indentation (indentexpr/treesitter handles smart indenting per filetype)
vim.o.tabstop = 2
vim.o.softtabstop = 2
vim.o.shiftwidth = 2
vim.o.expandtab = true

-- Wrapping: wrapped lines keep their indent and break at word boundaries
vim.o.breakindent = true
vim.o.showbreak = string.rep(" ", 3)
vim.o.linebreak = true

-- Search
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.inccommand = "split" -- live preview of :s in a split

-- Files: no swap/backup, persistent undo (stored in stdpath("state")/undo, auto-created)
vim.o.swapfile = false
vim.o.backup = false
vim.o.writebackup = false
vim.o.undofile = true

-- UI
vim.o.scrolloff = 8
vim.o.signcolumn = "yes:2" -- room for both LSP diagnostics and git signs
vim.o.colorcolumn = "88"
vim.o.showtabline = 1
vim.o.showmatch = true -- briefly jump to the matching bracket when inserting one
vim.o.list = true
vim.o.listchars = "eol:¬,tab:>·,trail:~,extends:>,precedes:<"

-- Completion
-- menuone: popup even when there's only one match
-- noselect: don't preselect/insert anything until a selection is made
vim.o.completeopt = "menuone,noselect"
vim.opt.shortmess:append("c") -- don't show "match x of y" completion messages

-- Shorter updatetime makes CursorHold-based features (LSP document highlight,
-- gitsigns line blame) feel responsive. Default is 4000 ms.
vim.o.updatetime = 250

-- Folding with treesitter (all folds open by default)
vim.o.foldmethod = "expr"
vim.o.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.o.foldlevelstart = 99
