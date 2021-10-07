if ! brew ls --versions pyenv > /dev/null; then
    brew install pyenv
    brew install pyenv-virtualenv
fi

# Python for Neovim - works on BigSur
if [[ ! -f $HOME/.pyenv/versions/neovim2/bin/pip ]]; then
    pyenv install 2.7.18
    pyenv virtualenv 2.7.18 neovim2
    $HOME/.pyenv/versions/neovim2/bin/pip install neovim pynvim
fi

if [[ ! -f $HOME/.pyenv/versions/neovim3/bin/pip ]]; then
    pyenv install 3.9.4
    pyenv global 3.9.4
    pyenv virtualenv 3.9.4 neovim3
    $HOME/.pyenv/versions/neovim3/bin/pip install --upgrade --no-cache neovim pynvim doq qtconsole pylsp-mypy python-lsp-black pyls-isort pyls-flake8 pyls-memestra pep8-naming 'python-lsp-server[all]' jupyter_qtconsole_colorschemes
fi

# Download latest nightly build
if [[ ! -f $HOME/Developer/nvim-osx64/bin/nvim ]]; then
      cd $HOME/Developer
      wget https://github.com/neovim/neovim/releases/download/nightly/nvim-macos.tar.gz > /dev/null
      tar zxvf nvim-macos.tar.gz > /dev/null
fi

# Install packer
if [[ ! -d ~/.local/share/nvim/site/pack/packer/start/packer.nvim ]]; then
    git clone https://github.com/wbthomason/packer.nvim \
      ~/.local/share/nvim/site/pack/packer/start/packer.nvim
fi

# Install language servers
npm i -g neovim
npm i -g diagnostic-languageserver
npm i -g bash-language-server
npm i -g vscode-html-languageserver-bin
npm i -g vscode-css-languageserver-bin
npm i -g vim-language-server
npm i -g yaml-language-server
npm i -g vscode-json-languageserver
npm i -g typescript-language-server
npm i -g sql-language-server
npm i -g vue-language-server
npm i -g dockerfile-language-server-nodejs
npm i -g vls
npm i -g pyright