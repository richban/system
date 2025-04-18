local present, cmp = pcall(require, "cmp")
-- local types = require("cmp.types")
-- local str = require("cmp.utils.str")
local icons = require("rb.icons")
local lspkind = require("lspkind")

local luasnip = require("luasnip")
luasnip.config.setup({})

local cmp_autopairs = require("nvim-autopairs.completion.cmp")
cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

require("luasnip.loaders.from_vscode").lazy_load()

lspkind.init({
  -- options: 'text', 'text_symbol', 'symbol_text', 'symbol'
  mode = "symbol_text",
  symbol_map = {
    Text = "",
    Method = "ƒ",
    Function = icons.kind.Function,
    Constructor = "",
    Variable = "",
    Class = "",
    Interface = icons.kind.Interface,
    Module = icons.kind.Module,
    Property = "",
    Unit = "",
    Value = icons.kind.Value,
    Enum = "了",
    Keyword = "",
    Snippet = icons.kind.Snippet,
    Color = "",
    File = "",
    Folder = "",
    EnumMember = "",
    Constant = "",
    Struct = "",
    Copilot = "",
  },
})

if not present then
  return
end

cmp.setup({
  snippet = {
    expand = function(args)
      -- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
      require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
      -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
      -- require'snippy'.expand_snippet(args.body) -- For `snippy` users.
    end,
  },
  mapping = {
    ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
    ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
    ["<C-d>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-y>"] = cmp.mapping(
      cmp.mapping.confirm({
        behavior = cmp.ConfirmBehavior.Insert,
        select = true,
      }),
      { "i", "c" }
    ),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping.abort(),
    ["<CR>"] = cmp.mapping.confirm({ select = true }),
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_locally_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.locally_jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),
    -- Copilot completion
    ["<c-h>"] = cmp.mapping.complete({
      config = {
        sources = {
          { name = "copilot" },
        },
      },
    }),
    -- <c-l> will move you to the right of each of the expansion locations.
    -- <c-h> is similar, except moving you backwards.
    ["<C-l>"] = cmp.mapping(function()
      if luasnip.expand_or_locally_jumpable() then
        luasnip.expand_or_jump()
      end
    end, { "i", "s" }),
    ["<C-h>"] = cmp.mapping(function()
      if luasnip.locally_jumpable(-1) then
        luasnip.jump(-1)
      end
    end, { "i", "s" }),
  },
  formatting = {
    fields = {
      cmp.ItemField.Abbr,
      cmp.ItemField.Kind,
      cmp.ItemField.Menu,
    },
    format = lspkind.cmp_format({
      mode = "symbol_text",
      -- maxwidth = 60,
      before = function(entry, vim_item)
        vim_item.menu = ({
          nvim_lsp = "[LSP]",
          nvim_lua = "",
          treesitter = "",
          path = "[Path]",
          buffer = "[buffer]",
          zsh = "",
          vsnip = "",
          spell = "暈",
          codeium = "",
          copilot = "",
        })[entry.source.name]
        -- Get the full snippet (and only keep first line)
        -- local word = entry:get_insert_text()
        -- if entry.copletion_item.insertTextFormat == types.lsp.InsertTextFormat.Snippet then
        --   word = vim.lsp.util.parse_snippet(word)
        -- end
        -- word = str.oneline(word)
        -- if
        --   entry.completion_item.insertTextFormat == types.lsp.InsertTextFormat.Snippet
        --   and string.sub(vim_item.abbr, -1, -1) == "~"
        -- then
        --   word = word .. "~"
        -- end
        -- vim_item.abbr = word
        return vim_item
      end,
    }),
  },
  sources = {
    { name = "nvim_lsp", priority = 1000 },
    { name = "copilot", priority = 900 },
    { name = "luasnip", priority = 750 },
    { name = "nvim_lsp_signature_help", priority = 700 },
    { name = "nvim_lsp_document_symbol", priority = 600 },
    { name = "buffer", priority = 500 },
    { name = "path", priority = 250 },
    { name = "treesitter", priority = 200 },
    { name = "spell", priority = 100 },
  },
  experimental = { ghost_text = true, native_menu = false },
  window = {
    documentation = cmp.config.window.bordered(),
  },
})
