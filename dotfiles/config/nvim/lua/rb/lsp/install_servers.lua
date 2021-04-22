local M = {}

M.lsp_install_servers = function()
    local function installLanguageServer(filetype, languageServer)
        if pcall(function() vim.cmd ('set filetype=' .. filetype) end) then
          vim.cmd ('LspInstallServer ' .. languageServer)
        else
          vim.cmd ('LspInstallServer ' .. languageServer)
        end
    end

    -- this are install with npm i -g
    -- installLanguageServer('typescript', 'typescript-language-server')
    installLanguageServer('lua', 'sumneko-lua-language-server')
    -- installLanguageServer('sh', 'bash-language-server')
    -- installLanguageServer('json', 'json-languageserver')
    -- installLanguageServer('yaml', 'yaml-language-server')
    -- installLanguageServer('html', 'html-languageserver')
    -- installLanguageServer('css', 'css-languageserver')
    -- installLanguageServer('python', 'pyls-ms')
    -- installLanguageServer('sql', 'sqls')
    -- installLanguageServer('scala', 'Metals')
    -- installLanguageServer('terraform', 'terraform-lsp')
    -- installLanguageServer('vue', 'vue-language-server')
    -- installLanguageServer('vim', 'vim-language-server')
    -- installLanguageServer('*', 'dockerfile-language-server-nodejs')

    -- must be installed globally
    installLanguageServer('*', 'efm-langserver')
end

return M