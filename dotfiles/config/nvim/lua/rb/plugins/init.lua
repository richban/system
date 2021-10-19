-- COLORIZER -----------------------------------------------------------------

require'colorizer'.setup()

-- FIRENVIM -----------------------------------------------------------------

require('rb.plugins.firenvim')

-- TMUX-NAVIGATOR ------------------------------------------------------------

-- Disable tmux navigator when zooming the Vim pane
vim.g.tmux_navigator_disable_when_zoomed = 1

---- FZF ----------------------------------------------------------------------

vim.g.fzf_layout = {
  window = {
    width = 0.9,
    height = 0.9
  }
}

vim.g.fzf_preview_window = { 'down', 'ctrl-/' }
vim.env.FZF_DEFAULT_OPTS = '--reverse'

---- File Tree -----------------------------------------------------------------

-- NERDTREE
-- vim.g.NERDTreeMinimalMenu = 1
-- vim.g.NERDTreeMinimalUI = 1
-- vim.g.NERDTreeShowHidden = 1
-- vim.g.NERDTreeWinSize = 35
-- vim.g.NERDTreeDirArrowExpandable = ''
-- vim.g.NERDTreeDirArrowCollapsible = ''
-- vim.g.NERDTreeWinPos = "left"
-- vim.g.NERDTreeNaturalSort = 1
-- vim.g.NERDTreeIgnore = { ".git$", ".idea$", "node_modules", ".DS_Store", "__pycache__" }
-- vim.g.DevIconsEnableFoldersOpenClose = 1
-- -- Indicate every single untracked file under an untracked dir
-- vim.g.NERDTreeGitStatusUntrackedFilesMode = 'all'
-- -- To hide the boring brackets ([ ])
-- vim.g.NERDTreeGitStatusConcealBrackets = 0

-- CHADTREE
-- local chadtree_settings = {
--   ["theme.text_colour_set"] =  "env",
--   ["ignore.name_exact"] = {"node_modules", "dist", ".DS_Store", ".directory", "thumbs.db", ".git", "__pycache__"},
--   ["ignore.name_glob"] = {"*.js.map"}
-- }
-- vim.api.nvim_set_var("chadtree_settings", chadtree_settings)
-- map('n','<leader>n', ':CHADopen<CR>')

-- NVIM-TREE
local tree_cb = require'nvim-tree.config'.nvim_tree_callback

vim.g.nvim_tree_ignore = {'.git', 'node_modules', '.cache', '.DS_Store', '.vscode'}
vim.g.nvim_tree_quit_on_open = 0
vim.g.nvim_tree_git_hl = 0
vim.g.nvim_tree_follow  = 1
vim.g.nvim_tree_auto_open = 1
vim.g.nvim_tree_auto_close = 0
vim.g.nvim_tree_highlight_opened_files = 1
vim.g.nvim_tree_group_empty = 1
vim.g.nvim_tree_lsp_diagnostics = 0

vim.g.nvim_tree_show_icons = {
   git = 1,
   folders = 1,
   files = 1,
   folder_arrows = 1
}


