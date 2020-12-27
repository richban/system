local setup = function()
    require('utils')
    require'settings'.setup()
    require'mappings'.setup()
    require'autocmd'.setup()
    require'plugins'
    require('plugins/init')
end

setup()
