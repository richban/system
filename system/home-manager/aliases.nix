{
    ".."="cd ..";
    "..."="cd ../..";
    "...."="cd ../../..";

    tree="tree -A";
    treed="tree -d";
    tree1="tree -d -L 1";
    tree2="tree -d -L 2";

    l="exa -l --icons --classify --header --long --git --group-directories-first --sort=ext";
    la="exa -a --header --long --git --color=always --group-directories-first --sort=ext";
    ll="exa -lh --links --blocks --accessed --created --header --long --git --color=always --modified --group-directories-first";
    ld="exa -D --color=always --group-directories-first --sort=ext";
    lt="exa -aT --color=always --group-directories-first";
    # tree="exa --tree";
    # tree1="exa --tree --level=1 --long";
    # tree2="exa --tree --level=2 --long";

    # List declared aliases, functions, paths
    aliases="| sed 's/=.*//'";
    functions="declare -f | grep '^[a-z].* ()' | sed 's/{$//'";
    # paths="echo -e ${PATH//:/\\n}";

    # firewall management
    port-forward-enable="echo 'rdr pass inet proto tcp from any to any port 2376 -> 127.0.0.1 port 2376' | sudo pfctl -ef -";
    port-forward-disable="sudo pfctl -F all -f /etc/pf.conf";
    port-forward-list="sudo pfctl -s nat";

    # Show active network interfaces
    ifactive="ifconfig | pcregrep -M -o '^[^\t:]+:([^\n]|\n\t)*status: active'";

    # Reload the shell (i.e. invoke as a login shell)
    reload="exec $SHELL -l";

    # IP addresses
    ip="dig +short myip.opendns.com @resolver1.opendns.com";
    iplocal="ipconfig getifaddr en0";
    ips="ifconfig -a | grep -o 'inet6\? \(addr:\)\?\s\?\(\(\([0-9]\+\.\)\{3\}[0-9]\+\)\|[a-fA-F0-9:]\+\)' | awk '{ sub(/inet6? (addr:)? ?/, \"\"); print }'";

    # Show network connections
    connections="lsof -l -i +L -R -V";
    established="lsof -l -i +L -R -V | grep ESTABLISHED";
    externalip="curl -s http://checkip.dyndns.org/ | sed 's/[a-zA-Z<>/ :]//g'";
    internalip="ifconfig en0 | egrep -o '([0-9]+\.[0-9]+\.[0-9]+\.[0-9]+)'";

    # recursive dos2unix in current directory
    dos2lf="dos2unix 'find ./ -type f'";

    # Flush the DNS on Mac
    dnsflush="dscacheutil -flushcache";

    # Disable Spotlight
    spotoff="sudo mdutil -a -i off";

    # Enable Spotlight
    spoton="sudo mdutil -a -i on";

    mux="tmuxinator";
}