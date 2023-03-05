local present, cmp = pcall(require, "cmp")
local types = require("cmp.types")
local str = require("cmp.utils.str")

local lspkind = require("lspkind")
lspkind.init({
  -- options: 'text', 'text_symbol', 'symbol_text', 'symbol'
  mode = "symbol_text",
  symbol_map = {
    Text = "",
    Method = "ƒ",
    Function = "ﬦ",
    Constructor = "",
    Variable = "",
    Class = "",
    Interface = "ﰮ",
    Module = "",
    Property = "",
    Unit = "",
    Value = "",
    Enum = "了",
    Keyword = "",
    Snippet = "﬌",
    Color = "",
    File = "",
    Folder = "",
    EnumMember = "",
    Constant = "",
    Struct = "",
  },
})

if not present then
  return
end

cmp.setup({
  snippet = {
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
      -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
      -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
      -- require'snippy'.expand_snippet(args.body) -- For `snippy` users.
    end,
  },
  mapping = {
    ["<C-p>"] = cmp.mapping.select_prev_item(),
    ["<C-n>"] = cmp.mapping.select_next_item(),
    ["<C-d>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping.close(),
    ["<CR>"] = cmp.mapping({
      i = cmp.mapping.confirm({ select = true }),
    }),
    ["<Tab>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "s" }),
    ["<S-Tab>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "s" }),
  },
  formatting = {
    fields = {
      cmp.ItemField.Abbr,
      cmp.ItemField.Kind,
      cmp.ItemField.Menu,
    },
    format = lspkind.cmp_format({
      mode = "symbol_text",
      maxwidth = 60,
      before = function(entry, vim_item)
        vim_item.menu = ({
          nvim_lsp = "ﲳ",
          nvim_lua = "",
          treesitter = "",
          path = "ﱮ",
          buffer = "﬘",
          zsh = "",
          vsnip = "",
          spell = "暈",
        })[entry.source.name]
        -- Get the full snippet (and only keep first line)
        local word = entry:get_insert_text()
        if entry.completion_item.insertTextFormat == types.lsp.InsertTextFormat.Snippet then
          word = vim.lsp.util.parse_snippet(word)
        end
        word = str.oneline(word)
        if
          entry.completion_item.insertTextFormat == types.lsp.InsertTextFormat.Snippet
          and string.sub(vim_item.abbr, -1, -1) == "~"
        then
          word = word .. "~"
        end
        vim_item.abbr = word

        return vim_item
      end,
    }),
  },
  sources = {
    -- order of the sources sets priority in the completion menu
    { name = "nvim_lsp" },
    { name = "vsnip" },
    { name = "treesitter" },
    { name = "path" },
    { name = "buffer" },
    { name = "spell" },
  },
  experimental = { ghost_text = true },
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
})

-- require('nvim-autopairs').setup({check_ts = true})
-- local cmp_autopairs = require('nvim-autopairs.completion.cmp')
-- cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done({map_char = {tex = ''}}))
