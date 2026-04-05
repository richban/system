return {
  {
    "nvim-treesitter/nvim-treesitter",
    main = "nvim-treesitter",
    dev = true,
    dependencies = {
      {
        "nvim-treesitter/nvim-treesitter-textobjects",
        branch = "main",
        config = function()
          require("nvim-treesitter-textobjects").setup({
            lsp_interop = {
              enable = true,
              border = "none",
              peek_definition_code = { ["df"] = "@function.outer", ["dF"] = "@class.outer" },
            },
            move = {
              enable = true,
              set_jumps = true,
              goto_next_start = { ["]m"] = "@function.outer", ["]]"] = "@class.outer" },
              goto_next_end = { ["]M"] = "@function.outer", ["]["] = "@class.outer" },
              goto_previous_start = { ["[m"] = "@function.outer", ["[["] = "@class.outer" },
              goto_previous_end = { ["[M"] = "@function.outer", ["[]"] = "@class.outer" },
            },
            select = {
              enable = true,
              lookahead = true,
              keymaps = {
                ["af"] = "@function.outer",
                ["if"] = "@function.inner",
                ["ac"] = "@class.outer",
                ["ic"] = "@class.inner",
              },
            },
          })
        end,
      },
    },
    opts = {
      install_dir = vim.fn.expand("~/.local/share/nvim/nix/nvim-treesitter-parsers"),
    },
    init = function()
      -- Inject the Nix parsers explicitly so checkhealth string-matching finds it in runtimepath
      vim.opt.rtp:prepend(vim.fn.expand("~/.local/share/nvim/nix/nvim-treesitter-parsers"))

      -- Automatically enable Highlighting and Indent that were removed from the API
      vim.api.nvim_create_autocmd("FileType", {
        callback = function()
          pcall(vim.treesitter.start)
          vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end,
      })
    end,
  },
}
