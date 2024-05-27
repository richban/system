return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "folke/neodev.nvim",
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "WhoIsSethDaniel/mason-tool-installer.nvim",

      { "j-hui/fidget.nvim", opts = {} },
      { "onsails/lspkind.nvim" },
      -- Autoformatting
      "stevearc/conform.nvim",

      -- Schema information
      "b0o/SchemaStore.nvim",
      {
        "nvimdev/lspsaga.nvim",
        dependencies = {
          "nvim-treesitter/nvim-treesitter", -- optional
          "nvim-tree/nvim-web-devicons", -- optional
        },
      },
      {
        "ray-x/lsp_signature.nvim",
        event = "VeryLazy",
      },
    },
    config = function()
      local lspconfig = require("lspconfig")
      local capabilities = nil

      if pcall(require, "cmp_nvim_lsp") then
        capabilities = require("cmp_nvim_lsp").default_capabilities()
      end

      -- Adds beautiful icon to completion
      require("lspkind").init()
      -- Improves the Neovim built-in LSP experience.
      require("rb.lsp.lspsaga")

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

      local servers = {
        nil_ls = { manual_install = true }, -- installed via nix
        bashls = true,
        lua_ls = true,
        cssls = true,
        tsserver = true,
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
        jsonls = {
          settings = {
            json = {
              schemas = require("schemastore").json.schemas(),
              validate = { enable = true },
            },
          },
        },
        yamlls = {
          settings = {
            yaml = {
              schemaStore = {
                enable = false,
                url = "",
              },
              schemas = require("schemastore").yaml.schemas(),
            },
          },
        },
        html = true,
        terraformls = { filetypes = { "terraform", "hcl" } },
        pylsp = {
          enabled = true,
          -- formatCommand = { "black" },
          root_dir = function(fname)
            local root_files = { "pyproject.toml", "setup.py", "setup.cfg", "requirements.txt", "Pipfile" }
            return lspconfig.util.root_pattern(unpack(root_files))(fname) or lspconfig.util.find_git_ancestor(fname)
          end,
          settings = {
            pylsp = {
              plugins = {
                jedi_completion = { enabled = false },
                jedi_hover = { enabled = true },
                jedi_references = { enabled = true },
                jedi_signature_help = { enabled = true },
                jedi_symbols = { enabled = true, all_scopes = true },
                -- The default configuration source is pycodestyle. Change the pylsp.configurationSources setting to ['flake8'] in order to respect flake8 configuration instead
                -- configurationSources = { "flake8" },
                -- linter to detect various errors
                -- pyflakes = { enabled = false },
                -- linter for docstring style checking
                pydocstyle = { enabled = true, convention = "google" },
                -- linter for style checking
                -- pycodestyle = { enabled = false, maxLineLength = 120 },
                -- pylint = { enabled = false },
                -- black = { enabled = false },
                -- type checking
                pylsp_mypy = { enabled = true, live_mode = true },
                -- code formatting using isort
                -- pyls_isort = { enabled = false },
                -- pyls_flake8 = { enabled = false, executable = "flake8" },
                rope_autoimport = {
                  enabled = true,
                  completions = { enabled = true },
                  code_actions = { enabled = true },
                },
                rope_rename = { enabled = false },
                pylsp_rope = { enabled = true },
                ruff = {
                  enabled = true, -- Enable the plugin
                  executable = "/etc/profiles/per-user/richard.banyi/bin/ruff", -- Custom path to ruff
                  formatEnabled = true,
                  extendIgnore = { "E501" },
                  ignore = { "E501" },
                },
                isort = { enabled = true },
              },
            },
          },
        },
      }

      local servers_to_install = vim.tbl_filter(function(key)
        local t = servers[key]
        if type(t) == "table" then
          return not t.manual_install
        else
          return t
        end
      end, vim.tbl_keys(servers))

      require("mason").setup()
      local ensure_installed = {
        "stylua",
        "lua_ls",
        "codespell",
        "gitlint",
        "sqlfluff",
      }

      vim.list_extend(ensure_installed, servers_to_install)
      require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

      for name, config in pairs(servers) do
        if config == true then
          config = {}
        end
        config = vim.tbl_deep_extend("force", {}, {
          capabilities = capabilities,
          on_attach = custom_attach,
        }, config)

        lspconfig[name].setup(config)
      end

      vim.api.nvim_create_autocmd("BufWritePre", {
        callback = function(args)
          require("conform").format({
            bufnr = args.buf,
            lsp_fallback = true,
            quiet = true,
          })
        end,
      })
    end,
  },
}
