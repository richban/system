local components = require("rb.statusline.components")

require("lualine").setup({
  options = {
    icons_enabled = true,
    theme = "tokyonight",
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
    lualine_x = { "location" },
    lualine_y = {},
    lualine_z = {},
  },
  extensions = { "nvim-tree", "toggleterm", "quickfix" },
})
