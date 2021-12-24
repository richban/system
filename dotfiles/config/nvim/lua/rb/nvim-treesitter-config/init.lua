-- https://github.com/tree-sitter/tree-sitter-haskell#building-on-macos
require'nvim-treesitter.install'.compilers = {"gcc"}

-- local treesitter = require'nvim-treesitter.configs'

-- treesitter.setup {
--   ensure_installed = "all",
--   highlight = {
--     enable = true,
--   },
-- }

require("nvim-treesitter.configs").setup {
  highlight = {enable = true, additional_vim_regex_highlighting = true},
  incremental_selection = {
    enable = true,
    keymaps = {init_selection = "gnn", node_incremental = "grn", scope_incremental = "grc", node_decremental = "grm"}
  },
  indent = {enable = true},
  matchup = {enable = true},
  autopairs = {enable = true},
  playground = {
    enable = true,
    disable = {},
    updatetime = 25,
    persist_queries = false,
    keybindings = {
      toggle_query_editor = "o",
      toggle_hl_groups = "i",
      toggle_injected_languages = "t",
      toggle_anonymous_nodes = "a",
      toggle_language_display = "I",
      focus_language = "f",
      unfocus_language = "F",
      update = "R",
      goto_node = "<cr>",
      show_help = "?"
    }
  },
  rainbow = {
    enable = true,
    extended_mode = true, -- Highlight also non-parentheses delimiters
    max_file_lines = 1000
  },
  refactor = {
    smart_rename = {enable = true, keymaps = {smart_rename = "grr"}},
    highlight_definitions = {enable = true},
    navigation = {
      enable = true,
      keymaps = {
        goto_definition_lsp_fallback = "gnd",
        -- list_definitions = "gnD",
        -- list_definitions_toc = "gO",
        -- @TODOUA: figure out if I need the 2 below
        goto_next_usage = "<a-*>", -- is this redundant?
        goto_previous_usage = "<a-#>" -- also this one?
      }
    }
    -- highlight_current_scope = {enable = true}
  },
  textobjects = {
    lsp_interop = {enable = true, border = "none", peek_definition_code = {["df"] = "@function.outer", ["dF"] = "@class.outer"}},
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {["]m"] = "@function.outer", ["]]"] = "@class.outer"},
      goto_next_end = {["]M"] = "@function.outer", ["]["] = "@class.outer"},
      goto_previous_start = {["[m"] = "@function.outer", ["[["] = "@class.outer"},
      goto_previous_end = {["[M"] = "@function.outer", ["[]"] = "@class.outer"}
    },
    -- @TODOUA: these selectors may or may not helpful workflow
    select = {
      enable = true,
      lookahead = true,
      keymaps = {["af"] = "@function.outer", ["if"] = "@function.inner", ["ac"] = "@class.outer", ["ic"] = "@class.inner"}
    }
  }
}

