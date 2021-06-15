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

-- local snippets = require'snippets'
-- local U = require'snippets.utils'
-- snippets.snippets = {
--   lua = {
--     req = [[local ${2:${1|S.v:match"([^.()]+)[()]*$"}} = require '$1']];
--     func = [[function${1|vim.trim(S.v):gsub("^%S"," %0")}(${2|vim.trim(S.v)})$0 end]];
--     ["local"] = [[local ${2:${1|S.v:match"([^.()]+)[()]*$"}} = ${1}]];
--     -- Match the indentation of the current line for newlines.
--     ["for"] = U.match_indentation [[
-- for ${1:i}, ${2:v} in ipairs(${3:t}) do
--   $0
-- end]];
--   };
--   _global = {
--     -- If you aren't inside of a comment, make the line a comment.
--     copyright = U.force_comment [[Copyright (C) Ashkan Kiani ${=os.date("%Y")}]];
--   };
-- }

-- snippets.use_suggested_mappings()

-- -- <c-k> will either expand the current snippet at the word or try to jump to
-- map('i', '<c-k>', '<cmd>lua return require\'snippets\'.expand_or_advance(1)<CR>')
-- -- <c-j> will jump backwards to the previous field.
-- map('i', '<c-j>', '<cmd>lua return require\'snippets\'.advance_snippet(-1)<CR>')

vim.g.vsnip_snippet_dir = '~/.config/nvim/snippets'

vim.g.vsnip_filetypes = {
  javascriptreact = {'typescript', 'html', 'react'},
  typescriptreact = {'typescript', 'html', 'react'}
}

---- EASY MOTION --------------------------------------------------------------

vim.g.comfortable_motion_scroll_down_key = "j"
vim.g.comfortable_motion_scroll_up_key = "k"

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
