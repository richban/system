-- Automatically generated packer.nvim plugin loader code

if vim.api.nvim_call_function('has', {'nvim-0.5'}) ~= 1 then
  vim.api.nvim_command('echohl WarningMsg | echom "Invalid Neovim version for packer.nvim! | echohl None"')
  return
end

vim.api.nvim_command('packadd packer.nvim')

local no_errors, error_msg = pcall(function()

  local time
  local profile_info
  local should_profile = false
  if should_profile then
    local hrtime = vim.loop.hrtime
    profile_info = {}
    time = function(chunk, start)
      if start then
        profile_info[chunk] = hrtime()
      else
        profile_info[chunk] = (hrtime() - profile_info[chunk]) / 1e6
      end
    end
  else
    time = function(chunk, start) end
  end
  
local function save_profiles(threshold)
  local sorted_times = {}
  for chunk_name, time_taken in pairs(profile_info) do
    sorted_times[#sorted_times + 1] = {chunk_name, time_taken}
  end
  table.sort(sorted_times, function(a, b) return a[2] > b[2] end)
  local results = {}
  for i, elem in ipairs(sorted_times) do
    if not threshold or threshold and elem[2] > threshold then
      results[i] = elem[1] .. ' took ' .. elem[2] .. 'ms'
    end
  end

  _G._packer = _G._packer or {}
  _G._packer.profile_output = results
end

time([[Luarocks path setup]], true)
local package_path_str = "/Users/rbanyi/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?.lua;/Users/rbanyi/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?/init.lua;/Users/rbanyi/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?.lua;/Users/rbanyi/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/Users/rbanyi/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

time([[Luarocks path setup]], false)
time([[try_loadstring definition]], true)
local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s))
  if not success then
    vim.schedule(function()
      vim.api.nvim_notify('packer.nvim: Error running ' .. component .. ' for ' .. name .. ': ' .. result, vim.log.levels.ERROR, {})
    end)
  end
  return result
end

