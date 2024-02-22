-- bufferline.lua
local M = {
  "akinsho/bufferline.nvim",
  config = function()
    vim.opt.termguicolors = true
    require("bufferline").setup({
      options = {
        numbers = function(opts)
          return string.format("%s", opts.lower(opts.ordinal))
        end,
        diagnostics = "nvim_lsp",
        show_tab_indicators = true,
        offsets = {
          {
            filetype = "NvimTree",
            text = "File Explorer",
            highlight = "Directory",
            separator = true,
          },
        },
        separator_style = "slant",
        indicator = {
          style = "underline",
        },
      },
    })
    vim.api.nvim_set_keymap("n", "<TAB>", ":BufferLineCycleNext<CR>", { noremap = true, silent = true })
    vim.api.nvim_set_keymap("n", "<S-TAB>", ":BufferLineCyclePrev<CR>", { noremap = true, silent = true })
  end,
}

return M
