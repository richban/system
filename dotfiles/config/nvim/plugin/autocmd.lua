local function augroup(name)
  return vim.api.nvim_create_augroup("mnv_" .. name, { clear = true })
end

-- Go to the last cursor position when re-opening a file.
vim.api.nvim_create_autocmd("BufReadPost", {
  group = augroup("last_loc"),
  callback = function(event)
    -- Skip commit messages etc., where starting at the top is what you want.
    if vim.tbl_contains({ "gitcommit", "gitrebase" }, vim.bo[event.buf].filetype) then
      return
    end
    local mark = vim.api.nvim_buf_get_mark(event.buf, '"')
    local lcount = vim.api.nvim_buf_line_count(event.buf)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- Briefly highlight yanked and pasted text. See `:help vim.hl.hl_op()`.
vim.api.nvim_create_autocmd({ "TextYankPost", "TextPutPost" }, {
  group = augroup("highlight_yank"),
  callback = function()
    vim.hl.hl_op()
  end,
})

-- TypeScript: organize imports on save (only asks ts_ls, not every attached client).
vim.api.nvim_create_autocmd("BufWritePre", {
  group = augroup("ts_organize_imports"),
  pattern = { "*.ts", "*.tsx" },
  callback = function(event)
    for _, client in ipairs(vim.lsp.get_clients({ bufnr = event.buf, name = "ts_ls" })) do
      client:request_sync("workspace/executeCommand", {
        command = "_typescript.organizeImports",
        arguments = { vim.api.nvim_buf_get_name(event.buf) },
      }, 1000, event.buf)
    end
  end,
})

-- Trim trailing whitespace on save, without touching the search register/history or the view.
vim.api.nvim_create_autocmd("BufWritePre", {
  group = augroup("trim_whitespace"),
  callback = function(event)
    local bo = vim.bo[event.buf]
    -- Markdown uses two trailing spaces as a hard line break; diffs/binary must stay untouched.
    if bo.binary or not bo.modifiable or vim.tbl_contains({ "markdown", "diff", "gitcommit" }, bo.filetype) then
      return
    end
    local view = vim.fn.winsaveview()
    vim.cmd([[keeppatterns keepjumps silent! %s/\s\+$//e]])
    vim.fn.winrestview(view)
  end,
})

-- Close these auxiliary windows with `q` (and keep them out of the buffer list).
vim.api.nvim_create_autocmd("FileType", {
  group = augroup("close_with_q"),
  pattern = {
    "checkhealth",
    "fugitive",
    "fugitiveblame",
    "git",
    "help",
    "man",
    "qf",
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>close<cr>", { buf = event.buf, silent = true, desc = "Close window" })
  end,
})

-- Enable hotreload for real-time buffer updates when files change on disk.
require("rb.hotreload").setup()