time([[try_loadstring definition]], false)
time([[Defining packer_plugins]], true)
_G.packer_plugins = {
  ["FixCursorHold.nvim"] = {
    loaded = true,
    path = "/Users/rbanyi/.local/share/nvim/site/pack/packer/start/FixCursorHold.nvim"
  },
  ["ISuckAtSpelling.nvim"] = {
    loaded = true,
    path = "/Users/rbanyi/.local/share/nvim/site/pack/packer/start/ISuckAtSpelling.nvim"
  },
  LuaSnip = {
    config = { "\27LJ\2\n3\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\24rb.plugins.snippets\frequire\0" },
    loaded = true,
    path = "/Users/rbanyi/.local/share/nvim/site/pack/packer/start/LuaSnip"
  },
  ["cmp-buffer"] = {
    after_files = { "/Users/rbanyi/.local/share/nvim/site/pack/packer/opt/cmp-buffer/after/plugin/cmp_buffer.lua" },
    load_after = {
      ["nvim-cmp"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/Users/rbanyi/.local/share/nvim/site/pack/packer/opt/cmp-buffer"
  },
  ["cmp-nvim-lsp"] = {
    after_files = { "/Users/rbanyi/.local/share/nvim/site/pack/packer/opt/cmp-nvim-lsp/after/plugin/cmp_nvim_lsp.lua" },
    load_after = {
      ["nvim-cmp"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/Users/rbanyi/.local/share/nvim/site/pack/packer/opt/cmp-nvim-lsp"
  },
  ["cmp-nvim-lua"] = {
    after_files = { "/Users/rbanyi/.local/share/nvim/site/pack/packer/opt/cmp-nvim-lua/after/plugin/cmp_nvim_lua.lua" },
    load_after = {
      ["nvim-cmp"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/Users/rbanyi/.local/share/nvim/site/pack/packer/opt/cmp-nvim-lua"
  },
  ["cmp-path"] = {
    after_files = { "/Users/rbanyi/.local/share/nvim/site/pack/packer/opt/cmp-path/after/plugin/cmp_path.lua" },
    load_after = {
      ["nvim-cmp"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/Users/rbanyi/.local/share/nvim/site/pack/packer/opt/cmp-path"
  },
  cmp_luasnip = {
    after_files = { "/Users/rbanyi/.local/share/nvim/site/pack/packer/opt/cmp_luasnip/after/plugin/cmp_luasnip.lua" },
    load_after = {
      ["nvim-cmp"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/Users/rbanyi/.local/share/nvim/site/pack/packer/opt/cmp_luasnip"
  },
  delimitMate = {
    loaded = true,
    path = "/Users/rbanyi/.local/share/nvim/site/pack/packer/start/delimitMate"
  },
  ["editorconfig-vim"] = {
    loaded = true,
    path = "/Users/rbanyi/.local/share/nvim/site/pack/packer/start/editorconfig-vim"
  },
  firenvim = {
    loaded = true,
    path = "/Users/rbanyi/.local/share/nvim/site/pack/packer/start/firenvim"
  },
  ["friendly-snippets"] = {
    loaded = true,
    path = "/Users/rbanyi/.local/share/nvim/site/pack/packer/start/friendly-snippets"
  },
  fzf = {
    loaded = true,
    path = "/Users/rbanyi/.local/share/nvim/site/pack/packer/start/fzf"
  },
  ["fzf.vim"] = {
    loaded = true,
    path = "/Users/rbanyi/.local/share/nvim/site/pack/packer/start/fzf.vim"
  },
  ["github-nvim-theme"] = {
    loaded = true,
    path = "/Users/rbanyi/.local/share/nvim/site/pack/packer/start/github-nvim-theme"
  },
  ["gitsigns.nvim"] = {
    loaded = true,
    path = "/Users/rbanyi/.local/share/nvim/site/pack/packer/start/gitsigns.nvim"
  },
  ["goyo.vim"] = {
    loaded = true,
    path = "/Users/rbanyi/.local/share/nvim/site/pack/packer/start/goyo.vim"
  },
  ["gruvbox.nvim"] = {
    loaded = true,
    path = "/Users/rbanyi/.local/share/nvim/site/pack/packer/start/gruvbox.nvim"
  },
  indentLine = {
    loaded = true,
    path = "/Users/rbanyi/.local/share/nvim/site/pack/packer/start/indentLine"
  },
  ["iron.nvim"] = {
    loaded = true,
    path = "/Users/rbanyi/.local/share/nvim/site/pack/packer/start/iron.nvim"
  },
  ["lsp-status.nvim"] = {
    loaded = true,
    path = "/Users/rbanyi/.local/share/nvim/site/pack/packer/start/lsp-status.nvim"
  },
  ["lsp_extensions.nvim"] = {
    loaded = true,
    path = "/Users/rbanyi/.local/share/nvim/site/pack/packer/start/lsp_extensions.nvim"
  },
  ["lsp_signature.nvim"] = {
    loaded = true,
    path = "/Users/rbanyi/.local/share/nvim/site/pack/packer/start/lsp_signature.nvim"
  },
  ["lspkind-nvim"] = {
    loaded = true,
    path = "/Users/rbanyi/.local/share/nvim/site/pack/packer/start/lspkind-nvim"
  },
  ["lspsaga.nvim"] = {
    loaded = true,
    path = "/Users/rbanyi/.local/share/nvim/site/pack/packer/start/lspsaga.nvim"
  },
  ["lualine.nvim"] = {
    loaded = true,
    path = "/Users/rbanyi/.local/share/nvim/site/pack/packer/start/lualine.nvim"
  },
  ["lush.nvim"] = {
    loaded = true,
    path = "/Users/rbanyi/.local/share/nvim/site/pack/packer/start/lush.nvim"
  },
  ["markdown-preview.nvim"] = {
    commands = { "MarkdownPreview" },
    loaded = false,
    needs_bufread = false,
    path = "/Users/rbanyi/.local/share/nvim/site/pack/packer/opt/markdown-preview.nvim"
  },
  ["material.nvim"] = {
    loaded = true,
    path = "/Users/rbanyi/.local/share/nvim/site/pack/packer/start/material.nvim"
  },
  ["neoscroll.nvim"] = {
    loaded = true,
    path = "/Users/rbanyi/.local/share/nvim/site/pack/packer/start/neoscroll.nvim"
  },
  ["nvim-autopairs"] = {
    load_after = {
      ["nvim-cmp"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/Users/rbanyi/.local/share/nvim/site/pack/packer/opt/nvim-autopairs"
  },
  ["nvim-cmp"] = {
    after = { "nvim-autopairs", "cmp-buffer", "cmp-nvim-lsp", "cmp-nvim-lua", "cmp-path", "cmp_luasnip" },
    config = { "\27LJ\2\n3\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\24rb.plugins.nvim-cmp\frequire\0" },
    loaded = false,
    needs_bufread = false,
    path = "/Users/rbanyi/.local/share/nvim/site/pack/packer/opt/nvim-cmp"
  },
  ["nvim-colorizer.lua"] = {
    loaded = true,
    path = "/Users/rbanyi/.local/share/nvim/site/pack/packer/start/nvim-colorizer.lua"
  },
  ["nvim-ipy"] = {
    loaded = true,
    path = "/Users/rbanyi/.local/share/nvim/site/pack/packer/start/nvim-ipy"
  },
  ["nvim-lsp-ts-utils"] = {
    loaded = true,
    path = "/Users/rbanyi/.local/share/nvim/site/pack/packer/start/nvim-lsp-ts-utils"
  },
  ["nvim-lspconfig"] = {
    loaded = true,
    path = "/Users/rbanyi/.local/share/nvim/site/pack/packer/start/nvim-lspconfig"
  },
  ["nvim-lspfuzzy"] = {
    loaded = true,
    path = "/Users/rbanyi/.local/share/nvim/site/pack/packer/start/nvim-lspfuzzy"
  },
  ["nvim-treesitter"] = {
    loaded = true,
    path = "/Users/rbanyi/.local/share/nvim/site/pack/packer/start/nvim-treesitter"
  },
  ["nvim-web-devicons"] = {
    loaded = true,
    path = "/Users/rbanyi/.local/share/nvim/site/pack/packer/start/nvim-web-devicons"
  },
  nvim_context_vt = {
    loaded = true,
    path = "/Users/rbanyi/.local/share/nvim/site/pack/packer/start/nvim_context_vt"
  },
  ["octo.nvim"] = {
    loaded = true,
    path = "/Users/rbanyi/.local/share/nvim/site/pack/packer/start/octo.nvim"
  },
  ["packer.nvim"] = {
    loaded = true,
    path = "/Users/rbanyi/.local/share/nvim/site/pack/packer/start/packer.nvim"
  },
  ["plenary.nvim"] = {
    loaded = true,
    path = "/Users/rbanyi/.local/share/nvim/site/pack/packer/start/plenary.nvim"
  },
  ["popup.nvim"] = {
    loaded = true,
    path = "/Users/rbanyi/.local/share/nvim/site/pack/packer/start/popup.nvim"
  },
  ["sql.nvim"] = {
    loaded = true,
    path = "/Users/rbanyi/.local/share/nvim/site/pack/packer/start/sql.nvim"
  },
  ["startuptime.vim"] = {
    loaded = true,
    path = "/Users/rbanyi/.local/share/nvim/site/pack/packer/start/startuptime.vim"
  },
  tabular = {
    loaded = true,
    path = "/Users/rbanyi/.local/share/nvim/site/pack/packer/start/tabular"
  },
  ["telescope-cheat.nvim"] = {
    loaded = true,
    path = "/Users/rbanyi/.local/share/nvim/site/pack/packer/start/telescope-cheat.nvim"
  },
  ["telescope-frecency.nvim"] = {
    config = { "\27LJ\2\nM\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0'\2\3\0B\0\2\1K\0\1\0\rfrecency\19load_extension\14telescope\frequire\0" },
    loaded = true,
    path = "/Users/rbanyi/.local/share/nvim/site/pack/packer/start/telescope-frecency.nvim"
  },
  ["telescope-fzf-writer.nvim"] = {
    loaded = true,
    path = "/Users/rbanyi/.local/share/nvim/site/pack/packer/start/telescope-fzf-writer.nvim"
  },
  ["telescope-fzy-native.nvim"] = {
    loaded = true,
    path = "/Users/rbanyi/.local/share/nvim/site/pack/packer/start/telescope-fzy-native.nvim"
  },
  ["telescope-media-files.nvim"] = {
    loaded = true,
    path = "/Users/rbanyi/.local/share/nvim/site/pack/packer/start/telescope-media-files.nvim"
  },
  ["telescope-packer.nvim"] = {
    loaded = true,
    path = "/Users/rbanyi/.local/share/nvim/site/pack/packer/start/telescope-packer.nvim"
  },
  ["telescope.nvim"] = {
    loaded = true,
    path = "/Users/rbanyi/.local/share/nvim/site/pack/packer/start/telescope.nvim"
  },
  ["todo-comments.nvim"] = {
    config = { "\27LJ\2\n?\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\18todo-comments\frequire\0" },
    loaded = true,
    path = "/Users/rbanyi/.local/share/nvim/site/pack/packer/start/todo-comments.nvim"
  },
  undotree = {
    loaded = true,
    path = "/Users/rbanyi/.local/share/nvim/site/pack/packer/start/undotree"
  },
  ["vim-beancount"] = {
    loaded = true,
    path = "/Users/rbanyi/.local/share/nvim/site/pack/packer/start/vim-beancount"
  },
  ["vim-commentary"] = {
    loaded = true,
    path = "/Users/rbanyi/.local/share/nvim/site/pack/packer/start/vim-commentary"
  },
  ["vim-devicons"] = {
    loaded = true,
    path = "/Users/rbanyi/.local/share/nvim/site/pack/packer/start/vim-devicons"
  },
  ["vim-easymotion"] = {
    loaded = true,
    path = "/Users/rbanyi/.local/share/nvim/site/pack/packer/start/vim-easymotion"
  },
  ["vim-fugitive"] = {
    loaded = true,
    path = "/Users/rbanyi/.local/share/nvim/site/pack/packer/start/vim-fugitive"
  },
  ["vim-jsdoc"] = {
    loaded = true,
    path = "/Users/rbanyi/.local/share/nvim/site/pack/packer/start/vim-jsdoc"
  },
  ["vim-man"] = {
    loaded = true,
    path = "/Users/rbanyi/.local/share/nvim/site/pack/packer/start/vim-man"
  },
  ["vim-pydocstring"] = {
    loaded = true,
    path = "/Users/rbanyi/.local/share/nvim/site/pack/packer/start/vim-pydocstring"
  },
  ["vim-python-pep8-indent"] = {
    loaded = true,
    path = "/Users/rbanyi/.local/share/nvim/site/pack/packer/start/vim-python-pep8-indent"
  },
  ["vim-repeat"] = {
    loaded = true,
    path = "/Users/rbanyi/.local/share/nvim/site/pack/packer/start/vim-repeat"
  },
  ["vim-sneak"] = {
    loaded = true,
    path = "/Users/rbanyi/.local/share/nvim/site/pack/packer/start/vim-sneak"
  },
  ["vim-startify"] = {
    loaded = true,
    path = "/Users/rbanyi/.local/share/nvim/site/pack/packer/start/vim-startify"
  },
  ["vim-surround"] = {
    loaded = true,
    path = "/Users/rbanyi/.local/share/nvim/site/pack/packer/start/vim-surround"
  },
  ["vim-tmux-navigator"] = {
    loaded = true,
    path = "/Users/rbanyi/.local/share/nvim/site/pack/packer/start/vim-tmux-navigator"
  },
  ["vim-wakatime"] = {
    loaded = true,
    path = "/Users/rbanyi/.local/share/nvim/site/pack/packer/start/vim-wakatime"
  },
  ["vista.vim"] = {
    loaded = true,
    path = "/Users/rbanyi/.local/share/nvim/site/pack/packer/start/vista.vim"
  }
}

time([[Defining packer_plugins]], false)
-- Config for: telescope-frecency.nvim
time([[Config for telescope-frecency.nvim]], true)
try_loadstring("\27LJ\2\nM\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0'\2\3\0B\0\2\1K\0\1\0\rfrecency\19load_extension\14telescope\frequire\0", "config", "telescope-frecency.nvim")
time([[Config for telescope-frecency.nvim]], false)
-- Config for: LuaSnip
time([[Config for LuaSnip]], true)
try_loadstring("\27LJ\2\n3\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\24rb.plugins.snippets\frequire\0", "config", "LuaSnip")
time([[Config for LuaSnip]], false)
-- Config for: todo-comments.nvim
time([[Config for todo-comments.nvim]], true)
try_loadstring("\27LJ\2\n?\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\18todo-comments\frequire\0", "config", "todo-comments.nvim")
time([[Config for todo-comments.nvim]], false)

-- Command lazy-loads
time([[Defining lazy-load commands]], true)
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file MarkdownPreview lua require("packer.load")({'markdown-preview.nvim'}, { cmd = "MarkdownPreview", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]])
time([[Defining lazy-load commands]], false)

vim.cmd [[augroup packer_load_aucmds]]
vim.cmd [[au!]]
  -- Event lazy-loads
time([[Defining lazy-load event autocommands]], true)
vim.cmd [[au InsertEnter * ++once lua require("packer.load")({'nvim-cmp'}, { event = "InsertEnter *" }, _G.packer_plugins)]]
time([[Defining lazy-load event autocommands]], false)
vim.cmd("augroup END")
if should_profile then save_profiles() end

end)

if not no_errors then
  vim.api.nvim_command('echohl ErrorMsg | echom "Error in packer_compiled: '..error_msg..'" | echom "Please check your config for correctness" | echohl None')
end
