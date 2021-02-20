-- Only required if you have packer in your `opt` pack
local packer_exists = pcall(vim.cmd, [[packadd packer.nvim]])

if not packer_exists then
  -- TODO: Maybe handle windows better?
  if vim.fn.input("Download Packer? (y for yes)") ~= "y" then
    return
  end

  local directory = string.format(
    '%s/site/pack/packer/opt/',
    vim.fn.stdpath('data')
  )

  vim.fn.mkdir(directory, 'p')

  local out = vim.fn.system(string.format(
    'git clone %s %s',
    'https://github.com/wbthomason/packer.nvim',
    directory .. '/packer.nvim'
  ))

  print(out)
  print("Downloading packer.nvim...")

  return
end

return require('packer').startup {
  function(use)
    -- Packer can manage itself as an optional plugin
    use {'wbthomason/packer.nvim', opt = true}
    -- fzf
    use {'junegunn/fzf', run = './install --all' }
    use {'junegunn/fzf.vim'}
    use 'ojroques/nvim-lspfuzzy'
    -- git
    use 'tpope/vim-fugitive'
    -- use 'airblade/vim-gitgutter'
    use 'lewis6991/gitsigns.nvim'
    -- utils
    use 'scrooloose/nerdtree'
    use 'christoomey/vim-tmux-navigator'
    use 'mhinz/vim-startify'
    use 'tweekmonster/startuptime.vim'
    use 'antoinemadec/FixCursorHold.nvim' -- Fix CursorHold Performance
    use 'vim-utils/vim-man'
    use 'mbbill/undotree'
    use 'liuchengxu/vista.vim'
    use 'dstein64/nvim-scrollview'
    -- use 'wakatime/vim-wakatime'
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
    -- snippets
    use 'norcalli/snippets.nvim'
    use 'hrsh7th/vim-vsnip'
    use 'hrsh7th/vim-vsnip-integ'
    -- markdown
    use {
        'iamcco/markdown-preview.nvim',
        run = 'cd app && yarn install',
        cmd = 'MarkdownPreview'
    }
    use 'junegunn/goyo.vim'
    -- colors and theme
    use 'morhetz/gruvbox'
    use 'sainnhe/gruvbox-material'
    use 'pineapplegiant/spaceduck'
    use 'ryanoasis/vim-devicons'
    use 'kyazdani42/nvim-web-devicons'
    -- highlight hex, rgb colors
    use 'norcalli/nvim-colorizer.lua'
    -- status line
    use 'itchyny/lightline.vim'
    -- LSP
    use 'anott03/nvim-lspinstall'
    use 'neovim/nvim-lspconfig'
    -- use 'nvim-lua/completion-nvim'
    use 'glepnir/lspsaga.nvim'
    use 'onsails/lspkind-nvim'
    use 'nvim-lua/lsp-status.nvim'
    use 'tjdevries/lsp_extensions.nvim'
    use {
      'hrsh7th/nvim-compe', branch = 'master'
    }
    -- jupyter
    use 'untitled-ai/jupyter_ascending.vim'
    use 'bfredl/nvim-ipy'
    use 'hkupty/iron.nvim'
    use 'Vimjas/vim-python-pep8-indent'
    use 'heavenshell/vim-pydocstring'
    use 'GCBallesteros/jupytext.vim'
    use 'kana/vim-textobj-line'
    use 'kana/vim-textobj-user'
    use 'GCBallesteros/vim-textobj-hydrogen'
    -- telescope
    use 'nvim-lua/popup.nvim'
    use 'nvim-lua/plenary.nvim'
    use 'nvim-telescope/telescope.nvim'
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
