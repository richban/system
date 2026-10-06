return {
  {
    "Shatur/neovim-session-manager",
    dependencies = { "nvim-lua/plenary.nvim" },
    lazy = false,
    priority = 100,
    init = function()
      -- Save state of plugins and local options in sessions
      vim.opt.sessionoptions:append("globals")
      vim.opt.sessionoptions:append("localoptions")
    end,
    opts = function()
      local config = require("session_manager.config")
      return {
        autoload_mode = config.AutoloadMode.Disabled, -- Don't auto-restore on bare startup; Snacks projects handles project loading
        autosave_last_session = true, -- Auto-save active session on exit/switch
        autosave_ignore_dirs = {
          vim.fn.expand("~"),
          "/tmp",
        },
      }
    end,
    keys = {
      { "<leader>ps", "<cmd>SessionManager save_current_session<CR>", desc = "Save Project Session" },
      { "<leader>pl", "<cmd>SessionManager load_session<CR>", desc = "Load Session" },
      { "<leader>po", "<cmd>SessionManager load_last_session<CR>", desc = "Open Last Session" },
      { "<leader>px", "<cmd>SessionManager delete_session<CR>", desc = "Delete Project Session" },
      {
        "<leader>pd",
        function()
          local root = (Snacks and Snacks.git and Snacks.git.get_root())
            or vim.fn.fnamemodify(vim.fn.finddir(".git", ".;"), ":h")
          if root and root ~= "" then
            vim.cmd("cd " .. root)
            print("Changed to project root: " .. root)
          else
            print("No project root found")
          end
        end,
        desc = "Go to Project Root Directory",
      },
    },
  },
}
