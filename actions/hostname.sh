sudo scutil --set HostName ${HOSTNAME}
sudo scutil --set LocalHostName ${LOCALHOSTNAME}
sudo scutil --set ComputerName ${COMPUTERNAME}
dscacheutil -flushcache
sudo cp /etc/hosts /etc/hosts.backup
sudo cp ./bundle/Hostsfile /etc/hosts
