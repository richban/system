-- Eviline config for lualine
-- Author: shadmansaleh
-- Credit: glepnir
local lualine = require("lualine")

-- Returns the path of the session file as well as project information
-- Returns nil if path is not a valid project path
-- @args spath The path to project root
-- @returns nil | path of session file and project information
-- function Session.info(spath) ... end

local project_name_display = function()
  local projections_available, Session = pcall(require, "projections.session")
  if projections_available then
    local info = Session.info(vim.loop.cwd())
    if info ~= nil then
      -- local session_file_path = tostring(info.path)
      -- local project_workspace_patterns = info.project.workspace.patterns
      -- local project_workspace_path = tostring(info.project.workspace)
      local project_name = info.project.name
      return "☺ " .. project_name
    end
  end
  return vim.fs.basename(vim.loop.cwd())
end
-- Color table for highlights
local colors = {
  bg = "#202328",
  fg = "#bbc2cf",
  yellow = "#ECBE7B",
  cyan = "#008080",
  darkblue = "#081633",
  green = "#98be65",
  orange = "#FF8800",
  violet = "#a9a1e1",
  magenta = "#c678dd",
  blue = "#51afef",
  red = "#ec5f67",
  aqua = "#8ec07c",
}

local conditions = {
  buffer_not_empty = function()
    return vim.fn.empty(vim.fn.expand("%:t")) ~= 1
  end,
  hide_in_width = function()
    return vim.fn.winwidth(0) > 80
  end,
  check_git_workspace = function()
    local filepath = vim.fn.expand("%:p:h")
    local gitdir = vim.fn.finddir(".git", filepath .. ";")
    return gitdir and #gitdir > 0 and #gitdir < #filepath
  end,
}

-- Config
local config = {
  options = {
    -- Disable sections and component separators
    component_separators = { "", "" },
    section_separators = { "", "" },
    theme = "dracula",
    icons_enabled = true,
  },
  sections = {
    -- These will be filled later
    lualine_a = { { "mode", upper = true } },
    lualine_b = { { "branch", icon = "" } },
    lualine_c = { { project_name_display } },
    lualine_x = {},
  },
  inactive_sections = {},
  extensions = { "nvim-tree" },
}

-- Inserts a component in lualine_c ot left section
local function ins_left(component)
  table.insert(config.sections.lualine_c, component)
end

-- Inserts a component in lualine_x ot right section
local function ins_right(component)
  table.insert(config.sections.lualine_x, component)
end

-- ins_left {
--     'branch',
--     icon = '',
--     condition = conditions.check_git_workspace,
--     -- color = {fg = colors.violet, gui = 'bold'},
-- }

ins_left({
  "filename",
  condition = conditions.buffer_not_empty,
  -- color = {fg = colors.magenta, gui = 'bold'},
})

ins_left({
  -- filesize component
  function()
    local function format_file_size(file)
      local size = vim.fn.getfsize(file)
      if size <= 0 then
        return ""
      end
      local sufixes = { "b", "k", "m", "g" }
      local i = 1
      while size > 1024 do
        size = size / 1024
        i = i + 1
      end
      return string.format("%.1f%s", size, sufixes[i])
    end

    local file = vim.fn.expand("%:p")
    if string.len(file) == 0 then
      return ""
    end
    return format_file_size(file)
  end,
  condition = conditions.buffer_not_empty,
})

ins_left({
  "diagnostics",
  sources = { "nvim_diagnostic" },
  symbols = { error = " ", warn = " ", info = " " },
  color_error = colors.red,
  color_warn = colors.yellow,
  color_info = colors.cyan,
})

-- Insert mid section. You can make any number of sections in neovim :)
-- for lualine it's any number gretter then 2
-- ins_left {function() return '%=' end}

ins_right({
  -- Lsp server name .
  function()
    local msg = "No Active Lsp"
    local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
    local clients = vim.lsp.get_active_clients()
    if next(clients) == nil then
      return msg
    end
    for _, client in ipairs(clients) do
      local filetypes = client.config.filetypes
      if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
        return client.name
      end
    end
    return msg
  end,
  -- icon = ' LSP:',
  icon = " ",
  color = { fg = colors.aqua, gui = "bold" },
})

-- Add components to right sections
ins_right({
  "o:encoding", -- option component same as &encoding in viml
  upper = true, -- I'm not sure why it's uper case either ;)
  condition = conditions.hide_in_width,
  -- color = {fg = colors.green, gui = 'bold'}
})

ins_right({
  "fileformat",
  upper = true,
  icons_enabled = true, -- I think icons are cool but Eviline doesn't have them. sigh
  -- color = {fg = colors.green, gui='bold'},
})

ins_right({
  "diff",
  -- Is it me or the symbol for modified us really weird
  symbols = { added = " ", modified = "柳 ", removed = " " },
  color_added = colors.green,
  color_modified = colors.orange,
  color_removed = colors.red,
  condition = conditions.hide_in_width,
})

-- Now don't forget to initialize lualine
lualine.setup(config)
