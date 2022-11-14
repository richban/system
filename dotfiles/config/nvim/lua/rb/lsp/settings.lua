local lsp = require("lspconfig")
local lsp_status = require("lsp-status")
local mappings = require("rb.lsp.mappings")

-- new  autocmd API
local autocmd = require("rb.auto").autocmd
local autocmd_clear = vim.api.nvim_clear_autocmds

local augroup_highlight = vim.api.nvim_create_augroup("custom-lsp-references", { clear = true })
local augroup_codelens = vim.api.nvim_create_augroup("custom-lsp-codelens", { clear = true })
local augroup_format = vim.api.nvim_create_augroup("custom-lsp-format", { clear = true })

-- auto command for formatting files
local autocmd_format = function(async, filter)
  vim.api.nvim_clear_autocmds { buffer = 0, group = augroup_format }
  vim.api.nvim_create_autocmd("BufWritePre", {
    buffer = 0,
    callback = function()
      vim.lsp.buf.format { async = async, filter = filter }
    end,
  })
end

-- for debugging lsp: ~/.cache/nvim/lsp.log
-- Levels by name: 'trace', 'debug', 'info', 'warn', 'error'
vim.lsp.set_log_level("error")

-- Adds beautiful icon to completion
require("lspkind").init()

require("rb.lsp.status").activate()
-- require("rb.lsp.handlers")

local filetype_attach = setmetatable({
  go = function()
    autocmd_format(false)
  end,

  scss = function()
    autocmd_format(false)
  end,

  css = function()
    autocmd_format(false)
  end,

  typescript = function()
    autocmd_format(false, function(client)
      return client.name ~= "tsserver"
    end)
  end,
}, {
  __index = function()
    return function() end
  end,
})

local function custom_attach(client, bufnr)
  local filetype = vim.api.nvim_buf_get_option(0, "filetype")

  mappings.set(client)
  lsp_status.on_attach(client)

  if filetype == "typescript" then
    local ts_utils = require("nvim-lsp-ts-utils")
    -- defaults
    ts_utils.setup({
      debug = false,
      disable_commands = false,
      enable_import_on_completion = false,
      import_all_timeout = 5000, -- ms

      -- eslint
      -- using eslint lsp directly now, see below
      eslint_enable_code_actions = false,
      eslint_enable_disable_comments = false,
      eslint_bin = "eslint",
      eslint_config_fallback = nil,
      eslint_enable_diagnostics = false,

      -- TODO: try out update imports on file move
      update_imports_on_move = true,
      require_confirmation_on_move = false,
      watch_dir = nil,
    })

    -- required to fix code action ranges and filter diagnostics
    ts_utils.setup_client(client)
    -- disable tsserver formatting if you plan on formatting via null-ls
    client.server_capabilities.documentFormattingProvider = false
  end

  -- add signature autocompletion while typing
  -- require'lsp_signature'.on_attach()
  require("lsp_signature").on_attach({
    bind = true, -- This is mandatory, otherwise border config won't get registered.
    -- If you want to hook lspsaga or other signature handler, pls set to false
    doc_lines = 2, -- will show 2 lines of comment/doc(if there are more than 2 lines in doc, will be truncated)
    -- set to 0 if you DO NOT want any API comments be shown
    -- This setting only take effect in insert mode, it does not affect signature help in normal
    -- mode, 10 by default
    floating_window = true, -- show hint in a floating window, set to false for virtual text only mode
    hint_enable = true, -- virtual hint enable
    hint_prefix = "🌟 ", -- Panda for parameter
    hint_scheme = "String",
    use_lspsaga = true, -- set to true if you want to use lspsaga popup
    hi_parameter = "Search", -- how your parameter will be highlight
    max_height = 12, -- max height of signature floating_window, if content is more than max_height, you can scroll down
    -- to view the hiding contents
    max_width = 120, -- max_width of signature floating_window, line will be wrapped if exceed max_width
    handler_opts = {
      border = "single", -- double, single, shadow, none
    },
    extra_trigger_chars = {}, -- Array of extra characters that will trigger signature completion, e.g., {"(", ","}
  })

  if client.server_capabilities.documentFormattingProvider then
    autocmd_format(false)
  end

  vim.bo.omnifunc = "v:lua.vim.lsp.omnifunc"

  -- Set autocommands conditional on server_capabilities
  if client.server_capabilities.documentHighlightProvider then
    autocmd_clear { group = augroup_highlight, buffer = bufnr }
    autocmd { "CursorHold", augroup_highlight, vim.lsp.buf.document_highlight, buffer = bufnr }
    autocmd { "CursorMoved", augroup_highlight, vim.lsp.buf.clear_references, buffer = bufnr }
  end

  if false and client.server_capabilities.codeLensProvider then
    if filetype ~= "elm" then
      autocmd_clear { group = augroup_codelens, buffer = bufnr }
      autocmd { "BufEnter", augroup_codelens, vim.lsp.codelens.refresh, bufnr, once = true }
      autocmd { { "BufWritePost", "CursorHold" }, augroup_codelens, vim.lsp.codelens.refresh, bufnr }
    end
  end

  -- Attach any filetype specific options to the client
  filetype_attach[filetype]()
