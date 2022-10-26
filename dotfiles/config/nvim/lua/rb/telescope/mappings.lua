if not pcall(require, "telescope") then
  return
end

local sorters = require("telescope.sorters")

TelescopeMapArgs = TelescopeMapArgs or {}

local map_tele = function(key, f, options, buffer)
  local map_key = vim.api.nvim_replace_termcodes(key .. f, true, true, true)

  TelescopeMapArgs[map_key] = options or {}

  local mode = "n"
  local rhs = string.format("<cmd>lua R('rb.telescope')['%s'](TelescopeMapArgs['%s'])<CR>", f, map_key)

  local map_options = { noremap = true, silent = true }

  if not buffer then
    vim.keymap.set(mode, key, rhs, map_options)
  else
    vim.api.nvim_buf_set_keymap(0, mode, key, rhs, map_options)
  end
end

vim.keymap.set("c", "<c-r><c-r>", "<Plug>(TelescopeFuzzyCommandSearch)", { noremap = false, nowait = true })

-- Dotfiles
map_tele("<leader>en", "edit_neovim")
map_tele("<leader>ec", "find_configs")

-- Search
map_tele("<leader>gw", "grep_string", {
  short_path = true,
  word_match = "-w",
  only_sort_text = true,
  layout_strategy = "vertical",
  sorter = sorters.get_fzy_sorter(),
})
map_tele("<leader>f/", "grep_last_search", { layout_strategy = "vertical" })

-- Files
map_tele("<C-p>", "git_files")
map_tele("<leader>bg", "live_grep")
map_tele("<leader>ed", "fd")
map_tele("<leader>ea", "search_all_files")
map_tele("<leader>e", "file_explorer")
map_tele("<leader>em", "media_files")

map_tele("<leader>fb", "file_browser")
-- Nvim
map_tele("<C-b>", "buffers")
map_tele("<leader>ep", "installed_plugins")
map_tele("<leader>bf", "curbuf")
map_tele("<leader>th", "help_tags")

-- Git
-- map_tele("<space>gs", "git_status")
map_tele("<space>er", "git_repos")
map_tele("<space>gc", "git_commits")
map_tele("<space>gb", "git_branches")

map_tele("<leader>so", "vim_options")
map_tele("<leader>gp", "grep_prompt")

map_tele("<leader>/c", "commands")
map_tele("<leader>/r", "registers")
map_tele("<leader>/m", "marks")
map_tele("<leader>/t", "treesitter")

-- Telescope Meta
map_tele("<leader>fB", "builtin")

-- Notes
map_tele("<leader>gn", "grep_notes")
-- map_tele("<leader>nf", "find_notes")
-- map_tele("<leader>ne", "browse_notes")

return map_tele
