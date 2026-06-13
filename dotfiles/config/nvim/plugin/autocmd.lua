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
  group = vim.api.nvim_create_augroup("TS_OrganizeImports", { clear = true }),
  pattern = { "*.ts", "*.tsx" },
  callback = function()
    local params = {
      command = "_typescript.organizeImports",
      arguments = { vim.api.nvim_buf_get_name(0) },
    }
    pcall(vim.lsp.buf_request_sync, 0, "workspace/executeCommand", params, 1000)
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

-- Trim trailing whitespace on save
vim.api.nvim_create_autocmd("BufWritePre", {
  group = vim.api.nvim_create_augroup("TrimWhiteSpace", { clear = true }),
  pattern = "*",
  callback = function()
    local l = vim.fn.line(".")
    local c = vim.fn.col(".")
    vim.cmd("%s/\\s\\+$//e")
    vim.fn.cursor(l, c)
  end,
})

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

-- Enable hotreload for real-time buffer updates when files change on disk
pcall(function()
  require("rb.hotreload").setup()
end)
