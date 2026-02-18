{...}: {
  "port-forward-enable" = "echo 'rdr pass inet proto tcp from any to any port 2376 -> 127.0.0.1 port 2376' | sudo pfctl -ef -";
  "port-forward-disable" = "sudo pfctl -F all -f /etc/pf.conf";
  "port-forward-list" = "sudo pfctl -s nat";

  # Show active network interfaces
  ifactive = "ifconfig | pcregrep -M -o '^[^\t:]+:([^\n]|\n\t)*status: active'";

  # IP addresses
  iplocal = "ipconfig getifaddr en0";
  ips = "ifconfig -a | grep -o 'inet6\\? \\(addr:\\)\\?\\s\\?\\(\\(\\([0-9]\\+\\.\\)\\{3\\}[0-9]\\+\\)\\|[a-fA-F0-9:]\\+\\)' | awk '{ sub(/inet6? (addr:)? ?/, \\\"\\\"); print }'";

  # Show network connections
  connections = "lsof -l -i +L -R -V";
  established = "lsof -l -i +L -R -V | grep ESTABLISHED";
  internalip = "ifconfig en0 | egrep -o '([0-9]+\\.[0-9]+\\.[0-9]+\\.[0-9]+)'";

  # Flush the DNS on Mac
  dnsflush = "dscacheutil -flushcache";

  # Disable Spotlight
  spotoff = "sudo mdutil -a -i off";

  # Enable Spotlight
  spoton = "sudo mdutil -a -i on";
}
