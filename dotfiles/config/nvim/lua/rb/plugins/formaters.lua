return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  keys = {
    {
      -- Customize or remove this keymap to your liking
      "<leader>cf",
      function()
        require("conform").format({ async = true, lsp_fallback = true })
      end,
      mode = { "n", "v" },
      desc = "Format buffer",
    },
  },
  -- Everything in opts will be passed to setup()
  opts = {
    -- Define your formatters
    formatters_by_ft = {
      lua = { "stylua" },
      python = { "ruff" },
      javascript = { "prettierd", "prettier" },
      typescript = { "prettierd", "prettier" },
      javascriptreact = { "prettierd", "prettier" },
      typescriptreact = { "prettierd", "prettier" },
      json = { "prettierd", "prettier" },
      yaml = { "prettierd", "prettier" },
      markdown = { "prettierd", "prettier" },
      html = { "prettierd", "prettier" },
      css = { "prettierd", "prettier" },
      scss = { "prettierd", "prettier" },
      nix = { "alejandra" },
      sql = { "sqlfluff" },
      sh = { "shfmt" },
      ["*"] = { "trim_whitespace", "trim_newlines" },
    },
    -- Set up format-on-save
    format_on_save = {
      timeout_ms = 500,
      lsp_fallback = true,
      async = false,
    },
    -- Customize formatters
    formatters = {
      shfmt = {
        prepend_args = { "-i", "2" },
      },
      sqlfluff = {
        args = {
          "fix",
          "--dialect",
          "postgres",
          "-",
        },
      },

      prettier = {
        prepend_args = { "--print-width", "100" },
      },
    },
    -- Use stop_after_first for JavaScript
    javascript = {
      stop_after_first = true,
    },
    typescript = {
      stop_after_first = true,
    },
  },
  init = function()
    -- If you want the formatexpr, here is the place to set it
    -- Use `gqap` to format a paragraph
    vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"

    -- Add format commands
    vim.api.nvim_create_user_command("Format", function(args)
      local range = nil
      if args.count ~= -1 then
        range = {
          start = { args.line1, 0 },
          ["end"] = { args.line2, 0 },
        }
      end
      require("conform").format({ async = true, lsp_fallback = true, range = range })
    end, { range = true })
  end,
}
