local func = {}

local augroup_format = vim.api.nvim_create_augroup("custom-lsp-format", { clear = true })

func.autocmd = function(args)
	local event = args[1]
	local group = args[2]
	local callback = args[3]

	vim.api.nvim_create_autocmd(event, {
		group = group,
		buffer = args[4],
		callback = function()
			callback()
		end,
		once = args.once,
	})
end

-- auto command for formatting files on save
func.autocmd_format = function(async, filter)
	vim.api.nvim_clear_autocmds({ buffer = 0, group = augroup_format })
	vim.api.nvim_create_autocmd("BufWritePre", {
		buffer = 0,
		callback = function()
			vim.lsp.buf.format({ async = async, filter = filter })
		end,
	})
end

return func
