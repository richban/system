local function augroup(name)
  return vim.api.nvim_create_augroup("mnv_" .. name, { clear = true })
end

-- go to last loc when opening a buffer
vim.api.nvim_create_autocmd("BufReadPost", {
  group = augroup("last_loc"),
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})
-- Highlight on yank
-- See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = augroup("highlight_yank"),
  pattern = "*",
})

vim.api.nvim_create_autocmd("BufWritePre", {
  group = vim.api.nvim_create_augroup("Format", { clear = true }),
  pattern = "*.ts",
  callback = function()
    -- Execute TSLspOrganize command
    vim.cmd("TSLspOrganize")
  end,
})

-- set markdown FTs
vim.api.nvim_create_autocmd({ "BufNewFile", "BufFilePre", "BufRead" }, {
  group = vim.api.nvim_create_augroup("SetMarkdownFt", { clear = true }),
  pattern = { "*.markdown", "*.mdown", "*.mkd", "*.mkdn", "*.mdwn", "*.md", "*.MD" },
  callback = function()
    -- Set filetype to markdown
    vim.cmd("set ft=markdown")
  end,
})

function vim.fn.TrimWhiteSpace()
  local l = vim.fn.line(".")
  local c = vim.fn.col(".")
  vim.cmd("%s/\\s\\+$//e")
  vim.fn.cursor(l, c)
end

vim.cmd("autocmd BufWritePre * :lua vim.fn.TrimWhiteSpace()")

-- windows to close
vim.api.nvim_create_autocmd("FileType", {
  group = augroup("close_with_q"),
  pattern = {
    "OverseerForm",
    "OverseerList",
    "checkhealth",
    "floggraph",
    "fugitive",
    "git",
    "gitcommit",
    "help",
    "lspinfo",
    "man",
    "neotest-output",
    "neotest-summary",
    "qf",
    "query",
    "spectre_panel",
    "startuptime",
    "toggleterm",
    "tsplayground",
    "vim",
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
  end,
})
