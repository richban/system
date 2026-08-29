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

-- Global keymap for toggling ghost text
vim.keymap.set("n", "<leader>tg", function()
  local current_config = cmp.get_config()
  current_config.experimental.ghost_text = not current_config.experimental.ghost_text
  cmp.setup(current_config)
  vim.notify("Ghost text " .. (current_config.experimental.ghost_text and "enabled" or "disabled"))
end, { noremap = true, silent = true, desc = "Toggle completion ghost text" })

-- Disable cmp in telescope
local cmp_enabled = true
vim.api.nvim_create_autocmd("FileType", {
  pattern = "TelescopePrompt",
  callback = function()
    require("cmp").setup.buffer({ enabled = false })
  end,
})

cmp.setup({
  enabled = function()
    return cmp_enabled and vim.bo.buftype ~= "prompt"
  end,
  completion = {
    autocomplete = false,
    completeopt = "menu,menuone,noinsert,noselect",
  },
  view = {
    docs = {
      auto_open = false,
    },
  },
  snippet = {
    expand = function(args)
      -- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
      require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
      -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
      -- require'snippy'.expand_snippet(args.body) -- For `snippy` users.
    end,
  },
  mapping = {
    ["<C-n>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item({ behavior = cmp.SelectBehavior.Insert })
      else
        cmp.complete()
      end
    end, { "i", "c" }),
    ["<C-p>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item({ behavior = cmp.SelectBehavior.Insert })
      else
        cmp.complete()
      end
    end, { "i", "c" }),
    ["<C-d>"] = function()
      if cmp.visible_docs() then
        cmp.close_docs()
      else
        cmp.open_docs()
      end
    end,
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
    ["<C-y>"] = cmp.mapping(
      cmp.mapping.confirm({
        behavior = cmp.ConfirmBehavior.Insert,
        select = true,
      }),
      { "i", "c" }
    ),
    ["<C-e>"] = cmp.mapping.abort(),
    ["<CR>"] = cmp.mapping(function(fallback)
      if cmp.visible() and cmp.get_active_entry() then
        if vim.bo.filetype == "TelescopePrompt" then
          fallback()
        else
          cmp.confirm({ select = false })
        end
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<Tab>"] = cmp.mapping(function(fallback)
      local has_words_before = function()
        unpack = unpack or table.unpack
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
      end

      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_locally_jumpable() then
        luasnip.expand_or_jump()
      elseif has_words_before() then
        cmp.complete()
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
          luasnip = "[Snippet]",
          nvim_lua = "",
          path = "[Path]",
          buffer = "[Buffer]",
          treesitter = "",
          zsh = "",
          spell = "暈",
          codeium = "",
          copilot = "",
        })[entry.source.name]
        return vim_item
      end,
    }),
  },
  sorting = {
    priority_weight = 2,
    comparators = {
      cmp.config.compare.offset,
      cmp.config.compare.exact,
      cmp.config.compare.score,
      cmp.config.compare.recently_used,
      cmp.config.compare.locality,
      cmp.config.compare.kind,
      cmp.config.compare.sort_text,
      cmp.config.compare.length,
      cmp.config.compare.order,
    },
  },
  sources = cmp.config.sources({
    { name = "nvim_lsp", priority = 1000 },
    { name = "luasnip", priority = 750 },
    { name = "path", priority = 500 },
  }, {
    {
      name = "buffer",
      priority = 250,
      keyword_length = 3,
      option = {
        get_bufnrs = function()
          return { vim.api.nvim_get_current_buf() }
        end,
      },
    },
  }),
  experimental = { ghost_text = true, native_menu = false },
  window = {
    documentation = cmp.config.window.bordered(),
  },
})
