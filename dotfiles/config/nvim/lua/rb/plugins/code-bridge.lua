return {
  "samir-roy/code-bridge.nvim",
  config = function()
    require("code-bridge").setup({
      -- Plugin configuration options
      tmux_session = "coding",
      tmux_window = "claude",
      clipboard_fallback = true,
    })

    -- Key mappings
    vim.keymap.set("n", "<leader>ct", ":CodeBridgeTmux<CR>", { desc = "Send context to Claude via tmux" })
    vim.keymap.set("n", "<leader>cq", ":CodeBridgeQuery<CR>", { desc = "Interactive query with context" })
    vim.keymap.set("n", "<leader>cc", ":CodeBridgeChat<CR>", { desc = "General chat without context" })
    vim.keymap.set("v", "<leader>ct", ":CodeBridgeTmux<CR>", { desc = "Send visual selection to Claude via tmux" })
  end,
}
