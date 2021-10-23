local autocmd = {}

function autocmd.setup()
    local definitions = {
        wins = {
            {'BufNewFile,BufRead', '*.jsx', 'set filetype=javascript.jsx'},
            {'BufNewFile,BufRead', ' *.tsx', 'set filetype=typescript.tsx'},
            {'BufNew,BufEnter', '*.md,*.markdown,*.wiki', 'set conceallevel=0'},
            {'BufNew,BufEnter', '*.html,*.css', 'execute "IndentLinesToggle"'},
            {'TextYankPost', '*', 'lua vim.highlight.on_yank()'},
            -- {'User LspDiagnosticsChanged', '', 'call lightline#update()'},
            -- {'User LspMessageUpdate', '', 'call lightline#update()'},
            -- {'User LspStatusUpdate', '', 'call lightline#update()'},
            {'VimEnter', '*', 'call vista#RunForNearestMethodOrFunction()'},
            {'BufWritePre', '*', 'call TrimWhitespace()'},
            -- show diagnostic popup on cursor hold
            {'CursorHold', '<Buffer>', 'lua vim.lsp.diagnostic.show_line_diagnostics({ show_header = false })'},
            {'BufWritePost', 'plugins.lua', 'PackerCompile'},
        };
        ft = {
            { 'FileType', '*', 'setlocal formatoptions-=c formatoptions-=r formatoptions-=o' },
            { 'FileType', 'css,html,html,javascript,typescript', 'setlocal  tabstop=2 shiftwidth=2 softtabstop=2' },
        };
    }


    -- go to last location when opening a buffer
    vim.cmd [[
        autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | execute "normal! g`\"" | endif
    ]]

    -- Highlight on yank
    vim.api.nvim_exec(
        [[
        augroup YankHighlight
        autocmd!
        autocmd TextYankPost * silent! lua vim.highlight.on_yank()
        augroup end
    ]],
        false
    )


    nvim_create_augroups(definitions)
end

return autocmd
