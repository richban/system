local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
  execute('!git clone https://github.com/wbthomason/packer.nvim '..install_path)
-- Only required if you have packer configured as `opt`
-- vim.cmd [[packadd packer.nvim]]
end

vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])

return require('packer').startup {
  function(use)
    use {'nathangrigg/vim-beancount'}
    use 'nvim-lua/plenary.nvim'

    -- Icons
    use 'kyazdani42/nvim-web-devicons'

    -- Packer can manage itself as an optional plugin
    use {'wbthomason/packer.nvim'}

    -- fzf
    use {'junegunn/fzf', run = './install --all' }
    use {'junegunn/fzf.vim'}
    use 'ojroques/nvim-lspfuzzy'

    -- git
    use 'tpope/vim-fugitive'
    use {
      'lewis6991/gitsigns.nvim',
      requires = {
        'nvim-lua/plenary.nvim'
      },
    }

    -- Github integration
    use {
        'pwntester/octo.nvim',
        -- cmd = { 'Octo' },
      }

    -- File Manager
    use {
      'kyazdani42/nvim-tree.lua',
      requires = 'kyazdani42/nvim-web-devicons'
    }

    -- use {
    --   'ms-jpq/chadtree',
    --   branch = 'chad',
    --   run = ':CHADdeps'
    -- }


    use 'liuchengxu/vista.vim'


    -- Utils
    use 'tweekmonster/startuptime.vim'
    use 'mhinz/vim-startify'
    use 'editorconfig/editorconfig-vim'
    use 'christoomey/vim-tmux-navigator'
    use 'antoinemadec/FixCursorHold.nvim' -- Fix CursorHold Performance
    use 'vim-utils/vim-man'
    use 'mbbill/undotree'
    use 'Pocco81/ISuckAtSpelling.nvim'
    use 'wakatime/vim-wakatime'
    use {
      'jdhao/better-escape.vim',
      event = 'InsertEnter',
      config = function()
        vim.g.better_escape_shortcut = 'jk'
      end
    }

    use {
      "folke/todo-comments.nvim",
      requires = "nvim-lua/plenary.nvim",
      config = function()
        require("todo-comments").setup {}
        -- :TodoQuickFix
        -- :TodoLocList
        -- :TodoTelescope
      end
    }

    use 'kristijanhusak/vim-carbon-now-sh'

    -- in-editor annotations
    -- use 'haringsrob/nvim_context_vt' -- shows treesitter context in end of parenthesis
    -- use { 'code-biscuits/nvim-biscuits', disable = true }

    -- dims inactive portions of the code you're editing
    use {
      "folke/twilight.nvim",
      config = function()
        require("twilight").setup {
          -- your configuration comes here
          -- or leave it empty to use the default settings
          -- refer to the configuration section below
        }
      end
    }

    use { 'lukas-reineke/indent-blankline.nvim' }

    -- Motion
    use 'karb94/neoscroll.nvim'
    use 'easymotion/vim-easymotion'

    -- Text Manipulation
    use 'Raimondi/delimitMate'
    use 'godlygeek/tabular'
    use 'justinmk/vim-sneak'
    use 'tpope/vim-commentary'
    use 'tpope/vim-surround' -- Change surrounding arks
    use 'tpope/vim-repeat' -- extends . repeat, for example for make it work with vim-sneak
    use({
        'windwp/nvim-autopairs',
        after = 'nvim-cmp',
        disable = true
    })

    -- Snippets
    -- use({
    --     'L3MON4D3/LuaSnip',
    --     requires = {'rafamadriz/friendly-snippets'},
    --     config = function() require('rb.plugins.snippets') end
    -- })
    -- use({'saadparwaiz1/cmp_luasnip', after = 'nvim-cmp'})

    -- use 'norcalli/snippets.nvim'
    -- use 'hrsh7th/vim-vsnip'
    -- use 'hrsh7th/vim-vsnip-integ'


    -- Completion Engine
    use {
        'hrsh7th/nvim-cmp',
        config = function() require 'rb.plugins.nvim-cmp' end,
        event = 'InsertEnter',
        opt = false,
        requires = {
          { "hrsh7th/cmp-buffer" },
          { "hrsh7th/cmp-nvim-lsp" },
          { "hrsh7th/cmp-path" },
          { "hrsh7th/cmp-nvim-lua" },
          { "ray-x/cmp-treesitter" },
          { "hrsh7th/nvim-cmp" },
          { "hrsh7th/cmp-vsnip" },
          { "hrsh7th/vim-vsnip" },
          { "hrsh7th/vim-vsnip-integ" },
          { "Saecki/crates.nvim" },
          { "f3fora/cmp-spell" },
        },
    }

    -- Markdown Preview in the browser
    use {
        'iamcco/markdown-preview.nvim',
        run = 'cd app && yarn install',
        cmd = 'MarkdownPreview'
    }
    use 'junegunn/goyo.vim'

    -- Status line
    use {
      'hoob3rt/lualine.nvim',
      requires = {'kyazdani42/nvim-web-devicons'},
      config = function() require "rb.plugins.statusline" end
    }

    -- Themes
    use {
      "projekt0n/github-nvim-theme",
      after = "lualine.nvim",
      config = function()
        -- require("github-theme").setup({
        --   theme_style = "dark",
        --   comment_style = "italic",
        --   sidebars = {"qf", "vista_kind", "terminal", "packer"},
        --   dark_sidebar = false,
        --   -- Change the "hint" color to the "orange" color, and make the "error" color bright red
        --   colors = {hint = "orange", error = "#ff0000"}
        -- })
      end
    }


    use 'dracula/vim'
    use 'Mofiqul/dracula.nvim'

    -- use 'marko-cerovac/material.nvim'
    -- use {"npxbr/gruvbox.nvim", requires = {"rktjmp/lush.nvim"}}
    -- use 'pineapplegiant/spaceduck'

    -- Highlight hex, rgb colors
    use 'norcalli/nvim-colorizer.lua'

    -- Javascript & Typescript
    use 'jose-elias-alvarez/nvim-lsp-ts-utils'
    use 'heavenshell/vim-jsdoc'

    -- LSP
    use 'neovim/nvim-lspconfig'
    use 'glepnir/lspsaga.nvim'
    use 'onsails/lspkind-nvim'
    use 'nvim-lua/lsp-status.nvim'
    use 'tjdevries/lsp_extensions.nvim'
    use 'ray-x/lsp_signature.nvim'

    -- Python & Jupyter Notebooks
    use 'bfredl/nvim-ipy'
    use 'hkupty/iron.nvim'
    use 'Vimjas/vim-python-pep8-indent'
    use {
      'heavenshell/vim-pydocstring',
      run = 'make install'
    }
    -- use 'untitled-ai/jupyter_ascending.vim'
    -- use 'GCBallesteros/jupytext.vim'
    -- use 'kana/vim-textobj-line'
    -- use 'kana/vim-textobj-user'
    -- use 'GCBallesteros/vim-textobj-hydrogen'


    -- Telescope
    use 'nvim-lua/popup.nvim'
    use 'nvim-telescope/telescope.nvim'
    use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
    use 'nvim-telescope/telescope-fzf-writer.nvim'
    use 'nvim-telescope/telescope-packer.nvim'
    use 'nvim-telescope/telescope-cheat.nvim'
    -- preview media files
    use 'nvim-telescope/telescope-media-files.nvim'
    -- intelligent prioritization when selecting files
    use {
      "nvim-telescope/telescope-frecency.nvim",
      config = function()
        require"telescope".load_extension("frecency")
      end
    }

    -- SQL
    use 'tami5/sql.nvim'

    -- Treesitter
    use {
      'nvim-treesitter/nvim-treesitter',
      run = ':TSUpdate'
    }

    -- firenvim
    use {
      'glacambre/firenvim',
      run = function()
        vim.fn['firenvim#install'](1)
      end
    }
  end,
  config = {
    profile = {
      enable = true,
      threshold = 1 -- the amount in ms that a plugins load time must be over for it to be included in the profile
    },
    display = {
      open_fn = require("packer.util").float,
    },
  }
}
