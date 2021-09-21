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
    -- Packer can manage itself as an optional plugin
    use {'wbthomason/packer.nvim'}

    -- fzf
    use {'junegunn/fzf', run = './install --all' }
    use {'junegunn/fzf.vim'}
    use 'ojroques/nvim-lspfuzzy'
    -- git
    use 'tpope/vim-fugitive'
    -- use 'airblade/vim-gitgutter'
    -- Github integration
    use {
        'pwntester/octo.nvim',
        -- cmd = { 'Octo' },
      }
    use 'nvim-lua/plenary.nvim'
    use {
      'lewis6991/gitsigns.nvim',
      requires = {
        'nvim-lua/plenary.nvim'
      },
    }
    -- utils
    -- use 'scrooloose/nerdtree'
    -- use {
    --   'ms-jpq/chadtree',
    --   branch = 'chad',
    --   run = 'python3 -m chadtree deps'

    -- }
    use 'editorconfig/editorconfig-vim'
    use 'christoomey/vim-tmux-navigator'
    use 'mhinz/vim-startify'
    use 'tweekmonster/startuptime.vim'
    use 'antoinemadec/FixCursorHold.nvim' -- Fix CursorHold Performance
    use 'vim-utils/vim-man'
    use 'mbbill/undotree'
    use 'liuchengxu/vista.vim'
    use 'Pocco81/ISuckAtSpelling.nvim'
    -- use 'dstein64/nvim-scrollview'
    use 'wakatime/vim-wakatime'
    -- motion
    use 'yuttie/comfortable-motion.vim'
    use 'easymotion/vim-easymotion'
    -- text
    use 'Yggdroot/indentLine'
    use 'Raimondi/delimitMate'
    use 'godlygeek/tabular'
    use 'justinmk/vim-sneak'
    use 'tpope/vim-commentary'
    use 'tpope/vim-surround' -- Change surrounding arks
    use 'tpope/vim-repeat' -- extends . repeat, for example for make it work with vim-sneak

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
    use 'heavenshell/vim-jsdoc'
    use 'junegunn/goyo.vim'
    -- colors and theme
    use 'marko-cerovac/material.nvim'
    use {"npxbr/gruvbox.nvim", requires = {"rktjmp/lush.nvim"}}
    -- use 'morhetz/gruvbox'
    -- use 'sainnhe/gruvbox-material'
    -- use 'pineapplegiant/spaceduck'
    use 'ryanoasis/vim-devicons'
    use 'kyazdani42/nvim-web-devicons'
    -- highlight hex, rgb colors
    use 'norcalli/nvim-colorizer.lua'
    -- status line
    -- use 'itchyny/lightline.vim'
    use {
      'hoob3rt/lualine.nvim',
      requires = {'kyazdani42/nvim-web-devicons', opt = true}
    }
    use 'jose-elias-alvarez/nvim-lsp-ts-utils'
    -- LSP
    -- used to install LSP Servers
    -- use 'prabirshrestha/vim-lsp'
    -- use 'mattn/vim-lsp-settings'

    use 'neovim/nvim-lspconfig'
    -- use 'nvim-lua/completion-nvim'
    use 'glepnir/lspsaga.nvim'
    use 'onsails/lspkind-nvim'

    use 'nvim-lua/lsp-status.nvim'
    use 'tjdevries/lsp_extensions.nvim'
    use 'ray-x/lsp_signature.nvim'
    -- use {
    --   'hrsh7th/nvim-compe', branch = 'master'
    -- }
    use 'Vimjas/vim-python-pep8-indent'
    use {
      'heavenshell/vim-pydocstring',
      run = 'make install'
    }
    -- jupyter
    use 'bfredl/nvim-ipy'
    use 'hkupty/iron.nvim'
    -- use 'untitled-ai/jupyter_ascending.vim'
    -- use 'GCBallesteros/jupytext.vim'
    -- use 'kana/vim-textobj-line'
    -- use 'kana/vim-textobj-user'
    -- use 'GCBallesteros/vim-textobj-hydrogen'
    -- telescope
    use 'nvim-lua/popup.nvim'
    use 'nvim-telescope/telescope.nvim'
    use 'nvim-telescope/telescope-fzy-native.nvim'
    use 'nvim-telescope/telescope-fzf-writer.nvim'
    use 'nvim-telescope/telescope-packer.nvim'
    -- preview media files
    use 'nvim-telescope/telescope-media-files.nvim'
    -- intelligent prioritization when selecting files
    use {
      "nvim-telescope/telescope-frecency.nvim",
      config = function()
        require"telescope".load_extension("frecency")
      end
    }
    use 'tami5/sql.nvim'
    use 'nvim-telescope/telescope-cheat.nvim'
    -- Language packs
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
  end
}
