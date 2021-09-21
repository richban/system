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

local chadtree_settings = {
  ["theme.text_colour_set"] =  "env",
  ["ignore.name_exact"] = {"node_modules", "dist", ".DS_Store", ".directory", "thumbs.db", ".git", "__pycache__"},
  ["ignore.name_glob"] = {"*.js.map"}
}

vim.api.nvim_set_var("chadtree_settings", chadtree_settings)

map('n','<leader>n', ':CHADopen<CR>')

---- GITGUTTER -------------------------------------------------------------

require('gitsigns').setup {
    signs = {
      add          = {hl = 'GruvboxGreen' , text = '│', numhl='GitSignsAddNr'},
      change       = {hl = 'GruvboxAqua', text = '│', numhl='GitSignsChangeNr'},
      delete       = {hl = 'GruvboxRed', text = '_', numhl='GitSignsDeleteNr'},
      topdelete    = {hl = 'GruvboxRed', text = '‾', numhl='GitSignsDeleteNr'},
      changedelete = {hl = 'GruvboxAqua', text = '~', numhl='GitSignsChangeNr'},
    },
    numhl = false,
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
    },
    watch_index = {
      interval = 1000
    },
    sign_priority = 9,
    status_formatter = nil, -- Use default
}

--- STATUSLINE  ----------------------------------------------------------------

-- require('rb.plugins.lightline')
require('rb.plugins.statusline')

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

---- INDENT-LINE --------------------------------------------------------------

vim.g.indentLine_char = '▏'
vim.g.indentLine_color_gui = '#474747'
vim.g.indentLine_enabled = 1

vim.g.indentLine_setConceal = 0
-- vim.g.vim_json_syntax_conceal = 0
-- vim.g.vim_markdown_conceal = 0
-- vim.g.vim_markdown_conceal_code_blocks = 0

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