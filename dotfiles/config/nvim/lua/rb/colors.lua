-- GRUVBOX
-- vim.o.background = "dark" -- or "light" for light mode
-- vim.cmd([[colorscheme gruvbox]])

-- MATERIAL THEME
-- vim.g.material_style = "deep ocean"
-- require('material').setup({
--     borders = true
-- })
-- vim.cmd([[colorscheme material]])
-- --toggle the style
-- vim.api.nvim_set_keymap('n', '<leader>mm', [[<Cmd>lua require('material.functions').toggle_style()<CR>]], { noremap = true, silent = true })

-- Github theme
require("github-theme").setup({
    theme_style = "dark_default",
    comment_style = "italic",
    sidebars = {"qf", "vista_kind", "terminal", "packer"},
  
    -- Change the "hint" color to the "orange" color, and make the "error" color bright red
    colors = {hint = "orange", error = "#ff0000"}
})