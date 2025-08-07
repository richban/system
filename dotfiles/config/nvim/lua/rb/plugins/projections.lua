-- | Keybinding | Command                              | Description                     |
-- |------------|--------------------------------------|---------------------------------|
-- | <leader>pp | :NeovimProjectDiscover               | Projects - Find all projects    |
-- | <leader>pr | :NeovimProjectHistory                | Recent - Show project history   |
-- | <leader>po | :NeovimProjectLoadRecent             | Open - Load most recent project |
-- | <leader>ps | :SessionSave                        | Save - Save current session     |
-- | <leader>pl | :SessionLoad                        | Load - Load session picker      |
-- | <leader>pd | Go to project root                   | Directory - Navigate to root    |
-- | <leader>px | :SessionDelete                      | X - Delete project session      |

return {
  "coffebar/neovim-project",
  opts = {
    projects = { -- define project roots based on your previous workspaces
      "~/.nixpkgs", -- your main nixpkgs config
      "~/Developer/*", -- your development projects
      "~/.config/*", -- config directories
    },
    picker = {
      type = "telescope", -- using telescope as you had before
    },
    -- Session management settings
    session_manager_opts = {
      autosave_ignore_dirs = {
        vim.fn.expand("~"), -- don't save sessions for home directory
        "/tmp",
      },
    },
    -- Project detection patterns (similar to your previous patterns)
    detection_methods = { "pattern" },
    patterns = { ".git", ".svn", ".hg", "Cargo.toml", "package.json", "go.mod" },
  },
  init = function()
    -- enable saving the state of plugins in the session (matching your previous setup)
    vim.opt.sessionoptions:append("globals") -- save global variables
    vim.opt.sessionoptions:append("localoptions") -- save local options (from your previous config)
  end,
  config = function(_, opts)
    require("neovim-project").setup(opts)

    -- Project management keybindings under <leader>p prefix
    vim.keymap.set("n", "<leader>pp", ":NeovimProjectDiscover<CR>", { desc = "Find Projects" })
    vim.keymap.set("n", "<leader>pr", ":NeovimProjectHistory<CR>", { desc = "Recent Projects" })
    vim.keymap.set("n", "<leader>po", ":NeovimProjectLoadRecent<CR>", { desc = "Open Recent Project" })
    -- Session management
    vim.keymap.set("n", "<leader>ps", ":SessionSave<CR>", { desc = "Save Project Session" })
    vim.keymap.set("n", "<leader>pl", ":SessionLoad<CR>", { desc = "Load Session" })
    -- Delete current project session
    vim.keymap.set("n", "<leader>px", ":SessionDelete<CR>", { desc = "Delete Project Session" })
    -- Project root navigation
    vim.keymap.set("n", "<leader>pd", function()
      local project_root = vim.fn.fnamemodify(vim.fn.finddir(".git", ".;"), ":h")
      if project_root ~= "" then
        vim.cmd("cd " .. project_root)
        print("Changed to project root: " .. project_root)
      else
        print("No project root found")
      end
    end, { desc = "Go to Project Root Directory" })
  end,
  dependencies = {
    { "nvim-lua/plenary.nvim" },
    { "nvim-telescope/telescope.nvim" }, -- removed version tag to use latest
    { "Shatur/neovim-session-manager" },
  },
  lazy = false,
  priority = 100,
}
