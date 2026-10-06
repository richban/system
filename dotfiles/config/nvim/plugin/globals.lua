-- Debug helpers for `:lua` (inspired by tjdevries' config).
--   P(v)       pretty-print any value and return it (same as `vim.print`)
--   R("mod")   reload a Lua module and require it again (picks up edits without restarting)
local ok, plenary_reload = pcall(require, "plenary.reload")
local reloader = ok and plenary_reload.reload_module or function(name)
  package.loaded[name] = nil
end

P = vim.print

RELOAD = function(...)
  return reloader(...)
end

R = function(name)
  RELOAD(name)
  return require(name)
end
