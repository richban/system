local lsp = require('lspconfig')
local lsp_completion = require('completion')
local lsp_status  = require('lsp-status')
local diagnostics  = require('lsp.diagnostics')

local function on_attach(client)
    lsp_status.onattach(client)
    lsp_completion.on_attach(client)
end

lsp_status.register_progress()

local default_lsp_config = {on_attach = on_attach, capabilities = lsp_status.capabilities}

-- :LspInstall needed
local servers = {
  diagnosticls = diagnostics.options,
  bashls = {},
  vimls = {},
  dockerls = {},
  yamlls = {},
  rust_analyzer = {},
  jsonls = {},
  tsserver = {},
  html = {},
  cssls = {},
  pyls_ms = {},
  sumneko_lua = {
    -- :LspInstallInfo sumneko_lua
    cmd = { '$HOME/.cache/nvim/lspconfig/sumneko_lua/lua-language-server/bin/macOS/lua-language-server' },
    settings = {
        Lua = {
            diagnostics = {
                globals = {
                    'vim',
                   'use',
                    'imap',
                    'nmap',
                    'vmap',
                    'tmap',
                    'inoremap',
                    'nnoremap',
                    'vnoremap',
                    'tnoremap'
                }
            },
            workspace = {
                library = {
                    ['$VIMRUNTIME/lua'] = true,
                }
            }
        }
    }
  },
}

for server, config in pairs(servers) do
  lsp[server].setup(vim.tbl_deep_extend("force", default_lsp_config, config))
end
