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
      python = { "ruff_format" },
      javascript = { "prettierd", "prettier", stop_after_first = true },
      typescript = { "prettierd", "prettier", stop_after_first = true },
      javascriptreact = { "prettierd", "prettier", stop_after_first = true },
      typescriptreact = { "prettierd", "prettier", stop_after_first = true },
      json = { "prettierd", "prettier", stop_after_first = true },
      yaml = { "prettierd", "prettier", stop_after_first = true },
      markdown = { "prettierd", "prettier", stop_after_first = true },
      html = { "prettierd", "prettier", stop_after_first = true },
      css = { "prettierd", "prettier", stop_after_first = true },
      scss = { "prettierd", "prettier", stop_after_first = true },
      nix = { "alejandra" },
      sql = { "sqlfmt" },
      sh = { "shfmt" },
      c = { "clang-format" },
      cpp = { "clang-format" },
      ["*"] = { "trim_whitespace", "trim_newlines" },
    },
    -- Set up format-after-save (async background formatting, zero save delay)
    format_after_save = {
      lsp_fallback = true,
      async = true,
    },
    -- Customize formatters
    formatters = {
      shfmt = {
        prepend_args = { "-i", "2" },
      },

      prettier = {
        prepend_args = { "--print-width", "100" },
      },
      ["clang-format"] = {
        prepend_args = {
          "--style={BasedOnStyle: Google, IndentWidth: 2, UseTab: Never, ColumnLimit: 100}",
        },
      },
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
