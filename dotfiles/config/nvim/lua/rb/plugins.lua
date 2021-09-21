local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
  execute('!git clone https://github.com/wbthomason/packer.nvim '..install_path)
-- Only required if you have packer configured as `opt`
-- vim.cmd [[packadd packer.nvim]]
end


return require('packer').startup {
  function(use)
    use {'nathangrigg/vim-beancount'}
    use 'nvim-lua/plenary.nvim'

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
    -- use 'scrooloose/nerdtree'
    -- use {
    --   'ms-jpq/chadtree',
    --   branch = 'chad',
    --   run = 'python3 -m chadtree deps'
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
    
    -- Motion
    use 'karb94/neoscroll.nvim'
    -- use 'yuttie/comfortable-motion.vim'
    use 'easymotion/vim-easymotion'
    
    -- Text Manipulation
    use 'Yggdroot/indentLine'
    use 'Raimondi/delimitMate'
    use 'godlygeek/tabular'
    use 'justinmk/vim-sneak'
    use 'tpope/vim-commentary'
    use 'tpope/vim-surround' -- Change surrounding arks
    use 'tpope/vim-repeat' -- extends . repeat, for example for make it work with vim-sneak
    use({
        'windwp/nvim-autopairs',
        after = 'nvim-cmp',
    })
    
    -- Snippets
    use({
        'L3MON4D3/LuaSnip',
        requires = {'rafamadriz/friendly-snippets'},
        config = function() require('rb.plugins.snippets') end
    })
    use({'saadparwaiz1/cmp_luasnip', after = 'nvim-cmp'})

    -- use 'norcalli/snippets.nvim'
    -- use 'hrsh7th/vim-vsnip'
    -- use 'hrsh7th/vim-vsnip-integ'

    -- Completion Engine
    use {
        'hrsh7th/nvim-cmp',
        config = function() require 'rb.plugins.nvim-cmp' end,
        event = 'InsertEnter'
    }
    use({'hrsh7th/cmp-nvim-lsp', after = 'nvim-cmp'})
    use({'hrsh7th/cmp-buffer', after = 'nvim-cmp'})
    use({'hrsh7th/cmp-path', after = 'nvim-cmp'})
    use({'hrsh7th/cmp-nvim-lua', after = 'nvim-cmp'})

    -- Markdown Preview in the browser
    use {
        'iamcco/markdown-preview.nvim',
        run = 'cd app && yarn install',
        cmd = 'MarkdownPreview'
    }
    use 'junegunn/goyo.vim'

    -- Themes
    use 'marko-cerovac/material.nvim'
    use {"npxbr/gruvbox.nvim", requires = {"rktjmp/lush.nvim"}}
    use "projekt0n/github-nvim-theme"
    -- use 'pineapplegiant/spaceduck'
    
    -- Icons
    use 'ryanoasis/vim-devicons'
    use 'kyazdani42/nvim-web-devicons'
    
    -- Highlight hex, rgb colors
    use 'norcalli/nvim-colorizer.lua'
    
    -- Status line
    use {
      'hoob3rt/lualine.nvim',
      requires = {'kyazdani42/nvim-web-devicons', opt = true}
    }

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
    use 'nvim-telescope/telescope-fzy-native.nvim'
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
    use 'haringsrob/nvim_context_vt' -- shows treesitter context in end of parenthesis
    
    -- firenvim
    use {
      'glacambre/firenvim',
      run = function()
        vim.fn['firenvim#install'](1)
      end
    }
  end
}
