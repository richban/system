EXEPATH=$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)
CWD=${EXEPATH}/../bundle

if ! brew ls --versions python > /dev/null; then
    brew install python && brew pin python
fi


if ! brew ls --versions pyenv > /dev/null; then
    brew install pyenv
    brew install pyenv-virtualenv
fi

if ! brew ls --versions pipenv > /dev/null; then
    brew install pipenv
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

# Install packages globally
~/.pyenv/versions/3.8.5/bin/pip install --upgrade pip
~/.pyenv/versions/3.8.5/bin/pip install -r ${CWD}/Pipfile

# install poetry
if ! command -v poetry > /dev/null; then
    url -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/get-poetry.py | python -
fi

# for the jupyter qt console
if ! brew ls --versions pyqt > /dev/null; then
    brew install pyqt
fi

if ! brew ls --versions pipx > /dev/null; then
    brew install pipx
    pipx ensurepath
fi

pipx reinstall-all
pipx install neovim-remote

# PDM package manager
if ! command -v pipx > /dev/null; then
    pipx install pdm
    pipx inject pdm pdm-venv
    export PATH="/Users/$(whoami)/.local/bin:$PATH"
fi
