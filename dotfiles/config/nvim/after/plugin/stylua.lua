-- & the file "stylua.toml" exists in the base root of the repo.
-- `stylua 0.16.0` → https://github.com/JohnnyMorganz/StyLua

if vim.fn.executable("stylua") == 0 then
  return
end

-- format Lua files pre-write
vim.api.nvim_create_augroup("StyluaAuto", {})
vim.api.nvim_create_autocmd(
  "BufWritePre",
  { command = "lua require('rb.stylua').format()", group = "StyluaAuto", pattern = "*.lua" }
)
