-- COLORIZER -----------------------------------------------------------------

require'colorizer'.setup()

-- FIRENVIM -----------------------------------------------------------------

require('plugins/firenvim')

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

vim.g.NERDTreeMinimalMenu = 1
vim.g.NERDTreeMinimalUI = 1
vim.g.NERDTreeShowHidden = 1
vim.g.NERDTreeWinSize = 35
vim.g.NERDTreeDirArrowExpandable = ''
vim.g.NERDTreeDirArrowCollapsible = ''
vim.g.NERDTreeWinPos = "left"
vim.g.NERDTreeNaturalSort = 1
vim.g.NERDTreeIgnore = { ".git$", ".idea$", "node_modules", ".DS_Store", "__pycache__" }

vim.g.DevIconsEnableFoldersOpenClose = 1

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

---- GITGUTTER -------------------------------------------------------------

require('gitsigns').setup {
    signs = {
      add          = {hl = 'GruvboxGreen' , text = '+', numhl='GitSignsAddNr'},
      change       = {hl = 'GruvboxAqua', text = '+', numhl='GitSignsChangeNr'},
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

require('plugins/lightline')

--- TABULARIZE  ---------------------------------------------------------------

map('v', '<Leader>=',  '<cmd>Tab /=<CR>')
map('n', '<Leader>:',  '<cmd>Tab /:\\zs<CR>')
map('v', '<Leader>:',  '<cmd>Tab /:\\zs<CR>')
map('n', '<Leader>=', '<cmd>Tab /=<CR>')

---- LSP ----------------------------------------------------------------------

local ok, msg = pcall(function() require('lsp') end)
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

local actions = require('telescope.actions')
local telescope = require('telescope')

telescope.setup{
    defaults = {
        timeoutlen = 2000,
        mappings = {i = {["<esc>"] = actions.close, }},
        vimgrep_arguments = {
            'rg',
            '--color=never',
            '--no-heading',
            '--with-filename',
            '--line-number',
            '--column',
            '--smart-case'
        },
        prompt_position = "bottom",
        prompt_prefix = ">",
        initial_mode = "insert",
        selection_strategy = "reset",
        sorting_strategy = "ascending",
        layout_strategy = "horizontal",
        layout_defaults = {
            -- TODO add builtin options.
        },
        file_sorter =  require'telescope.sorters'.get_fuzzy_file,
        file_ignore_patterns = {".backup",".swap",".langsevers",".session",".undo","*.git","node_modules","vendor",".cache",".vscode-server",".Desktop",".Documents","classes"},
        generic_sorter =  require'telescope.sorters'.get_generic_fuzzy_sorter,
        shorten_path = true,
        winblend = 0,
        width = 0.75,
        preview_cutoff = 120,
        results_height = 1,
        results_width = 0.8,
        border = {},
        borderchars = { '─', '│', '─', '│', '╭', '╮', '╯', '╰'},
        color_devicons = true,
        use_less = true,
        set_env = { ['COLORTERM'] = 'truecolor' }, -- default = nil,
        file_previewer = require'telescope.previewers'.cat.new, -- For buffer previewer use `require'telescope.previewers'.vim_buffer_cat.new`
        grep_previewer = require'telescope.previewers'.vimgrep.new, -- For buffer previewer use `require'telescope.previewers'.vim_buffer_vimgrep.new`
        qflist_previewer = require'telescope.previewers'.qflist.new, -- For buffer previewer use `require'telescope.previewers'.vim_buffer_qflist.new`

        -- Developer configurations: Not meant for general override
        -- buffer_previewer_maker = require'telescope.previewers'.buffer_previewer_maker
    },
    extensions = {
        fzy_native = {
            override_generic_sorter = false,
            override_file_sorter = true,
        },
    },
}

pcall(require('telescope').load_extension, 'fzy_native')

map('n', '<C-p>', ':lua require(\'telescope.builtin\').git_files()<CR>')
map('n', '<leader>pw', ':lua require(\'telescope.builtin\').grep_string { search = vim.fn.expand("<cword>") }<CR>')
map('n', '<leader>pf', ':lua require(\'telescope.builtin\').find_files()<cr>')
map('n', '<leader>pg', ':lua require(\'telescope.builtin\').live_grep()<cr>')
map('n', '<leader>b', ':lua require(\'telescope.builtin\').buffers()<cr>')
map('n', '<leader>ht', ':lua require(\'telescope.builtin\').help_tags()<cr>')

map('n', '<leader>/h', "<cmd>lua require('telescope.builtin').command_history()<CR>")
map('n', '<leader>/c', "<cmd>lua require('telescope.builtin').commands()<CR>")
map('n', '<leader>/r', "<cmd>lua require('telescope.builtin').registers()<CR>")
map('n', '<leader>/m', "<cmd>lua require('telescope.builtin').marks()<CR>")
map('n', '<leader>/t', "<cmd>lua require('telescope.builtin').treesitter()<CR>")

---- INDENT-LINE --------------------------------------------------------------

vim.g.indentLine_char = '▏'
vim.g.indentLine_color_gui = '#474747'
vim.g.indentLine_enabled = 1

vim.g.vim_json_syntax_conceal = 0
vim.g.vim_markdown_conceal = 0
vim.g.vim_markdown_conceal_code_blocks = 0

---- PYTHON ------------------------------------------------------------------

require('plugins/python')

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

map('n','<leader>V', ':Vista<CR>')

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

print(result)
