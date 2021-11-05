local present, cmp = pcall(require, "cmp")

local lspkind = require "lspkind"

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
	["<CR>"] = cmp.mapping.confirm({
		behavior = cmp.ConfirmBehavior.Replace,
		select = true,
	}),
	-- ["<Tab>"] = function(fallback)
	-- 	if vim.fn.pumvisible() == 1 then
	-- 		vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<C-n>", true, true, true), "n")
	-- 	elseif require("luasnip").expand_or_jumpable() then
	-- 		vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-expand-or-jump", true, true, true), "")
	-- 	else
	-- 		fallback()
	-- 	end
	-- end,
	-- ["<S-Tab>"] = function(fallback)
	-- 	if vim.fn.pumvisible() == 1 then
	-- 		vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<C-p>", true, true, true), "n")
	-- 	elseif require("luasnip").jumpable(-1) then
	-- 		vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-jump-prev", true, true, true), "")
	-- 	else
	-- 		fallback()
	-- 	end
	-- end,
	},
	formatting = {
	format = function(entry, vim_item)
		vim_item.kind = string.format("%s %s", lspkind.presets.default[vim_item.kind], vim_item.kind)
		vim_item.menu = ({
		nvim_lsp = "ﲳ",
		nvim_lua = "",
		treesitter = "",
		path = "ﱮ",
		buffer = "﬘",
		zsh = "",
		vsnip = "",
		spell = "暈",
		})[entry.source.name]

		return vim_item
	end,
	},
	sources = {
	-- order of the sources sets priority in the completion menu
	{ name = 'vsnip' },
	{ name = "treesitter" },
	{ name = 'nvim_lsp' },
	{ name = 'nvim_lua' },
	{ name = 'path' },
	{
		name = "buffer",
		opts = {
			get_bufnrs = function()
			return vim.api.nvim_list_bufs()
			end,
		},
	},
	{ name = "spell" },
	},
	experimental = {
	ghost_text = true,
	},
	documentation = {
	border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
	},

})
