-- theme
-- gruvbox
-- vim.g.background = 'dark'
-- vim.g.gruvbox_material_background = 'hard'
-- vim.g.gruvbox_material_enable_italic = 1
-- vim.g.gruvbox_material_enable_bold = 1
-- vim.g.gruvbox_material_better_performance = 1
-- vim.g.gruvbox_material_palette = 'mix'
-- -- vim.g.gruvbox_material_sign_column_background = 'none'
-- vim.cmd('colorscheme gruvbox-material')


-- vim.o.background = "dark" -- or "light" for light mode
-- vim.cmd([[colorscheme gruvbox]])

vim.g.material_style = "deep ocean"
require('material').setup({
    borders = true
})
vim.cmd([[colorscheme material]])
--toggle the style
vim.api.nvim_set_keymap('n', '<leader>mm', [[<Cmd>lua require('material.functions').toggle_style()<CR>]], { noremap = true, silent = true })