end

local updated_capabilities = vim.lsp.protocol.make_client_capabilities()
-- updated_capabilities = vim.tbl_deep_extend("keep", updated_capabilities or {}, lsp_status.capabilities)

-- Completion configuration
require("cmp_nvim_lsp").default_capabilities(updated_capabilities)

updated_capabilities.textDocument.codeLens = { dynamicRegistration = false }
-- LSP this is needed for LSP completions in CSS along with the snippets plugin
updated_capabilities.textDocument.completion.completionItem.snippetSupport = true
updated_capabilities.textDocument.completion.completionItem.resolveSupport = {
  properties = { "documentation", "detail", "additionalTextEdits" },
}

-- Servers PATH on MacOS/Linux
-- local servers_path = "~/.local/share/vim-lsp-settings/servers"
-- local servers_path = vim.fn.stdpath("cache") .. "/lspconfig"

local function project_root_or_cur_dir(path)
  return lsp.util.root_pattern("pyproject.toml", "Pipfile", ".git", "requirements.txt")(path) or vim.fn.getcwd()
end

require("os")
-- local path_sep = vim.loop.os_uname().sysname == "Windows" and "\\" or "/"
-- local function path_join(...)
--   return table.concat(vim.tbl_flatten({ ... }), path_sep)
-- end

-- local system_name
-- if vim.fn.has("mac") == 1 then
--   system_name = "macOS"
-- elseif vim.fn.has("unix") == 1 then
--   system_name = "Linux"
-- elseif vim.fn.has("win32") == 1 then
--   system_name = "Windows"
-- else
--   print("Unsupported system for sumneko")
-- end

-- set the path to the sumneko installation; if you previously installed via the now deprecated :LspIn
-- local sumneko_root_path = servers_path .. "/sumneko-lua-language-server/extension/server"
-- local sumneko_binary = sumneko_root_path .. "/bin/" .. system_name .. "/lua-language-server"

local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

