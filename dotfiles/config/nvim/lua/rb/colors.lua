-- GRUVBOX
-- vim.o.background = "dark" -- or "light" for light mode
-- vim.cmd([[colorscheme gruvbox]])

-- MATERIAL THEME
vim.g.material_style = "deep ocean"
require('material').setup({
    borders = true
})
vim.cmd([[colorscheme material]])
--toggle the style
vim.api.nvim_set_keymap('n', '<leader>mm', [[<Cmd>lua require('material.functions').toggle_style()<CR>]], { noremap = true, silent = true })
