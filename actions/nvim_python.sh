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
    pyenv install 3.8.5
    pyenv global 3.8.5
    pyenv virtualenv 3.8.5 neovim3
    $HOME/.pyenv/versions/neovim3/bin/pip install --upgrade --no-cache neovim pynvim doq qtconsole 'python_language_server[all]' mypy-ls pyls-black flake8 pep8-naming jedi jupyter_qtconsole_colorschemes
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