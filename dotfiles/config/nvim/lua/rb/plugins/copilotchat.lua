local M = {
  "CopilotC-Nvim/CopilotChat.nvim",
  event = "VeryLazy",
  branch = "main",
  dependencies = {
    { "zbirenbaum/copilot.lua" }, -- or github/copilot.vim
    { "nvim-lua/plenary.nvim" }, -- for curl, log wrapper
  },
  config = function()
    M.config()
    M.mappings()
  end,
}

function M.quick_chat()
  local input = vim.fn.input("Quick Chat: ")
  if input ~= "" then
    vim.cmd("CopilotChatBuffer " .. tostring(input)) -- Convert if necessary
  end
end

function M.mappings()
  local keys = {
    { "<leader>ccb", "<cmd>CopilotChatBuffer<cr>", desc = "CopilotChat - Chat with current buffer" },
    { "<leader>cce", "<cmd>CopilotChatExplain<cr>", desc = "CopilotChat - Explain code" },
    { "<leader>cct", "<cmd>CopilotChatTests<cr>", desc = "CopilotChat - Generate tests" },
    {
      "<leader>ccT",
      "<cmd>CopilotChatVsplitToggle<cr>",
      desc = "CopilotChat - Toggle Vsplit", -- Toggle vertical split
    },
    {
      "<leader>ccv",
      ":CopilotChatVisual",
      mode = "x",
      desc = "CopilotChat - Open in vertical split",
    },
    {
      "<leader>ccx",
      ":CopilotChatInPlace<cr>",
      mode = "x",
      desc = "CopilotChat - Run in-place code",
    },
    {
      "<leader>ccf",
      "<cmd>CopilotChatFixDiagnostic<cr>", -- Get a fix for the diagnostic message under the cursor.
      desc = "CopilotChat - Fix diagnostic",
    },
    {
      "<leader>ccr",
      "<cmd>CopilotChatReset<cr>", -- Reset chat history and clear buffer.
      desc = "CopilotChat - Reset chat history and clear buffer",
    },
  }
  -- Iterate through your key mappings and set them
  for _, keymap in ipairs(keys) do
    vim.api.nvim_set_keymap(keymap.mode or "", keymap[1], keymap[2], {
      noremap = true,
      silent = true,
      desc = keymap.desc,
    })
  end

  -- To chat with Copilot using the entire content of the buffer
  vim.api.nvim_set_keymap(
    "n",
    "<leader>ccq",
    ":lua require('rb.Copilotchat').quick_chat()<CR>",
    { noremap = true, silent = true, desc = "CopilotChat - Help actions" }
  )

  -- Mapping 1: Show Help Actions
  vim.api.nvim_set_keymap(
    "n",
    "<leader>cch",
    ":lua require('CopilotChat.code_actions').show_help_actions()<CR>",
    { noremap = true, silent = true, desc = "CopilotChat - Help actions" }
  )

  -- Mapping 2: Show Prompt Actions (Normal Mode)
  vim.api.nvim_set_keymap(
    "n",
    "<leader>ccp",
    ":lua require('CopilotChat.code_actions').show_prompt_actions()<CR>",
    { noremap = true, silent = true, desc = "CopilotChat - Prompt actions" }
  )

  -- Mapping 3: Show Prompt Actions (Visual Mode)
  vim.api.nvim_set_keymap(
    "x",
    "<leader>ccp",
    ":lua require('CopilotChat.code_actions').show_prompt_actions(true)<CR>",
    { noremap = true, silent = true, desc = "CopilotChat - Prompt actions" }
  )
end

function M.config()
  local copilot_chat = require("CopilotChat")
  copilot_chat.setup({
    debug = true,
    show_help = "yes",
    prompts = {
      Explain = "Explain how it works by Japanese language.",
      Review = "Review the following code and provide concise suggestions.",
      Tests = "Briefly explain how the selected code works, then generate unit tests.",
      Refactor = "Refactor the code to improve clarity and readability.",
    },
    build = function()
      vim.notify("Please update the remote plugins by running ':UpdateRemotePlugins', then restart Neovim.")
    end,
    event = "VeryLazy",
  })
end

function M.test() end

return M