vim.g.nvim_tree_bindings = {
      { key = "a",                            cb = tree_cb("create") },
      { key = "d",                            cb = tree_cb("remove") },
      { key = "x",                            cb = tree_cb("cut") },
      { key = "c",                            cb = tree_cb("copy") },
      { key = "p",                            cb = tree_cb("paste") },
      { key = "q",                            cb = tree_cb("close") },
      { key = "-",                            cb = tree_cb("close") },
      { key = {"<CR>", "o", "<2-LeftMouse>"}, cb = tree_cb("edit") },
      { key = {"<2-RightMouse>", "<C-]>"},    cb = tree_cb("cd") },
      { key = "<C-v>",                        cb = tree_cb("vsplit") },
      { key = "<C-x>",                        cb = tree_cb("split") },
      { key = "<C-t>",                        cb = tree_cb("tabnew") },
      { key = "<",                            cb = tree_cb("prev_sibling") },
      { key = ">",                            cb = tree_cb("next_sibling") },
      { key = "P",                            cb = tree_cb("parent_node") },
      { key = "<BS>",                         cb = tree_cb("close_node") },
      { key = "<S-CR>",                       cb = tree_cb("close_node") },
      { key = "<Tab>",                        cb = tree_cb("preview") },
      { key = "K",                            cb = tree_cb("first_sibling") },
      { key = "J",                            cb = tree_cb("last_sibling") },
      { key = "I",                            cb = tree_cb("toggle_ignored") },
      { key = "H",                            cb = tree_cb("toggle_dotfiles") },
      { key = "R",                            cb = tree_cb("refresh") },
      { key = "r",                            cb = tree_cb("rename") },
      { key = "<C-r>",                        cb = tree_cb("full_rename") },
      { key = "y",                            cb = tree_cb("copy_name") },
      { key = "Y",                            cb = tree_cb("copy_path") },
      { key = "gy",                           cb = tree_cb("copy_absolute_path") },
      { key = "[c",                           cb = tree_cb("prev_git_item") },
      { key = "]c",                           cb = tree_cb("next_git_item") },
      { key = "g?",                           cb = tree_cb("toggle_help") },
    }

map('n','<leader>n', ':NvimTreeToggle<CR>')

---- GITGUTTER -------------------------------------------------------------

