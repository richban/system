local lsp = require('lspconfig')
local lsp_status  = require('lsp-status')
local diagnostics  = require('rb.lsp.diagnostics')
local remaps  = require('rb.lsp.remaps')
local configs = require('lspconfig/configs')

-- for debugging lsp
-- Levels by name: 'trace', 'debug', 'info', 'warn', 'error'
vim.lsp.set_log_level("debug")

-- LSP Saga config https://github.com/glepnir/lspsaga.nvim
local saga = require 'lspsaga'

saga.init_lsp_saga {
  use_saga_diagnostic_sign = false,
  finder_definition_icon = ' ',
  finder_reference_icon = ' ',
  rename_prompt_prefix = '',
  code_action_prompt = {
    enable = false,
  },
}

-- Adds beautiful icon to completion
require'lspkind'.init()

require('rb.lsp.status').activate()
require('rb.lsp.handlers')

local nvim_exec = function(txt)
    vim.api.nvim_exec(txt, false)
  end

local filetype_attach = setmetatable({
    go = function(client)
      vim.cmd [[
        augroup lsp_buf_format
          au! BufWritePre <buffer>
          autocmd BufWritePre <buffer> :lua vim.lsp.buf.formatting_sync()
        augroup END
      ]]
    end,
  
    rust = function()  
      vim.cmd [[
        augroup lsp_buf_format
          au! BufWritePre <buffer>
          autocmd BufWritePre <buffer> :lua vim.lsp.buf.formatting(nil, 5000)
        augroup END
      ]]
    end,
  }, {
    __index = function()
      return function()
      end
    end,
  })

local custom_init = function(client)
  client.config.flags = client.config.flags or {}
  client.config.flags.allow_incremental_sync = true
end

local function custom_attach(client, bufnr)    
    local filetype = vim.api.nvim_buf_get_option(0, "filetype")

    remaps.set(client, bufnr)

    if filetype == "ts" then
      remaps.set_typescript(client, bufnr)
      -- disable tsserver formatting if you plan on formatting via null-ls
      client.resolved_capabilities.document_formatting = false
    end

    lsp_status.on_attach(client, bufnr)


    -- add signature autocompletion while typing
    require'lsp_signature'.on_attach()

    -- Set autocommands conditional on server_capabilities
    if client.resolved_capabilities.document_highlight then
        nvim_exec [[
        augroup lsp_document_highlight
            autocmd! * <buffer>
            autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
            autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
        augroup END
        ]]
    end

    if client.resolved_capabilities.code_lens then
        vim.cmd [[
        augroup lsp_document_codelens
            au! * <buffer>
            autocmd BufWritePost,CursorHold <buffer> lua vim.lsp.codelens.refresh()
        augroup END
        ]]
    end

    -- Attach any filetype specific options to the client
    filetype_attach[filetype](client)
end

local updated_capabilities = vim.lsp.protocol.make_client_capabilities()
updated_capabilities = vim.tbl_deep_extend("keep", updated_capabilities or {}, lsp_status.capabilities)
updated_capabilities.textDocument.codeLens = { dynamicRegistration = false }
-- LSP this is needed for LSP completions in CSS along with the snippets plugin
updated_capabilities.textDocument.completion.completionItem.snippetSupport = true
updated_capabilities.textDocument.completion.completionItem.resolveSupport = {
  properties = {
      "documentation",
      "detail",
      "additionalTextEdits",
  },
}

-- Servers PATH on MacOS/Linux
-- local servers_path = "~/.local/share/vim-lsp-settings/servers"
local servers_path = vim.fn.stdpath("cache") .. "/lspconfig"

local function project_root_or_cur_dir(path)
    return lsp.util.root_pattern('pyproject.toml', 'Pipfile', '.git', 'requirements.txt')(path) or vim.fn.getcwd()
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
    -- efm = require('rb.lsp.efm')(),
    diagnosticls = diagnostics.options,
    bashls = true,
    vimls = true,
    dockerls = true,
    yamlls = true,
    rust_analyzer = true,
    jsonls = {
      cmd = { "vscode-json-languageserver", "--stdio" },
      filetypes = { "json" }
    },
    html = {
      cmd = { "html-languageserver", "--stdio"}
    },
    cssls = {
      cmd = { "css-languageserver", "--stdio"}
    },
    vuels = true,
    terraformls = {
        cmd = { "terraform-ls", "serve" },
        filetypes = { "terraform", "hcl" }
    },
    tsserver = {
        cmd = { "typescript-language-server", "--stdio" },
        filetypes = {
          "javascript",
          "javascriptreact",
          "javascript.jsx",
          "typescript",
          "typescriptreact",
          "typescript.tsx",
        },
    },
    -- FIXME:
    -- pyls = {
    --     cmd = { path_join(os.getenv("HOME"), ".config/run_pyls_with_venv.sh") },
    --     filetypes = { "python" },
    --     root_dir = project_root_or_cur_dir,
    --     log_level = 1,
    --     -- root_dir = function(fname)
    --     --   local root_files = {
    --     --     'pyproject.toml',
    --     --     'setup.py',
    --     --     'setup.cfg',
    --     --     'requirements.txt',
    --     --     'Pipfile',
    --     --   }
    --     --   return lsp.util.root_pattern(unpack(root_files))(fname) or lsp.util.find_git_ancestor(fname) or lsp.util.path.dirname(fname)
    --     -- end,
    --     settings = {
    --         pyls = {
    --           trace = { server = "verbose" },
    --           plugins ={
    --               pyflakes = {enabled = true},
    --               pydocstyle = {enabled = true},
    --               pylint = {enabled = true},
    --               mypy_ls = {
    --                   enabled = false,
    --                   live_mode = true
    --               }
    --           }
    --         }
    --     },
    --       capabilities = vim.tbl_extend('keep', configs.pyls.capabilities or {}, lsp_status.capabilities)
    -- },
    pyright = {},
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

local setup_server = function(server, config)
    if not config then
      return
    end
  
    if type(config) ~= "table" then
      config = {}
    end
  
    config = vim.tbl_deep_extend("force", {
      on_init = custom_init,
      on_attach = custom_attach,
      capabilities = updated_capabilities,
      flags = {
        debounce_text_changes = 50,
      },
    }, config)

    lsp[server].setup(config)
  end
  
for server, config in pairs(servers) do
    setup_server(server, config)
end
