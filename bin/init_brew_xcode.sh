#! /usr/bin/env bash

EXEPATH=$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)
DEV_PATH=Developer

xcode-select --install
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# brew tap homebrew/bundle
# brew install zsh
# sudo sh -c 'echo /usr/local/bin/zsh >> /etc/shells'
# sudo chsh -s /usr/local/bin/zsh
# chmod 755 /usr/local/share/zsh
# chmod 755 /usr/local/share/zsh/site-functions
mkdir -p ${HOME}/${DEV_PATH}