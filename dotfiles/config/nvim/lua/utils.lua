function nvim_create_augroups(definitions)
    for group_name, definition in pairs(definitions) do
        vim.api.nvim_command('augroup '..group_name)
        vim.api.nvim_command('autocmd!')
        for _, def in ipairs(definition) do
        local command = table.concat(vim.tbl_flatten{'autocmd', def}, ' ')
        vim.api.nvim_command(command)
        end
        vim.api.nvim_command('augroup END')
    end
end

function map(mode, lhs, rhs, opts)
    options = vim.tbl_extend('keep', opts or {}, {
        noremap = true,
        silent = true,
        expr = false
    })
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- reload_module = require('plenary.reload').reload_module

-- reload = function(name)
--     reload_module(name)
--     return require(name)
-- end
