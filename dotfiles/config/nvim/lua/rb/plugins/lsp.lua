return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "WhoIsSethDaniel/mason-tool-installer.nvim",
      "hrsh7th/cmp-nvim-lsp",
      -- Schema information
      "b0o/SchemaStore.nvim",
    },
    config = function()
      local capabilities = nil

      if pcall(require, "cmp_nvim_lsp") then
        capabilities = require("cmp_nvim_lsp").default_capabilities()
      end

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
        -- require("lsp_signature").on_attach({
        --   bind = true, -- This is mandatory, otherwise border config won't get registered.
        --   -- If you want to hook lspsaga or other signature handler, pls set to false
        --   doc_lines = 2, -- will show 2 lines of comment/doc(if there are more than 2 lines in doc, will be truncated)
        --   -- set to 0 if you DO NOT want any API comments be shown
        --   -- This setting only take effect in insert mode, it does not affect signature help in normal
        --   -- mode, 10 by default
        --   floating_window = true, -- show hint in a floating window, set to false for virtual text only mode
        --   hint_enable = true, -- virtual hint enable
        --   hint_prefix = "🌟 ", -- Panda for parameter
        --   hint_scheme = "String",
        --   use_lspsaga = true, -- set to true if you want to use lspsaga popup
        --   hi_parameter = "Search", -- how your parameter will be highlight
        --   max_height = 12, -- max height of signature floating_window, if content is more than max_height, you can scroll down
        --   -- to view the hiding contents
        --   max_width = 120, -- max_width of signature floating_window, line will be wrapped if exceed max_width
        --   handler_opts = {
        --     border = "rounded", -- double, single, shadow, none
        --   },
        --   extra_trigger_chars = {}, -- Array of extra characters that will trigger signature completion, e.g., {"(", ","}
        -- }, bufnr)

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
        ts_ls = true,
        sqls = {
          settings = {
            sqls = {
              connections = {
                {
                  driver = "sqlite3",
                  dataSourceName = ":memory:",
                },
              },
            },
          },
        },
        clangd = {
          cmd = {
            "clangd",
            "--background-index",
            "--clang-tidy",
            "--header-insertion=iwyu",
            "--completion-style=detailed",
            "--function-arg-placeholders",
            "--fallback-style=llvm",
            "--query-driver=/usr/bin/clang++,/usr/bin/g++,/opt/homebrew/opt/llvm/bin/clang++,/nix/store/*/bin/clang++,/nix/store/*/bin/g++",
          },
          init_options = {
            usePlaceholders = true,
            completeUnimported = true,
            clangdFileStatus = true,
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
        basedpyright = {
          settings = {
            basedpyright = {
              analysis = {
                autoSearchPaths = true,
                useLibraryCodeForTypes = true,
                diagnosticMode = "openFilesOnly",
                typeCheckingMode = "basic",
              },
            },
          },
        },
        ruff = true,
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
        "clang-format",
      }

      vim.list_extend(ensure_installed, servers_to_install)
      require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

      -- Setup all defined servers with the capabilities
      for server_name, server_settings in pairs(servers) do
        local config = {
          capabilities = capabilities,
          on_attach = custom_attach,
        }

        -- Merge any custom settings
        if type(server_settings) == "table" then
          for k, v in pairs(server_settings) do
            config[k] = v
          end
        end

        -- Use new Neovim 0.11+ API: configure then enable
        vim.lsp.config(server_name, config)
        vim.lsp.enable(server_name)
      end
    end,
  },
  {
    "nvimdev/lspsaga.nvim",
    event = "LspAttach",
    dependencies = {
      { "nvim-treesitter/nvim-treesitter", optional = true },
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("rb.lsp.lspsaga")
    end,
  },

  {
    "ray-x/lsp_signature.nvim",
    event = "VeryLazy",
    opts = {
      bind = true,
      doc_lines = 10,
      floating_window = false, -- Do not show automatically while typing
      hint_enable = false, -- Do not show inline virtual text
      handler_opts = {
        border = "rounded",
      },
      toggle_key = "<C-k>", -- Toggle signature window on demand
    },
    config = function(_, opts)
      require("lsp_signature").setup(opts)
    end,
  },
  {
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {
      library = {
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      },
    },
  },
}
