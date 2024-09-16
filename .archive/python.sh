#! /usr/bin/env bash

EXEPATH=$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)
CWD=${EXEPATH}/../bundle

if ! brew ls --versions python >/dev/null; then
  brew install python && brew pin python
fi

if ! brew ls --versions pyenv >/dev/null; then
  brew install pyenv
  brew install pyenv-virtualenv
fi

if ! brew ls --versions pipenv >/dev/null; then
  brew install pipenv
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
  $HOME/.pyenv/versions/neovim3/bin/pip install --upgrade --no-cache neovim pynvim doq qtconsole pylsp-mypy python-lsp-black pyls-isort pyls-flake8 pyls-memestra pep8-naming jedi 'python-lsp-server[all]' jupyter_qtconsole_colorschemes
fi

# Install packages globally
~/.pyenv/versions/3.9.4/bin/pip install --upgrade pip
~/.pyenv/versions/3.9.4/bin/pip install -r ${CWD}/Pipfile

# install poetry
if ! command -v poetry >/dev/null; then
  curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/get-poetry.py | python -
fi

# for the jupyter qt console
if ! brew ls --versions pyqt >/dev/null; then
  brew install pyqt
fi

if ! brew ls --versions pipx >/dev/null; then
  brew install pipx
  pipx ensurepath
fi

pipx reinstall-all
pipx install neovim-remote
pipx install 'python-lsp-server[all]'

# PDM package manager
if ! command -v pipx >/dev/null; then
  pipx install pdm
  pipx inject pdm pdm-venv
  export PATH="/Users/$(whoami)/.local/bin:$PATH"
fi
