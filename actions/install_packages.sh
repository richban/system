EXEPATH=$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)
CWD=${EXEPATH}/../bundle

## ========== Brew Bundle ==========
brew upgrade
brew bundle --file ${CWD}/Brewfile
brew cleanup

## ========== Xcode ==========
sudo xcodebuild -license accept

## ========== Npm ==========
## - npm list -g --depth 0 | sed '1d' | awk '{ print $2 }' | awk -F'@[0-9]' '{ print $1 }' > Npmfile
npm update -g npm
npm install -g $(cat ${CWD}/Npmfile)

## ========== nvm ==========
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash

# ## ========== asdf ==========
# if [[ ! -d "$HOME"/.asdf/plugins/python ]]; then
# 	"$HOME"/.asdf/bin/asdf plugin-add python https://github.com/danhper/asdf-python.git
# fi
# if [[ ! -d "$HOME"/.asdf/installs/python ]]; then
# 	"$HOME"/.asdf/bin/asdf plugin add python
# 	"$HOME"/.asdf/bin/asdf install python 3.8.5
# fi


## ========== Rust ==========
# rustup-init -y
# source ${HOME}/.cargo/env
# rustup component add rls --toolchain stable
# rustup component add rust-src --toolchain stable
# rustup component add rls-preview --toolchain stable
# rustup component add rust-analysis --toolchain stable
# crates=($(cat ${CWD}/Cargofile))
# for crate in ${crates}; do
# 	cargo install -f --git "${crate}"
# done

## ========== Perl ==========
# PERL_MM_USE_DEFAULT=1 PERL_MM_OPT="INSTALL_BASE=$HOME/perl5" cpan local::lib
# eval $(perl -I$HOME/perl5/lib/perl5 -Mlocal::lib)
# cpan App::cpanminus
# cpanm $(cat ${CWD}/Cpanfile)

## ========== Git ==========
sudo ln -sfnv /usr/local/share/git-core/contrib/diff-highlight/diff-highlight /usr/local/bin/diff-highlight

## ========== Zinit ==========
# sh -c "$(curl -fsSL https://raw.githubusercontent.com/zdharma/zinit/master/doc/install.sh)"
# zinit self-update
# source ${HOME}/.zshrc

## ========== Vim ==========
# curl -fLo ${HOME}/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
# vim +'PlugInstall --sync' +qa
# curl -fLo ${HOME}/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
# nvim +'PlugInstall --sync' +qa

## ========== Tmux ==========
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
/bin/bash ${HOME}/.tmux/plugins/tpm/scripts/install_plugins.sh

## ========== MySQL ==========
# mysql_secure_installation
# - This can be automated by expect, but can't be public.
# - [Ref] https://gist.github.com/Mins/4602864

## ========== Gcloud ==========
curl https://sdk.cloud.google.com | /bin/bash -s -- --disable-prompts

## ========== iTerm2 ==========
# curl -L https://iterm2.com/shell_integration/install_shell_integration_and_utilities.sh | bash

## ========== Anyenv ==========
# if [ ! -d ${HOME}/.config/anyenv/anyenv-install ]; then
# 	expect -c "
# 		spawn anyenv install --init
# 		expect \"Do you want to checkout ? \[y\/N\]: \"
# 		send \"y\n\"
# 		expect eof
# 	"
# fi

## ========== Docker ==========
mkdir -p ${HOME}/.zsh/completion
curl -L https://raw.githubusercontent.com/docker/compose/1.25.4/contrib/completion/zsh/_docker-compose > ~/.zsh/completion/_docker-compose
curl -L https://raw.githubusercontent.com/docker/machine/v0.16.0/contrib/completion/zsh/_docker-machine > ~/.zsh/completion/_docker-machine

## ========== Remote pbcopy ==========
# if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
# 	curl -fsSLo pbcopy-linux-amd64.tar.gz https://github.com/skaji/remote-pbcopy-iterm2/releases/latest/download/pbcopy-linux-amd64.tar.gz
# 	tar --remove-files xf pbcopy-linux-amd64.tar.gz
# 	mv pbcopy ~/pbcopy
# fi

## ========== VSCode ==========
## - code --list-extensions > Vsplug
# if ! ${TESTMODE}; then
#     plugins=($(cat ${CWD}/VSCodeplug))
#     for plugin in ${plugins}; do
#         code --install-extension ${plugin}
#     done
# fi

## ========== Yabai ==========
# brew services start skhd
# brew services start yabai
