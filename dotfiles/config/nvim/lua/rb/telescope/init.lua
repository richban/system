local should_reload = true
local reloader = function()
  if should_reload then
    RELOAD("plenary")
    RELOAD("popup")
    RELOAD("telescope")
  end
end

reloader()

local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")
-- local action_mt = require("telescope.actions.mt")
local themes = require("telescope.themes")

require("telescope").load_extension("workspaces")

local M = {}

-- local set_prompt_to_entry_value = function(prompt_bufnr)
--   local entry = action_state.get_selected_entry()
--   if not entry or not type(entry) == "table" then
--     return
--   end
--
--   action_state.get_current_picker(prompt_bufnr):reset_prompt(entry.ordinal)
-- end

require("telescope").setup({
  defaults = {
    timeoutlen = 2000,
    mappings = { i = { ["<esc>"] = actions.close } },
    vimgrep_arguments = {
      "rg",
      "--color=never",
      "--no-heading",
      "--with-filename",
      "--line-number",
      "--column",
      "--smart-case",
    },
    prompt_prefix = " ",
    selection_caret = " ",
    initial_mode = "insert",
    selection_strategy = "reset",
    sorting_strategy = "ascending",

    layout_strategy = "horizontal",
    layout_config = {
      width = 0.95,
      height = 0.85,
      preview_cutoff = 120,
      prompt_position = "top",
      horizontal = {
        -- width_padding = 0.1,
        -- height_padding = 0.1,
        preview_width = function(_, cols, _)
          if cols > 200 then
            return math.floor(cols * 0.4)
          else
            return math.floor(cols * 0.6)
          end
        end,
      },

      vertical = {
        -- width_padding = 0.05,
        -- height_padding = 1,
        width = 0.9,
        height = 0.95,
        preview_height = 0.5,
      },

      flex = { horizontal = { preview_width = 0.9 } },
    },

    file_sorter = require("telescope.sorters").get_fuzzy_file,
    file_ignore_patterns = {
      ".backup",
      ".swap",
      ".langsevers",
      ".session",
      ".undo",
      "*.git",
      "node_modules",
      "vendor",
      ".vscode-server",
      ".Desktop",
      ".Documents",
      "classes",
    },
    generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
    -- path_display = true,
    winblend = 0,
    border = {},
    borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
    color_devicons = true,
    use_less = true,
    set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,

    file_previewer = require("telescope.previewers").vim_buffer_cat.new, -- For buffer previewer use `require'telescope.previewers'.vim_buffer_cat.new`
    grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new, -- For buffer previewer use `require'telescope.previewers'.vim_buffer_vimgrep.new`
    qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new, -- For buffer previewer use `require'telescope.previewers'.vim_buffer_qflist.new`

    -- Developer configurations: Not meant for general override
    -- buffer_previewer_maker = require'telescope.previewers'.buffer_previewer_maker
  },
  extensions = {
    fzf = {
      fuzzy = true, -- false will only do exact matching
      override_generic_sorter = false,
      override_file_sorter = true,
      case_mode = "smart_case", -- this is default
    },
    -- fzy_native = {
    --     override_generic_sorter = false,
    --     override_file_sorter = true,
    -- },
    media_files = {
      -- filetypes whitelist
      -- defaults to {"png", "jpg", "mp4", "webm", "pdf"}
      filetypes = { "png", "webp", "jpg", "jpeg", "mp4", "pdf" },
      find_cmd = "rg", -- find command (defaults to `fd`)
    },
    fzf_writer = { use_highlighter = false, minimum_grep_characters = 6 },
    frecency = { workspaces = { ["conf"] = "~/Developer/dotfiles/" } },
    project = {
      base_dirs = {
        '~/Developer/mckinsey/planetrics/overdrive',
        '~/Developer/mckinsey/planetrics/planetview-data-import',
        '~/Developer/mckinsey/planetrics/extract-factset-database',
        '~/Developer/mckinsey/planetrics/planetrics-django-backend',
        '~/Developer/mckinsey/planetrics/planetview-infrastructure',
      },
      hidden_files = true, -- default: false
      theme = "dropdown"
    },
    workspaces = {
      -- keep insert mode after selection in the picker, default is false
      keep_insert = true,
    }
  },
})


-- Load the fzy native extension at the start.
-- pcall(require('telescope').load_extension, "fzy_native")
-- require("telescope").load_extension("fzf")
pcall(require('telescope').load_extension, "fzf")

-- github CLI
pcall(require("telescope").load_extension, "gh")
if vim.fn.executable("gh") == 1 then
  pcall(require("telescope").load_extension, "gh")
  pcall(require("telescope").load_extension, "octo")
end

pcall(require("telescope").load_extension, "cheat")
pcall(require("telescope").load_extension, "dap")
pcall(require("telescope").load_extension, "file_browser")
pcall(require("telescope").load_extension, "project")

if pcall(require("telescope").load_extension, "frecency") then
  -- frecency
  vim.cmd([[highlight TelescopeBufferLoaded guifg=yellow]])
end

-- requires github extension
function M.gh_issues()
  local opts = {}
  opts.prompt_title = " Issues"
  -- opts.author = '@me'
  require("telescope").extensions.gh.issues(opts)
end

function M.git_status()
  local opts = themes.get_dropdown({ winblend = 10, border = true, previewer = false, shorten_path = false })

  -- Can change the git icons using this.
  -- opts.git_icons = {
  --   changed = "M"
  -- }

  require("telescope.builtin").git_status(opts)
end

function M.git_commits()
  require("telescope.builtin").git_commits({ winblend = 5 })
end

