if not pcall(require, 'telescope') then
  return
end

local should_reload = true
local reloader = function()
  if should_reload then
    RELOAD('plenary')
    RELOAD('popup')
    RELOAD('telescope')
  end
end

reloader()

local actions = require('telescope.actions')
local telescope = require('telescope')
local sorters = require('telescope.sorters')
local themes = require('telescope.themes')


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
        prompt_prefix = '❯ ',
        selection_caret = '❯ ',
        initial_mode = "insert",
        selection_strategy = "reset",
        sorting_strategy = "descending",
        layout_strategy = "horizontal",
         layout_defaults = {
            horizontal = {
              width_padding = 0.1,
              height_padding = 0.1,
              preview_width = 0.6,
            },
            vertical = {
              width_padding = 0.05,
              height_padding = 1,
              preview_height = 0.5,
            }
          },
        file_sorter =  sorters.get_fzy_sorter,
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
        file_previewer = require('telescope.previewers').vim_buffer_cat.new, -- For buffer previewer use `require'telescope.previewers'.vim_buffer_cat.new`
        grep_previewer = require('telescope.previewers').vim_buffer_vimgrep.new, -- For buffer previewer use `require'telescope.previewers'.vim_buffer_vimgrep.new`
        qflist_previewer = require('telescope.previewers').vim_buffer_qflist.new, -- For buffer previewer use `require'telescope.previewers'.vim_buffer_qflist.new`

        -- Developer configurations: Not meant for general override
        -- buffer_previewer_maker = require'telescope.previewers'.buffer_previewer_maker
    },
    extensions = {
        fzy_native = {
            override_generic_sorter = false,
            override_file_sorter = true,
        },
        media_files = {
          -- filetypes whitelist
          -- defaults to {"png", "jpg", "mp4", "webm", "pdf"}
          filetypes = {"png", "webp", "jpg", "jpeg"},
          find_cmd = "rg" -- find command (defaults to `fd`)
        },
        fzf_writer = {
          use_highlighter = false,
          minimum_grep_characters = 6,
        },
        frecency = {
          workspaces = {
            ["conf"] = "~/.config/nvim/",
          }
        }
    },
}

-- Load the fzy native extension at the start.
pcall(require('telescope').load_extension, "fzy_native")
pcall(require('telescope').load_extension, "gh")
pcall(require('telescope').load_extension, "cheat")
pcall(require('telescope').load_extension, "dap")

require('telescope').load_extension('octo')

if pcall(require('telescope').load_extension, 'frecency') then
  -- frecency
  vim.cmd [[highlight TelescopeBufferLoaded guifg=yellow]]
end

local M = {}

function M.edit_neovim()
  require('telescope.builtin').find_files {
    prompt_title = "~ dotfiles ~",
    shorten_path = false,
    cwd = "~/.dotfiles/dotfiles/config/nvim",

    layout_strategy = 'horizontal',
    layout_config = {
      preview_width = 0.65,
    },
  }
end

M.git_branches = function()
    require("telescope.builtin").git_branches({
        attach_mappings = function(_, map)
            map('i', '<c-d>', actions.git_delete_branch)
            map('n', '<c-d>', actions.git_delete_branch)
            return true
        end
    })
end

function M.fd()
  require('telescope.builtin').fd()
end

function M.media_files()
  require('telescope').extensions.media_files.media_files()
end


function M.lsp_code_actions()
  local opts = themes.get_dropdown {
    winblend = 10,
    border = true,
    previewer = false,
    shorten_path = false,
  }

  require('telescope.builtin').lsp_code_actions(opts)
end

function M.live_grep()
 require('telescope').extensions.fzf_writer.staged_grep {
   shorten_path = true,
   previewer = false,
   fzf_separator = "|>",
 }
end

function M.grep_prompt()
  require('telescope.builtin').grep_string {
    shorten_path = true,
    search = vim.fn.input("Grep String > "),
  }
end

function M.grep_last_search(opts)
  opts = opts or {}

  -- \<getreg\>\C
  -- -> Subs out the search things
  local register = vim.fn.getreg('/'):gsub('\\<', ''):gsub('\\>', ''):gsub("\\C", "")

  opts.shorten_path = true
  opts.word_match = '-w'
  opts.search = register

  require('telescope.builtin').grep_string(opts)
end

function M.project_search()
  require('telescope.builtin').find_files {
    previewer = false,
    layout_strategy = "vertical",
    cwd = require('nvim_lsp.util').root_pattern(".git")(vim.fn.expand("%:p")),
  }
end

function M.buffers()
  require('telescope.builtin').buffers {
    shorten_path = false,
  }
end

function M.curbuf()
  local opts = themes.get_dropdown {
    winblend = 10,
    border = true,
    previewer = false,
    shorten_path = false,
    -- layout_strategy = 'current_buffer',
  }
  require('telescope.builtin').current_buffer_fuzzy_find(opts)
end

function M.help_tags()
  require('telescope.builtin').help_tags {
    show_version = true,
  }
end

function M.search_all_files()
  require('telescope.builtin').find_files {
    find_command = { 'rg', '--no-ignore', '--files', },
  }
end

function M.file_browser()
  require('telescope.builtin').file_browser {
    sorting_strategy = "ascending",
    scroll_strategy = "cycle",
    prompt_position = "top",
  }
end

return setmetatable({}, {
  __index = function(_, k)
    reloader()

    if M[k] then
      return M[k]
    else
      return require('telescope.builtin')[k]
    end
  end
})
