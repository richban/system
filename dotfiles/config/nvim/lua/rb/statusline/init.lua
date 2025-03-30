local components = require("rb.statusline.components")

-- Create a Codeium status component
local codeium_status = function()
  return vim.api.nvim_call_function("codeium#GetStatusString", {})
end

require("lualine").setup({
  options = {
    icons_enabled = true,
    theme = "catppuccin",
    component_separators = {},
    section_separators = {},
    disabled_filetypes = {
      statusline = { "alpha", "lazy" },
      winbar = {
        "help",
        "alpha",
        "lazy",
      },
    },
    always_divide_middle = true,
    globalstatus = true,
  },
  sections = {
    lualine_a = { "mode" },
    lualine_b = { components.git_repo, "branch" },
    lualine_c = { components.diff, components.diagnostics, components.separator, components.lsp_client },
    lualine_x = { "copilot", "filename", "encoding", "fileformat", "filetype", "progress" },
    lualine_y = {},
    lualine_z = { "location" },
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { "filename" },
    lualine_x = { "location", codeium_status },
    lualine_y = {},
    lualine_z = {},
  },
  extensions = { "nvim-tree", "toggleterm", "quickfix" },
})
