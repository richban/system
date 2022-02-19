local key_map = vim.api.nvim_set_keymap

-- COLORIZER -----------------------------------------------------------------
-- FIRENVIM -----------------------------------------------------------------

if vim.g.started_by_firenvim then
  vim.g.laststatus = 0

  key_map('n', '<Esc><Esc>', '=call firenvim#focus_page()<CR>', {noremap = true, silent = true})
  key_map('n', '<C-z>', '=write<CR>=call firenvim#hide_frame()<CR>', {noremap = true, silent = true})

  vim.g.firenvim_config = {
    globalSettings = {alt = 'all'},
    localSettings = {
      [".*"] = {cmdline = 'neovim', priority = 0, selector = 'textarea', takeover = 'always'}
      -- ['https://youtube.com*'] = { 'takeover': 'never', 'priority': 1 },
      -- ['https?://instagram.com*'] = { 'takeover': 'never', 'priority': 1 },
      -- ['https?://twitter.com.*'] = { 'takeover': 'never', 'priority': 1 },
      -- ['https://.*gmail.com*'] = { 'takeover': 'never', 'priority': 1 },
      -- ['https://.*google.com*'] = { 'takeover': 'never', 'priority': 1 },
      -- ['https?://.*twitch.tv*'] = { 'takeover': 'never', 'priority': 1 },
      -- ['https?://notion.so*'] = { 'takeover': 'never', 'priority': 1 },
      -- ['https?://reddit.com*'] = { 'takeover': 'never', 'priority': 1 },
    }
  }

  vim.cmd('au BufEnter github.com_*.txt set filetype=markdown')
end

-- TMUX-NAVIGATOR ------------------------------------------------------------
-- Disable tmux navigator when zooming the Vim pane
vim.g.tmux_navigator_disable_when_zoomed = 1

---- FZF ----------------------------------------------------------------------

vim.g.fzf_layout = {window = {width = 0.9, height = 0.9}}

vim.g.fzf_preview_window = {'down', 'ctrl-/'}
vim.env.FZF_DEFAULT_OPTS = '--reverse'

---- File Tree -----------------------------------------------------------------

---- GITGUTTER ---------------------------------------------------------------

---- VIM-FUGITIVE -------------------------------------------------------------

key_map('n', '<leader>gs', '<cmd>Git<CR>', {noremap = true, silent = true})
key_map('n', '<leader>gd', '<cmd>Gvdiffsplit<CR>', {noremap = true, silent = true})
key_map('n', '<leader>gb', '<cmd>Git blame<CR>', {noremap = true, silent = true})
key_map('n', '<leader>gh', '<cmd>0Gclog!<CR>', {noremap = true, silent = true})
key_map('n', '<leader>gj', '<cmd>diffget //2<CR>', {noremap = true, silent = true})
key_map('n', '<leader>gk', '<cmd>diffget //3<CR>', {noremap = true, silent = true})

--- STATUSLINE  ----------------------------------------------------------------

---- LSP ----------------------------------------------------------------------

---- Snippets ----------------------------------------------------------------------

vim.g.vsnip_snippet_dir = '~/.config/nvim/snippets'
vim.g.vsnip_filetypes = {javascriptreact = {'typescript', 'html', 'react'}, typescriptreact = {'typescript', 'html', 'react'}}

---- MOTION --------------------------------------------------------------

-- vim.g.comfortable_motion_scroll_down_key = "j"
-- vim.g.comfortable_motion_scroll_up_key = "k"
require('neoscroll').setup()

---- TELESCOPE ----------------------------------------------------------------

require('rb.telescope')
require('rb.telescope.mappings')

--- TABULARIZE  ---------------------------------------------------------------

key_map('v', '<leader>=', '<cmd>Tab /=<CR>', {noremap = true, silent = true})
key_map('n', '<leader>:', '<cmd>Tab /:\\zs<CR>', {noremap = true, silent = true})
key_map('v', '<leader>:', '<cmd>Tab /:\\zs<CR>', {noremap = true, silent = true})
key_map('n', '<leader>=', '<cmd>Tab /=<CR>', {noremap = true, silent = true})

---- INDENT-LINE --------------------------------------------------------------

---- PYTHON ------------------------------------------------------------------

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

---- AUTOPAIRS -----------------------------------------------------------------

---- ANNOTATIONS ---------------------------------------------------------------

-- require('nvim-biscuits').setup({
--   default_config = {
--     max_length = 12,
--     min_distance = 5,
--     -- prefix_string = " 🌜 "
--     prefix_string = ""
--   },
--   language_config = {html = {prefix_string = " 🌐 "}, javascript = {prefix_string = " ✨ ", max_length = 80}, python = {disabled = true}}
-- })

---- DASHBOARD -----------------------------------------------------------------

---- FORMATTER -----------------------------------------------------------------

---- BUFFERLINE ----------------------------------------------------------------

require("bufferline").setup {}
vim.cmd [[
  nnoremap <silent><TAB> :BufferLineCycleNext<CR>
  nnoremap <silent><S-TAB> :BufferLineCyclePrev<CR>
]]

---- JUPYTEXT -----------------------------------------------------------------
vim.g.jupytext_fmt = 'py'
vim.g.jupytext_style = 'hydrogen'

---- JUPYTER ASCENDING --------------------------------------------------------

vim.cmd [[ nnoremap <silent><c-x> <Plug>JupyterExecute ]]
vim.cmd [[ nnoremap <silent><c-X> <Plug>JupyterExecuteAll ]]

---- NVIM-IPY -----------------------------------------------------------------

vim.g.nvim_ipy_perform_mappings = 0
vim.g.ipy_celldef = '# %%'

vim.cmd [[map <silent><c-s> <Plug>(IPy-Run)]]
vim.cmd [[map <leader>rc <Plug>(IPy-RunCell)]]

---- IRON-REPL ----------------------------------------------------------------

local iron = require('iron')

iron.core.add_repl_definitions {python = {venv_python = {command = "pipenv run ipython"}}}

iron.core.set_config {preferred = {python = "venv_python"}}

-- vim.cmd [[nnoremap <silent><c-v> <Plug>(iron-visual-send)]]
-- vim.cmd [[nnoremap <C-l> <Plug>(iron-send-line)]]

-- " Send cell to IronRepl and move to next cell.
vim.cmd [[nmap ]x ctrih/^# %%<CR><CR>]]
vim.cmd [[nmap [x ctrah/^# %%<CR><CR>]]

