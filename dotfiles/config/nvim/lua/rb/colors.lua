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

-- vim.cmd [[
--   augroup DraculaOverrides
--       autocmd!
--       autocmd ColorScheme dracula highlight DraculaBoundary guibg=none
--       autocmd ColorScheme dracula highlight DraculaDiffDelete ctermbg=none guibg=none
--       autocmd ColorScheme dracula highlight DraculaComment cterm=italic gui=italic
--       autocmd User PlugLoaded ++nested colorscheme dracula
--   augroup end
-- ]]

-- https://github.com/Mofiqul/dracula.nvim
vim.o.termguicolors = true

vim.g.dracula_show_end_of_buffer = true  -- default false, Turn on or off EndOfBuffer symbol
vim.g.dracula_transparent_bg = true -- default false, enables transparent background
vim.cmd[[colorscheme dracula]]