require('gitsigns').setup {
    signs = {
      add          = {hl = 'GitSignsAdd'   , text = '│', numhl='GitSignsAddNr'   , linehl='GitSignsAddLn'},
      change       = {hl = 'GitSignsChange', text = '│', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
      delete       = {hl = 'GitSignsDelete', text = '_', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
      topdelete    = {hl = 'GitSignsDelete', text = '‾', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
      changedelete = {hl = 'GitSignsChange', text = '~', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
    },
    signcolumn = true,  -- Toggle with `:Gitsigns toggle_signs`
    numhl      = false, -- Toggle with `:Gitsigns toggle_numhl`
    linehl     = false, -- Toggle with `:Gitsigns toggle_linehl`
    word_diff  = false, -- Toggle with `:Gitsigns toggle_word_diff`
    keymaps = {
      -- Default keymap options
      noremap = true,
      buffer = true,

      ['n ]h'] = { expr = true, "&diff ? ']c' : '<cmd>lua require\"gitsigns\".next_hunk()<CR>'"},
      ['n [h'] = { expr = true, "&diff ? '[c' : '<cmd>lua require\"gitsigns\".prev_hunk()<CR>'"},

      ['n <leader>hs'] = '<cmd>lua require"gitsigns".stage_hunk()<CR>',
      ['n <leader>hu'] = '<cmd>lua require"gitsigns".undo_stage_hunk()<CR>',
      ['n <leader>hr'] = '<cmd>lua require"gitsigns".reset_hunk()<CR>',
      ['n <leader>hp'] = '<cmd>lua require"gitsigns".preview_hunk()<CR>',
     
      ['n <leader>hb'] = '<cmd>lua require"gitsigns".blame_line()<CR>',
      ['n <leader>hS'] = '<cmd>lua require"gitsigns".stage_buffer()<CR>',
    },

    watch_index = {
      interval = 1000,
      follow_files = true
    },

    attach_to_untracked = true,
    current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
    current_line_blame_opts = {
      virt_text = true,
      virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
      delay = 1000,
    },

    current_line_blame_formatter_opts = {
      relative_time = false
    },
    
    sign_priority = 6,
    update_debounce = 100,
    status_formatter = nil, -- Use default
    max_file_length = 40000,
    preview_config = {
      -- Options passed to nvim_open_win
      border = 'single',
      style = 'minimal',
      relative = 'cursor',
      row = 0,
      col = 1
    },
    yadm = {
      enable = false
    },
}


---- VIM-FUGITIVE -------------------------------------------------------------

map('n', '<leader>gs', '<cmd>Git<CR>')
map('n', '<leader>gd', '<cmd>Gvdiffsplit<CR>')
map('n', '<leader>gb', '<cmd>Git blame<CR>')
map('n', '<leader>gh', '<cmd>0Gclog!<CR>')
map('n', '<leader>gj', '<cmd>diffget //2<CR>')
map('n', '<leader>gk', '<cmd>diffget //3<CR>')

--- STATUSLINE  ----------------------------------------------------------------

-- require('rb.plugins.lightline')
-- require('rb.plugins.statusline')

---- LSP ----------------------------------------------------------------------

local ok, msg = pcall(function() require('rb.lsp') end)
if not ok then
  print(msg)
end

---- Snippets ----------------------------------------------------------------------

vim.g.vsnip_snippet_dir = '~/.config/nvim/snippets'

vim.g.vsnip_filetypes = {
  javascriptreact = {'typescript', 'html', 'react'},
  typescriptreact = {'typescript', 'html', 'react'}
}

---- MOTION --------------------------------------------------------------

-- vim.g.comfortable_motion_scroll_down_key = "j"
-- vim.g.comfortable_motion_scroll_up_key = "k"
require('neoscroll').setup()

---- TELESCOPE ----------------------------------------------------------------

require('rb.telescope')
require('rb.telescope.mappings')

--- TABULARIZE  ---------------------------------------------------------------

map('v', '<leader>=',  '<cmd>Tab /=<CR>')
map('n', '<leader>:',  '<cmd>Tab /:\\zs<CR>')
map('v', '<leader>:',  '<cmd>Tab /:\\zs<CR>')
map('n', '<leader>=', '<cmd>Tab /=<CR>')

---- INDENT-LINE --------------------------------------------------------------

-- vim.g.indentLine_char = '▏'
-- vim.g.indentLine_color_gui = '#474747'
-- vim.g.indentLine_enabled = 1
-- vim.g.indentLine_setConceal = 0

-- vim.g.vim_json_syntax_conceal = 0
-- vim.g.vim_markdown_conceal = 0
-- vim.g.vim_markdown_conceal_code_blocks = 0

-- Simple
-- vim.opt.list = true
-- vim.opt.listchars = {
--     eol = "↴",
-- }

-- require("indent_blankline").setup {
--     show_end_of_line = true,
-- }

-- With context indent highlighted by treesitter
vim.opt.list = true
vim.opt.listchars = {
    space = "⋅",
    eol = "↴",
}

require("indent_blankline").setup {
    space_char_blankline = " ",
    show_current_context = true,
}

---- PYTHON ------------------------------------------------------------------

require('rb.plugins.python')

---- VISTA-VIM ----------------------------------------------------------------

vim.api.nvim_exec([[
  function! NearestMethodOrFunction() abort
    return get(b:, 'vista_nearest_method_or_function', '')
  endfunction

  " How each level is indented and what to prepend.
  let g:vista_icon_indent = ["╰─▸ ", "├─▸ "]

  " The default icons can't be suitable for all the filetypes, you can extend it as you wish.
  let g:vista#renderer#icons = { "function": "\uf794", "variable": "\uf71b" }
]], '')

---- TREESITTER ----------------------------------------------------------------

-- https://github.com/tree-sitter/tree-sitter-haskell#building-on-macos
require'nvim-treesitter.install'.compilers = { "gcc" }

local treesitter = require'nvim-treesitter.configs'

treesitter.setup {
  ensure_installed = "all",
  highlight = {
    enable = true,
  },
}

---- FUNCTIONS ------------------------------------------------------------------

local result = vim.api.nvim_exec([[
  fun! TrimWhitespace()
      let l:save = winsaveview()
      keeppatterns %s/\s\+$//e
      call winrestview(l:save)
  endfun
]], true)

---- AUTOPAIRS ------------------------------------------------------------------

local present1, autopairs = pcall(require, 'nvim-autopairs')
local present2, autopairs_completion = pcall(require, 'nvim-autopairs.completion.cmp')

if not (present1 or present2) then
	return
end

autopairs.setup()
autopairs_completion.setup({
  map_cr = true, --  map <CR> on insert mode
  map_complete = true, -- it will auto insert `(` (map_char) after select function or method item
  auto_select = true, -- automatically select the first item
  insert = false, -- use insert confirm behavior instead of replace
  map_char = { -- modifies the function or method delimiter by filetypes
    all = '(',
    tex = '{'
  }
})