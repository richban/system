local map = vim.api.nvim_set_keymap

local tree_cb = require'nvim-tree.config'.nvim_tree_callback

vim.g.nvim_tree_indent_markers = 1
vim.g.nvim_tree_quit_on_open = 0
vim.g.nvim_tree_git_hl = 0
vim.g.nvim_tree_highlight_opened_files = 1
vim.g.nvim_tree_group_empty = 1
vim.g.nvim_tree_show_icons = {git = 1, folders = 1, files = 1, folder_arrows = 1}

local nvim_tree_bindings = {
  {key = "a", cb = tree_cb("create")}, {key = "d", cb = tree_cb("remove")}, {key = "x", cb = tree_cb("cut")}, {key = "c", cb = tree_cb("copy")},
  {key = "p", cb = tree_cb("paste")}, {key = "q", cb = tree_cb("close")}, {key = "-", cb = tree_cb("close")},
  {key = {"<CR>", "o", "<2-LeftMouse>"}, cb = tree_cb("edit")}, {key = {"<2-RightMouse>", "<C-]>"}, cb = tree_cb("cd")},
  {key = "<C-v>", cb = tree_cb("vsplit")}, {key = "<C-x>", cb = tree_cb("split")}, {key = "<C-t>", cb = tree_cb("tabnew")},
  {key = "<", cb = tree_cb("prev_sibling")}, {key = ">", cb = tree_cb("next_sibling")}, {key = "P", cb = tree_cb("parent_node")},
  {key = "<BS>", cb = tree_cb("close_node")}, {key = "<S-CR>", cb = tree_cb("close_node")}, {key = "<Tab>", cb = tree_cb("preview")},
  {key = "K", cb = tree_cb("first_sibling")}, {key = "J", cb = tree_cb("last_sibling")}, {key = "I", cb = tree_cb("toggle_ignored")},
  {key = "H", cb = tree_cb("toggle_dotfiles")}, {key = "R", cb = tree_cb("refresh")}, {key = "r", cb = tree_cb("rename")},
  {key = "<C-r>", cb = tree_cb("full_rename")}, {key = "y", cb = tree_cb("copy_name")}, {key = "Y", cb = tree_cb("copy_path")},
  {key = "gy", cb = tree_cb("copy_absolute_path")}, {key = "[c", cb = tree_cb("prev_git_item")}, {key = "]c", cb = tree_cb("next_git_item")},
  {key = "g?", cb = tree_cb("toggle_help")}
}

require'nvim-tree'.setup {
  diagnostics = {enable = false, icons = {hint = "", info = "", warning = "", error = ""}},
  -- view = {
  --   mappings = {
  --     custom_only = false,
  --     list = nvim_tree_bindings
  --   }
  -- },
  filters = {
    dotfiles = false,
    custom = {
      '.git', 'node_modules', '.cache', '.DS_Store', '.vscode', '__pycache__', '*.pyc', '*~', '.ropeproject', '.hg', '.svn', '_svn', '.tox',
      '.pytest_cache', '.benchmarks', '.venv', 'venv'
    }
  }
}

map('n', '<leader>n', ':NvimTreeToggle<CR>', {noremap = true, silent = false})
map('n', '<leader>nr', ':NvimTreeRefresh<CR>', {noremap = true, silent = false})