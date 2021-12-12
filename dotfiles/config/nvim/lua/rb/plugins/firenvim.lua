if vim.g.started_by_firenvim then
  vim.g.laststatus = 0

  map('n', '<Esc><Esc>', '=call firenvim#focus_page()<CR>')
  map('n', '<C-z>', '=write<CR>=call firenvim#hide_frame()<CR>')

  vim.g.firenvim_config = {
    globalSettings = {alt = all},
    localSettings = {
      [".*"] = {cmdline = neovim, priority = 0, selector = textarea, takeover = always}
      -- ['https://youtube.com*'] = { 'takeover': 'never', 'priority': 1 },
      -- ['https?://instagram.com*'] = { 'takeover': 'never', 'priority': 1 },
      -- ['https?://twitter.com.*'] = { 'takeover': 'never', 'priority': 1 },
      -- ['https://.*gmail.com*'] = { 'takeover': 'never', 'priority': 1 },
      -- ['https://.*google.com*'] = { 'takeover': 'never', 'priority': 1 },
      -- ['https?://.*twitch.tv*'] = { 'takeover': 'never', 'priority': 1 },
      -- ['https?://notion.so*'] = { 'takeover': 'never', 'priority': 1 },
      -- ['https?://reddit.com*'] = { 'takeover': 'never', 'priority': 1 },
    }
  }

  vim.cmd('au BufEnter github.com_*.txt set filetype=markdown')
end
