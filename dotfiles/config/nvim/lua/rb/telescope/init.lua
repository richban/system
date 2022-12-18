SHOULD_RELOAD_TELESCOPE = false
local reloader = function()
  if SHOULD_RELOAD_TELESCOPE then
    RELOAD "plenary"
    RELOAD "telescope"
    RELOAD "rb.telescope.setup"
  end
end

local actions = require "telescope.actions"
local action_state = require "telescope.actions.state"
local themes = require "telescope.themes"

M = {}

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