function M.git_repos()
  require("telescope").extensions.repo.list({})
end

function M.edit_neovim()
  require("telescope.builtin").find_files({
    prompt_title = "~ dotfiles ~",
    shorten_path = false,
    cwd = "~/.dotfiles/dotfiles/config/nvim",

    layout_strategy = "horizontal",
    layout_config = { preview_width = 0.65 },
  })
end

function M.git_branches()
  require("telescope.builtin").git_branches({
    attach_mappings = function(_, map)
      map("i", "<c-d>", actions.git_delete_branch)
      map("n", "<c-d>", actions.git_delete_branch)
      return true
    end,
  })
end

function M.fd()
  require("telescope.builtin").fd()
end

function M.media_files()
  require("telescope").extensions.media_files.media_files()
end

function M.installed_plugins()
  require("telescope.builtin").find_files({ cwd = vim.fn.stdpath("data") .. "/site/pack/packer/start/" })
end

function M.lsp_code_actions()
  local opts = themes.get_dropdown({ winblend = 10, border = true, previewer = false, shorten_path = false })

  require("telescope.builtin").lsp_code_actions(opts)
end

function M.live_grep()
  require("telescope.builtin").live_grep({
    -- shorten_path = true,
    previewer = false,
    fzf_separator = "|>",
  })
end

function M.grep_prompt()
  require("telescope.builtin").grep_string({ shorten_path = true, search = vim.fn.input("Grep String > ") })
end

function M.grep_last_search(opts)
  opts = opts or {}

  -- \<getreg\>\C
  -- -> Subs out the search things
  local register = vim.fn.getreg("/"):gsub("\\<", ""):gsub("\\>", ""):gsub("\\C", "")

  opts.path_display = { "shorten" }
  opts.word_match = "-w"
  opts.search = register

  require("telescope.builtin").grep_string(opts)
end

-- function M.project_search()
--   require('telescope.builtin').find_files {
--     previewer = false,
--     layout_strategy = "vertical",
--     cwd = require('nvim_lsp.util').root_pattern(".git")(vim.fn.expand("%:p")),
--   }
-- end

function M.buffers()
  require("telescope.builtin").buffers({ shorten_path = false })
end

function M.curbuf()
  local opts = themes.get_dropdown({
    winblend = 10,
    border = true,
    previewer = false,
    shorten_path = false,
    -- layout_strategy = 'current_buffer',
  })
  require("telescope.builtin").current_buffer_fuzzy_find(opts)
end

function M.help_tags()
  require("telescope.builtin").help_tags({ show_version = true })
end

function M.search_all_files()
  require("telescope.builtin").find_files({ find_command = { "rg", "--no-ignore", "--files" } })
end

function M.file_explorer()
  local opts

  opts = {
    sorting_strategy = "ascending",
    scroll_strategy = "cycle",
    layout_config = { prompt_position = "top" },

    attach_mappings = function(prompt_bufnr, map)
      local current_picker = action_state.get_current_picker(prompt_bufnr)

      local modify_cwd = function(new_cwd)
        current_picker.cwd = new_cwd
        current_picker:refresh(opts.new_finder(new_cwd), { reset_prompt = true })
      end

      map("i", "-", function()
        modify_cwd(current_picker.cwd .. "/..")
      end)

      map("i", "~", function()
        modify_cwd(vim.fn.expand("~"))
      end)

      local modify_depth = function(mod)
        return function()
          opts.depth = opts.depth + mod

          local this_picker = action_state.get_current_picker(prompt_bufnr)
          this_picker:refresh(opts.new_finder(current_picker.cwd), { reset_prompt = true })
        end
      end

      map("i", "<M-=>", modify_depth(1))
      map("i", "<M-+>", modify_depth(-1))

      map("n", "yy", function()
        local entry = action_state.get_selected_entry()
        vim.fn.setreg("+", entry.value)
      end)

      return true
    end,
  }

  require("telescope.builtin").file_browser(opts)
end

function M.file_browser()
  require "telescope".extensions.file_browser.file_browser({ noremap = true })
end

function M.grep_notes()
  local opts = {}
  opts.hidden = true
  -- opts.file_ignore_patterns = { 'thesaurus/'}
  opts.search_dirs = { "~/Developer/richban.second.brain", "~/Developer/richban.ledger" }
  opts.prompt_prefix = "   "
  opts.prompt_title = " Grep Notes"
  opts.path_display = { "shorten" }
  require("telescope.builtin").live_grep(opts)
end

function M.find_notes()
  require("telescope.builtin").find_files({
    prompt_title = " Find Notes",
    path_display = { "shorten" },
    cwd = "~/Developer/richban.second.brain",
    layout_strategy = "horizontal",
    layout_config = { preview_width = 0.65, width = 0.75 },
  })
end

function M.browse_notes()
  require("telescope.builtin").file_browser({
    prompt_title = " Browse Notes",
    prompt_prefix = " ﮷ ",
    cwd = "~/Developer/richban.second.brain",
    layout_strategy = "horizontal",
    layout_config = { preview_width = 0.65, width = 0.75 },
  })
end

function M.find_configs()
  require("telescope.builtin").find_files({
    prompt_title = " NVim & Term Config Find",
    results_title = "Config Files Results",
    path_display = { "shorten" },
    search_dirs = { "~/.dotfiles", "~/.config" },
    cwd = "~/.config/",
    layout_strategy = "horizontal",
    layout_config = { preview_width = 0.65, width = 0.75 },
  })
end

return setmetatable({}, {
  __index = function(_, k)
    reloader()

    if M[k] then
      return M[k]
    else
      return require("telescope.builtin")[k]
    end
  end,
})
