require("projections").setup({
  workspaces = {
    { "~/Developer/mckinsey/planetrics", { ".git" } },
    { "~/Developer", { ".git" } },
  },
  patterns = { ".git", ".svn", ".hg" },
  store_hooks = { pre = nil, post = nil },
  restore_hooks = { pre = nil, post = nil },
})

local Session = require("projections.session")

-- Syntax highlighting
vim.opt.ssop:append({ "localoptions" })

-- Bind <leader>fp to Telescope projections
require("telescope").load_extension("projections")
vim.keymap.set("n", "<leader>fp", function()
  vim.cmd("Telescope projections")
end)

-- Autostore session on VimExit
vim.api.nvim_create_autocmd({ "VimLeavePre" }, {
  callback = function()
    Session.store(vim.loop.cwd())
  end,
})

-- Switch to project if vim was started in a project dir
local switcher = require("projections.switcher")
vim.api.nvim_create_autocmd({ "VimEnter" }, {
  callback = function()
    if vim.fn.argc() == 0 then
      switcher.switch(vim.loop.cwd())
    end
  end,
})

-- If vim was started with arguments, do nothing
-- If in some project's root, attempt to restore that project's session
-- If not, restore last session
-- If no sessions, do nothing
vim.api.nvim_create_autocmd({ "VimEnter" }, {
  callback = function()
    if vim.fn.argc() ~= 0 then
      return
    end
    local session_info = Session.info(vim.loop.cwd())
    if session_info == nil then
      Session.restore_latest()
    else
      Session.restore(vim.loop.cwd())
    end
  end,
  desc = "Restore last session automatically",
})
