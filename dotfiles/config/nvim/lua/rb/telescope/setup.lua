if not pcall(require, "telescope") then
  return
end

local actions = require("telescope.actions")

require("telescope").setup({
  defaults = {
    timeoutlen = 2000,
    mappings = { i = { ["<esc>"] = actions.close } },
    vimgrep_arguments = {
      "rg",
      "--color=never",
      "--no-heading",
      "--with-filename",
      "--line-number",
      "--column",
      "--smart-case",
    },
    prompt_prefix = " ",
    selection_caret = " ",
    initial_mode = "insert",
    selection_strategy = "reset",
    sorting_strategy = "ascending",

    layout_strategy = "horizontal",
    layout_config = {
      width = 0.95,
      height = 0.85,
      preview_cutoff = 120,
      prompt_position = "top",
      horizontal = {
        -- width_padding = 0.1,
        -- height_padding = 0.1,
        preview_width = function(_, cols, _)
          if cols > 200 then
            return math.floor(cols * 0.4)
          else
            return math.floor(cols * 0.6)
          end
        end,
      },

      vertical = {
        -- width_padding = 0.05,
        -- height_padding = 1,
        width = 0.9,
        height = 0.95,
        preview_height = 0.5,
      },

      flex = { horizontal = { preview_width = 0.9 } },
    },

    file_sorter = require("telescope.sorters").get_fuzzy_file,
    file_ignore_patterns = {
      ".backup",
      ".swap",
      ".langsevers",
      ".session",
      ".undo",
      "*.git",
      "node_modules",
      "vendor",
      ".vscode-server",
      ".Desktop",
      ".Documents",
      "classes",
    },
    generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
    -- path_display = true,
    winblend = 0,
    border = {},
    borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
    color_devicons = true,
    use_less = true,
    set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,

    file_previewer = require("telescope.previewers").vim_buffer_cat.new, -- For buffer previewer use `require'telescope.previewers'.vim_buffer_cat.new`
    grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new, -- For buffer previewer use `require'telescope.previewers'.vim_buffer_vimgrep.new`
    qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new, -- For buffer previewer use `require'telescope.previewers'.vim_buffer_qflist.new`

    -- Developer configurations: Not meant for general override
    -- buffer_previewer_maker = require'telescope.previewers'.buffer_previewer_maker
  },
  extensions = {
    fzf = {
      fuzzy = true, -- false will only do exact matching
      override_generic_sorter = false,
      override_file_sorter = true,
      case_mode = "smart_case", -- this is default
    },
    -- fzy_native = {
    --     override_generic_sorter = false,
    --     override_file_sorter = true,
    -- },
    media_files = {
      -- filetypes whitelist
      -- defaults to {"png", "jpg", "mp4", "webm", "pdf"}
      filetypes = { "png", "webp", "jpg", "jpeg", "mp4", "pdf" },
      find_cmd = "rg", -- find command (defaults to `fd`)
    },
    fzf_writer = { use_highlighter = false, minimum_grep_characters = 6 },
    frecency = {},
    ["ui-select"] = {
      require("telescope.themes").get_dropdown(),
    },
    workspaces = {
      -- keep insert mode after selection in the picker, default is false
      keep_insert = true,
    },
  },
})

-- Load the fzy native extension at the start.
pcall(require("telescope").load_extension, "fzf")
pcall(require("telescope").load_extension, "ui-select")

-- github CLI
pcall(require("telescope").load_extension, "gh")
if vim.fn.executable("gh") == 1 then
  pcall(require("telescope").load_extension, "gh")
  pcall(require("telescope").load_extension, "octo")
end

pcall(require("telescope").load_extension, "cheat")
pcall(require("telescope").load_extension, "dap")
pcall(require("telescope").load_extension, "file_browser")
pcall(require("telescope").load_extension, "project")

pcall(require("telescope").load_extension, "frecency")
pcall(require("telescope").load_extension, "projections")
