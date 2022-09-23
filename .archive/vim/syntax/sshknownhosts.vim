setlocal iskeyword=@,48-57,_,192-255,- 
" syntax group that matches REGEX
syntax match sshknowhostspubkey "AAAA[0-9a-zA-Z+/]\+[=]\{0,2}"
highlight def link sshknowhostspubkey Special

syn keyword sshalg ssh-rsa
hi def link sshalg Identifier

syn match sshknownhostsip "\<\(\d\{1,3}\.\)\{3}\d\{1,3}\>"
hi def link sshknownhostsip Constant
