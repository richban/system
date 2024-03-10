local lsp = require("lspconfig")

-- for debugging lsp: ~/.cache/nvim/lsp.log
-- Levels by name: 'trace', 'debug', 'info', 'warn', 'error'
vim.lsp.set_log_level("error")

-- Adds beautiful icon to completion
require("lspkind").init()

-- diagnostics, handlers
require("rb.lsp.handlers").lsp_init()

local function custom_attach(client, bufnr)
  local filetype = vim.api.nvim_buf_get_option(0, "filetype")

  require("rb.lsp.mappings").on_attach(client, bufnr)

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
      border = "rounded", -- double, single, shadow, none
    },
    extra_trigger_chars = {}, -- Array of extra characters that will trigger signature completion, e.g., {"(", ","}
  }, bufnr)

  vim.bo.omnifunc = "v:lua.vim.lsp.omnifunc"

  -- highlights LSP references on CursorHold and CursorMoved events
  if client.server_capabilities.documentHighlightProvider then
    vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
      buffer = bufnr,
      callback = vim.lsp.buf.document_highlight,
    })

    vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
      buffer = bufnr,
      callback = vim.lsp.buf.clear_references,
    })
  end

  if filetype == "typescript" or filetype == "lua" then
    client.server_capabilities.semanticTokensProvider = nil
  end
end

local updated_capabilities = vim.lsp.protocol.make_client_capabilities()
updated_capabilities =
  vim.tbl_deep_extend("force", updated_capabilities, require("cmp_nvim_lsp").default_capabilities())

-- Servers PATH on MacOS/Linux
-- local servers_path = "~/.local/share/vim-lsp-settings/servers"
-- local servers_path = vim.fn.stdpath("cache") .. "/lspconfig"

local function project_root_or_cur_dir(path)
  return lsp.util.root_pattern("pyproject.toml", "Pipfile", ".git", "requirements.txt", "stylua.toml")(path)
    or lsp.util.find_git_ancestor(path)
end

require("os")
local runtime_path = vim.split(package.path, ";")
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

local servers = {
  -- diagnosticls = diagnostics.options,
  rnix = false,
  bashls = true,
  vimls = {
    init_options = {
      iskeyword = "@,48-57,_,192-255,-#",
      vimruntime = vim.env.VIMRUNTIME,
      runtimepath = vim.o.runtimepath,
      diagnostic = { enable = true },
      indexes = {
        runtimepath = true,
        gap = 100,
        count = 8,
        projectRootPatterns = { "runtime", "nvim", ".git", "autoload", "plugin" },
      },
      suggest = { fromRuntimepath = true, fromVimruntime = true },
    },
  },
  dockerls = {
    settings = {
      Dockerfile = {
        lsp = {
          formatting = {
            options = {
              tabSize = 2,
            },
          },
        },
      },
    },
  },
  yamlls = { settings = { yaml = { format = { printWidth = 100, singleQuote = true } } } },
  jsonls = {
    filetypes = { "json" },
    schemas = {
      { fileMatch = { "package.json" }, url = "https://json.schemastore.org/package.json" },
      { fileMatch = { "tsconfig*.json" }, url = "https://json.schemastore.org/tsconfig.json" },
      {
        fileMatch = { ".prettierrc", ".prettierrc.json", "prettier.config.json" },
        url = "https://json.schemastore.org/prettierrc.json",
      },
      {
        fileMatch = { ".eslintrc", ".eslintrc.json" },
        url = "https://json.schemastore.org/eslintrc.json",
      },
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
  ruff_lsp = {
    settings = {},
  },
  pylsp = {
    enabled = false,
    formatCommand = { "black" },
    root_dir = function(fname)
      local root_files = { "pyproject.toml", "setup.py", "setup.cfg", "requirements.txt", "Pipfile" }
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
          pydocstyle = { enabled = false },
          -- linter for style checking
          pycodestyle = { enabled = false, maxLineLength = 120 },
          pylint = { enabled = false },
          black = { enabled = true },
          -- type checking
          pylsp_mypy = { enabled = true, live_mode = true },
          -- code formatting using isort
          pyls_isort = { enabled = true },
          pyls_flake8 = { enabled = false, executable = "flake8" },
          rope_autoimport = { enabled = true },
        },
      },
    },
  },
  -- pyright = {},
  sqlls = {
    -- cmd = { "/usr/local/bin/sql-language-server", "up", "--method", "stdio" },
    filetypes = { "sql", "mysql" },
    root_dir = project_root_or_cur_dir,
    settings = {},
  },
  lua_ls = {
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
          checkThirdParty = false,
        },
        telemetry = { enable = false },
        format = {
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
