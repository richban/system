local M = {
  "zbirenbaum/copilot.lua",
  enabled = true,
  event = "InsertEnter",
  config = function()
    M.config()
  end,
}

function M.config()
  require("copilot").setup({
    event = "InsertEnter",
    panel = {
      enabled = true,
      auto_refresh = true,
      keymap = {
        jump_prev = "[[",
        jump_next = "]]",
        accept = "<CR>",
        refresh = "gr",
        open = "<M-CR>",
      },
      layout = {
        position = "bottom", -- | top | left | right
        ratio = 0.4,
      },
    },
    suggestion = {
      enabled = false,
      auto_trigger = false,
      debounce = 75,
      keymap = {
        accept = "<M-l>",
        accept_word = false,
        accept_line = false,
        next = "<M-]>",
        prev = "<M-[>",
        dismiss = "<C-]>",
      },
    },
    filetypes = {
      python = true,
      yaml = false,
      markdown = false,
      help = false,
      gitcommit = true,
      gitrebase = false,
      hgcommit = false,
      svn = false,
      cvs = false,
      ["."] = false,
    },
    copilot_node_command = "node", -- Node.js version must be > 18.x
    server_opts_overrides = {
      trace = "verbose",
      settings = {
        advanced = {
          listCount = 10, -- #completions for panel
          inlineSuggestCount = 3, -- #completions for getCompletions
        },
      },
    },
  })
end

function M.test() end

return M
