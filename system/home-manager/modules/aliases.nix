{...}: {
  ".." = "cd ..";
  "..." = "cd ../..";
  "...." = "cd ../../..";

  tree = "tree -A";
  treed = "tree -d";
  tree1 = "tree -d -L 1";
  tree2 = "tree -d -L 2";

  l = "exa -l --icons --classify --header --long --git --group-directories-first --sort=ext";
  la = "exa -a --header --long --git --color=always --group-directories-first --sort=ext";
  ll = "exa -lh --links --blocks --accessed --created --header --long --git --color=always --modified --group-directories-first";
  ld = "exa -D --color=always --group-directories-first --sort=ext";
  lt = "exa -aT --color=always --group-directories-first";
  # tree="exa --tree";
  # tree1="exa --tree --level=1 --long";
  # tree2="exa --tree --level=2 --long";

  # List declared aliases, functions, paths
  aliases = "| sed 's/=.*//'";
  functions = "declare -f | grep '^[a-z].* ()' | sed 's/{$//'";
  # paths="echo -e ${PATH//:/\\n}";

  # Reload the shell (i.e. invoke as a login shell)
  reload = "exec $SHELL -l";

  # IP addresses
  ip = "dig +short myip.opendns.com @resolver1.opendns.com";
  externalip = "curl -s http://checkip.dyndns.org/ | sed 's/[a-zA-Z<>/ :]//g'";

  # recursive dos2unix in current directory
  dos2lf = "dos2unix 'find ./ -type f'";

  mux = "tmuxinator";
  fabric-list = "list_fabric_patterns";
  fabric-refresh = "create_fabric_aliases";
}