local servers = {
  -- diagnosticls = diagnostics.options,
  rnix = true,
  bashls = true,
  vimls = {
    init_options = {
      iskeyword = '@,48-57,_,192-255,-#',
      vimruntime = vim.env.VIMRUNTIME,
      runtimepath = vim.o.runtimepath,
      diagnostic = {
        enable = true,
      },
      indexes = {
        runtimepath = true,
        gap = 100,
        count = 8,
        projectRootPatterns = { "runtime", "nvim", ".git", "autoload", "plugin" },
      },
      suggest = {
        fromRuntimepath = true,
        fromVimruntime = true
      },
    }
  },
  dockerls = true,
  yamlls = {
    settings = {
      yaml = {
        format = {
          printWidth = 100,
          singleQuote = true,
        },
      },
    },
  },
  jsonls = {
    filetypes = { "json" },
    schemas = {
      { fileMatch = { "package.json" }, url = "https://json.schemastore.org/package.json" },
      { fileMatch = { "tsconfig*.json" }, url = "https://json.schemastore.org/tsconfig.json" },
      {
        fileMatch = { ".prettierrc", ".prettierrc.json", "prettier.config.json" },
        url = "https://json.schemastore.org/prettierrc.json",
      },
      { fileMatch = { ".eslintrc", ".eslintrc.json" }, url = "https://json.schemastore.org/eslintrc.json" },
      {
        fileMatch = { ".babelrc", ".babelrc.json", "babel.config.json" },
        url = "https://json.schemastore.org/babelrc.json",
      },
      { fileMatch = { "lerna.json" }, url = "https://json.schemastore.org/lerna.json" },
      { fileMatch = { "now.json", "vercel.json" }, url = "https://json.schemastore.org/now.json" },
      {
        fileMatch = { ".stylelintrc", ".stylelintrc.json", "stylelint.config.json" },
        url = "http://json.schemastore.org/stylelintrc.json",
      },
    },
  },
  html = true,
  cssls = true,
  vuels = true,
  terraformls = { filetypes = { "terraform", "hcl" } },
  tsserver = {
    filetypes = {
      "javascript",
      "javascriptreact",
      "javascript.jsx",
      "typescript",
      "typescriptreact",
      "typescript.tsx",
    },
  },
  pylsp = {
    formatCommand = { "black" },
    root_dir = function(fname)
      local root_files = {
        'pyproject.toml',
        'setup.py',
        'setup.cfg',
        'requirements.txt',
        'Pipfile',
      }
      return lsp.util.root_pattern(unpack(root_files))(fname) or lsp.util.find_git_ancestor(fname)
    end,
    settings = {
      pylsp = {
        plugins = {
          jedi_completion = { enabled = true },
          jedi_hover = { enabled = true },
          jedi_references = { enabled = true },
          jedi_signature_help = { enabled = true },
          jedi_symbols = { enabled = true, all_scopes = true },
          -- The default configuration source is pycodestyle. Change the pylsp.configurationSources setting to ['flake8'] in order to respect flake8 configuration instead
          configurationSources = { "flake8" },
          -- linter to detect various errors
          pyflakes = { enabled = false },
          -- linter for docstring style checking
          pydocstyle = { enabled = true },
          -- linter for style checking
          pycodestyle = { enabled = false, maxLineLength = 120 },

          pylint = { enabled = true },

          black = { enabled = true },
          -- type checking
          pylsp_mypy = { enabled = true, live_mode = true },
          -- code formatting using isort
          pyls_isort = { enabled = true },

          pyls_flake8 = { enabled = true, executable = 'flake8' },

          rope_autoimport = { enabled = true }
        },
      },
    },
  },
  -- pyright = {},
  sqls = {
    -- cmd = { "/usr/local/bin/sql-language-server", "up", "--method", "stdio" },
    filetypes = { "sql", "mysql" },
    root_dir = project_root_or_cur_dir,
    settings = {},
  },
  sumneko_lua = {
    -- cmd = { sumneko_binary, "-E", sumneko_root_path .. "/main.lua" },
    settings = {
      Lua = {
        runtime = {
          -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
          version = "LuaJIT",
          -- Setup your lua path
          path = runtime_path,
        },
        diagnostics = {
          -- Get the language server to recognize the `vim` global
          globals = { "vim" },
        },
        workspace = {
          -- Make the server aware of Neovim runtime files
          library = vim.api.nvim_get_runtime_file("", true),
          maxPreload = 5000,
          preloadFileSize = 1000,
        },
        telemetry = {
          enable = false,
        },
      },
    },
  },
  beancount = {},
}

local setup_server = function(server, config)
  if not config then
    return
  end

  if type(config) ~= "table" then
    config = {}
  end

  config = vim.tbl_deep_extend("force", { on_attach = custom_attach, capabilities = updated_capabilities }, config)

  lsp[server].setup(config)
end

for server, config in pairs(servers) do
  setup_server(server, config)
end
