local inlay_hints = require("lsp_extensions.inlay_hints")

local M = {}

M.show_line_hints = function()
	vim.lsp.buf_request(
		0,
		"rust-analyzer/inlayHints",
		inlay_hints.get_params(),
		inlay_hints.get_callback({ only_current_line = true })
	)
end
