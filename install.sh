#!/bin/bash

source ./echos.sh

if [[ "$OSTYPE" != "darwin"* ]]; then
	bot "MacOS only available."
	exit 1
fi

shopt -s dotglob
TESTMODE=false
EXEPATH=$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)
DEV_PATH=Developer
USER=richban
EMAIL=rbanyi@me.com

## ----------------------------------------
##	Functions
## ----------------------------------------
symlink_dotfiles() {
	handle_symlink_from_file() {
		file=$1
		dirpath=$(dirname "${file}") && filename=$(basename "${file}")
		abspath=$(cd "${dirpath}" && pwd)"/${filename}"
		relpath=$(echo "${file}" | sed "s|^\./dotfiles/||")
		target="${HOME}/${relpath}"
		mkdir -p "$(dirname "${target}")"
		ln -sfnv "${abspath}" "${target}" > /dev/null
	}
	export -f handle_symlink_from_file
	find ./dotfiles \( -type l -o -type f \) -exec bash -c 'handle_symlink_from_file "{}"' \;

	if ! ${TESTMODE}; then
		zinit self-update
		source ${HOME}/.zshrc
		vim  +'PlugInstall --sync' +qa
		nvim +'PlugInstall --sync' +qa
		/bin/bash ${HOME}/.tmux/plugins/tpm/scripts/install_plugins.sh
	fi
}

install_dotfiles() {
	CWD=${EXEPATH}/dotdrop
	pip3 install --user -r ${CWD}/requirements.txt
	${CWD}/dotdrop.sh install --profile=${PROFILE}
}

configure_system() {
	CWD=${EXEPATH}/system
	osascript -e 'tell application "System Preferences" to quit' > /dev/null 2>&1
	/bin/bash ${CWD}/darwin.sh ${TESTMODE}
}

install_bundle() {
	CWD=${EXEPATH}/bundle

	## ========== Brew Bundle ==========
	brew upgrade
	brew bundle --file ${CWD}/Brewfile


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
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/zdharma/zinit/master/doc/install.sh)"
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
	if ! ${TESTMODE}; then
		plugins=($(cat ${CWD}/VSCodeplug))
		for plugin in ${plugins}; do
			code --install-extension ${plugin}
		done
	fi

	## ========== Yabai ==========
	# brew services start skhd
	# brew services start yabai
}

initialize() {
	if ! ${TESTMODE}; then
		xcode-select --install
		/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

		mkdir -p ${HOME}/.ssh
		ssh-keygen -t rsa -b 4096 -C "${EMAIL}"
		ssh-keyscan -t rsa github.com >> ${HOME}/.ssh/known_hosts
		curl -u "${USER}" --data "{\"title\":\"NewSSHKey\",\"key\":\"`cat ~/.ssh/id_rsa.pub`\"}" https://api.github.com/user/keys
	fi

	brew tap homebrew/bundle
	brew install zsh
	sudo sh -c 'echo /usr/local/bin/zsh >> /etc/shells'
	sudo chsh -s /usr/local/bin/zsh
	chmod 755 /usr/local/share/zsh
	chmod 755 /usr/local/share/zsh/site-functions
	mkdir -p ${HOME}/${DEV_PATH}

	! ${TESTMODE} && exec -l ${SHELL}
}

extra(){

	# change the hostname and computer name
	sudo scutil --set HostName ${HOSTNAME}
	sudo scutil --set LocalHostName ${LOCALHOSTNAME}
	sudo scutil --set ComputerName ${COMPUTERNAME}
	dscacheutil -flushcache

	# Overwrite /etc/hosts with the ad-blocking hosts file
	sudo cp /etc/hosts /etc/hosts.backup
	sudo cp ./bundle/Hostsfile /etc/hosts
}

python() {
	CWD=${EXEPATH}/bundle

	pyenv install 3.8.5
	pyenv install 2.7.8

	pyenv virtualenv 2.7.8 neovim2
	pip install neovim
	pyenv which python

	pyenv virtualenv 3.8.5 neovim3
	pip install neovim
	pyenv which python

	## ========== Pip ==========
	pip3 install --upgrade pip
	pip3 install -r ${CWD}/Pipfile
}

usage() {

	bot "This is my personal dotfiles\n"
	running "Options for install.sh\n"

	action " init:     Core initialization"
	action " bundle:   Package installation"
	action " system:   MacOS system setting"
	action " dotfiles: Dotfiles installation"
	action " all:      All installations (except init)"

}

## ----------------------------------------
##	Main
## ----------------------------------------
argv=$@

if [[ ${argv[@]} =~ "--help" || $# -eq 0 ]]; then
	usage
	exit 0
fi

if [[ ${argv[@]} =~ "--force" ]]; then
	argv=( ${argv[@]/"--force"} )
else
	read -p "Your file will be overwritten. OK? (Y/n): " Ans;
	[[ ${argv[@]} =~ "--init" ]] && Ans='Y';
	[[ $Ans != 'Y' ]] && bot 'Canceled' && exit 0;
fi

if [[ ${argv[@]} =~ "--test" ]]; then
	TESTMODE=true
	argv=( ${argv[@]/"--test"} )
fi

if [[ ${argv[@]} =~ "--dotfiles" ]]; then
	read -r -p "Which profile wish you to install? " profile;
	PROFILE=profile
fi

sudo -v
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

for opt in ${argv[@]}; do
	case $opt in
		--init)     running "init"; initialize; print_result $? "Error"  ;;
		--bundle)   running "bundle"; install_bundle; print_result $? "Error";;
		--system)   running "system"; extra; configure_system; print_result $? "Error";;
		--python)   running "python"; python; print_result $? "Error";;
		--dotfiles) running "dotfiles"; install_dotfiles; print_result $?
			"Error";;
		--all)      running "all"; configure_system;
			install_bundle;
			extra;
			dotdrop_install_dotfiles; \
			print_result $? "Error";;
		*)          echo "invalid option $1"; ;;
	esac
done
