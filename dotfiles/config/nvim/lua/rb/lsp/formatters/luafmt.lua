-- paru -S lua-format-git
local luaformat = {
  formatCommand = 'lua-format -i --indent-width=2 --tab-width=2',
  formatStdin = true
}

return luaformat
