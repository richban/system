#!/usr/bin/env sh

gstatus=`git status --porcelain`

if [ ${#gstatus} -ne 0 ]; then
	git pull
	git add --all
	git commit -q -m "Last Sync: $gstatus"
	git push
	terminal-notifier -title '🚀' -message 'Dotfiles Updated'
fi
