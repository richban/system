local lsp = require('lspconfig')
-- local lsp_completion = require('completion')
local lsp_status  = require('lsp-status')
local diagnostics  = require('rb.lsp.diagnostics')
local remaps  = require('rb.lsp.remaps')

-- for debugging lsp
-- Levels by name: 'trace', 'debug', 'info', 'warn', 'error'
-- vim.lsp.set_log_level("info")

-- local saga = require 'lspsaga'

-- add your config value here
-- default value
-- use_saga_diagnostic_sign = true
-- error_sign = '',
-- warn_sign = '',
-- hint_sign = '',
-- infor_sign = '',
-- error_header = "  Error",
-- warn_header = "  Warn",
-- hint_header = "  Hint",
-- infor_header = "  Infor",
-- max_diag_msg_width = 50,
-- code_action_icon = ' ',
-- finder_definition_icon = '  ',
-- finder_reference_icon = '  ',
-- finder_action_keys = {
--   open = 'o', vsplit = 's',split = 'i',quit = 'q'
-- },
-- definition_preview_icon = '  '
-- 1: thin border | 2: rounded border | 3: thick border
-- border_style = 1
-- rename_prompt_prefix = '➤',

-- saga.init_lsp_saga {
--   use_saga_diagnostic_sign = false,
--   finder_definition_icon = ' ',
--   finder_reference_icon = ' ',
--   rename_prompt_prefix = '',
-- }

-- saga.init_lsp_saga()


-- adds beatiful icon to completion
_ = require('lspkind').init()
require('rb.lsp.status').activate()
require('rb.lsp.handlers')

local function on_attach(client, bufnr)
    remaps.set(client.server_capabilities, bufnr)
    lsp_status.on_attach(client, bufnr)
    -- lsp_completion.on_attach(client)

end

-- vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
--   vim.lsp.diagnostic.on_publish_diagnostics, {
--     virtual_text = {
--       spacing = 0,
--       prefix = "■",
--     },

--     -- see: ":help vim.lsp.diagnostic.set_signs()"
--     signs = true,

--     update_in_insert = false,
--   }
-- )

-- lsp_status.register_progress()

local default_lsp_config = {on_attach = on_attach, capabilities = lsp_status.capabilities}

-- Servers PATH on MacOS/Linux
-- local servers_path = "~/.local/share/vim-lsp-settings/servers"
local servers_path = vim.fn.stdpath("cache") .. "/lspconfig"

local function project_root_or_cur_dir(path)
    return lsp.util.root_pattern('pyproject.toml', 'Pipfile', '.git')(path) or vim.fn.getcwd()
end

require('os')
local path_sep = vim.loop.os_uname().sysname == "Windows" and "\\" or "/"
local function path_join(...)
    return table.concat(vim.tbl_flatten {...}, path_sep)
end

local system_name
if vim.fn.has("mac") == 1 then
    system_name = "macOS"
elseif vim.fn.has("unix") == 1 then
    system_name = "Linux"
elseif vim.fn.has('win32') == 1 then
    system_name = "Windows"
else
    print("Unsupported system for sumneko")
end

-- set the path to the sumneko installation; if you previously installed via the now deprecated :LspIn
local sumneko_root_path = servers_path.."/sumneko-lua-language-server/extension/server"
local sumneko_binary = sumneko_root_path.."/bin/"..system_name.."/lua-language-server"

local servers = {
    diagnosticls = diagnostics.options,
    bashls = {},
    vimls = {},
    dockerls = {},
    yamlls = {},
    terraformls = {
        cmd = { "terraform-ls", "serve" },
        filetypes = { "terraform", "hcl" }
    },
    -- rust_analyzer = {},
    jsonls = {},
    tsserver = {},
    html = {},
    cssls = {},
    vuels = {},
    -- pyls_ms = {
    --     cmd = { 'dotnet', 'exec', '/Users/rbanyi/Developer/python-language-server/output/bin/Debug/Microsoft.Python.LanguageServer.dll'},
    --     settings = {
    --         pyls = {
    --             plugins = {
    --                 pyflakes = {enabled = true},
    --                 pydocstyle = {enabled = true},
    --                 pylint = {enabled = false},
    --                 mypy_ls = {
    --                     enabled = false,
    --                     live_mode = true
    --                 }
    --             }
    --         }
    --     }
    -- },
    pyls = {
        cmd = {path_join(os.getenv("HOME"), ".config/run_pyls_with_venv.sh")},
        -- cmd = { "pyls" },
        enable = true,
        root_dir = project_root_or_cur_dir,
        -- on_init = ncm2.register_lsp_source,
        settings = {
            pyls = {
                plugins ={
                    pyflakes = {enabled = true},
                    pydocstyle = {enabled = true},
                    pylint = {enabled = false},
                    mypy_ls = {
                        enabled = false,
                        live_mode = true
                    }
                }
            }
        }
    },
    sqlls = {
        cmd = {"/usr/local/bin/sql-language-server", "up", "--method", "stdio"}
    },
    sumneko_lua = {
        cmd = { sumneko_binary, "-E", sumneko_root_path .. "/main.lua" };
        settings = {
            Lua = {
                runtime = {
                -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                version = 'LuaJIT',
                -- Setup your lua path
                path = vim.split(package.path, ';'),
                },
                diagnostics = {
                    -- Get the language server to recognize the `vim` global
                    globals = {'vim'},
                },
                workspace = {
                    -- Make the server aware of Neovim runtime files
                    library = {
                    [vim.fn.expand('$VIMRUNTIME/lua')] = true,
                    [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
                    },
                },
            },
        },
        }
}

for server, config in pairs(servers) do
    lsp[server].setup(vim.tbl_deep_extend("force", default_lsp_config, config))
end
