-- FIRENVIM -----------------------------------------------------------------

require('plugins/_firenvim')

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

map('n','<leader>ml', '<cmd>Marks<CR>')

---- NERDTree -----------------------------------------------------------------

vim.g.NERDTreeMinimalMenu = 0
vim.g.NERDTreeMinimalUI = 0
vim.g.NERDTreeShowHidden = 1
vim.g.NERDTreeWinSize = 35
vim.g.NERDTreeDirArrowExpandable = ''
vim.g.NERDTreeDirArrowCollapsible = ''
vim.g.NERDTreeWinPos = "left"
vim.g.NERDTreeNaturalSort = 1
vim.g.NERDTreeIgnore = { ".git$", ".idea$", "node_modules" }

-- Indicate every single untracked file under an untracked dir
vim.g.NERDTreeGitStatusUntrackedFilesMode = 'all'
-- To hide the boring brackets ([ ])
vim.g.NERDTreeGitStatusConcealBrackets = 0

map('n','<leader>n', ':NERDTreeToggle<CR>')

---- VIM-FUGITIVE -------------------------------------------------------------

map('n', '<Leader>gs', '<cmd>Gstatus<CR>')
map('n', '<Leader>gvd', '<cmd>Gvdiffsplit<CR>')
map('n', '<leader>gl', '<cmd>diffget //3<CR>')
map('n', '<leader>gh', '<cmd>diffget //2<CR>')

--- LIGHTLINE  ---------------------------------------------------------------

require('plugins/_lightline')

--- TABULARIZE  ---------------------------------------------------------------

map('n', '<Leader>=', '<cmd>Tab /=<CR>')
map('v', '<Leader>=',  '<cmd>Tab /=<CR>')
map('n', '<Leader>:',  '<cmd>Tab /:\\zs<CR>')
map('v', '<Leader>:',  '<cmd>Tab /:\\zs<CR>')

---- LSP ----------------------------------------------------------------------

require('lsp')

---- EASY MOTION --------------------------------------------------------------

vim.g.comfortable_motion_scroll_down_key = "j"
vim.g.comfortable_motion_scroll_up_key = "k"

---- TELESCOPE ----------------------------------------------------------------

require('telescope').setup{
  defaults = {
    prompt_position = "bottom",
    prompt_prefix = ">",
    selection_strategy = "reset",
    sorting_strategy = "descending",
    layout_strategy = "horizontal",
    width = 0.75,
  }
}

map('n', '<C-p>', ':lua require(\'telescope.builtin\').git_files()<CR>')
map('n', '<leader>tw', ':lua require(\'telescope.builtin\').grep_string { search = vim.fn.expand("<cword>") }<CR>')
map('n', '<leader>tf', ':lua require(\'telescope.builtin\').find_files()<cr>')
map('n', '<leader>tg', ':lua require(\'telescope.builtin\').live_grep()<cr>')
map('n', '<leader>tb', ':lua require(\'telescope.builtin\').buffers()<cr>')
map('n', '<leader>tt', ':lua require(\'telescope.builtin\').help_tags()<cr>')

---- INDENT-LINE --------------------------------------------------------------

vim.g.indentLine_char = '▏'
vim.g.indentLine_color_gui = '#474747'
vim.g.indentLine_enabled = 1

vim.g.vim_json_syntax_conceal = 0
vim.g.vim_markdown_conceal = 0
vim.g.vim_markdown_conceal_code_blocks = 0

---- PYTHON ------------------------------------------------------------------

require('plugins/_python')

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

---- FUNCTIONS ------------------------------------------------------------------

vim.api.nvim_exec([[
  fun! TrimWhitespace()
      let l:save = winsaveview()
      keeppatterns %s/\s\+$//e
      call winrestview(l:save)
  endfun
]], '')
