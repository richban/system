vim.g.dashboard_default_executive = "telescope"
vim.g.dashboard_custom_section = {
  f = { description = { "  Find File          " }, command = "Telescope find_files" },
  g = { description = { "  Search Text        " }, command = "Telescope live_grep" },
  r = { description = { "  Recent Files       " }, command = "Telescope oldfiles" },
  c = { description = { "  Config             " }, command = "edit ~/.config/nvim/init.lua" },
}
vim.g.dashboard_custom_footer = { "Do one thing, do it well - Unix Philosophy" }
