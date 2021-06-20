#!/usr/bin/env sh

gstatus=`git status --porcelain`

if [ ${#gstatus} -ne 0 ]; then
	git pull
	git add --all
	git commit -q -m "Last Sync:  \n $gstatus"
	git push
fi
