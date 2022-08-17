#! /usr/bin/env bash

printf 'Enter hostname: '
read HOSTNAME
sudo scutil --set HostName ${HOSTNAME}

printf 'Enter local local hostname: '
read LOCALHOSTNAME
sudo scutil --set LocalHostName ${LOCALHOSTNAME}

printf 'Enter computer name: '
read COMPUTERNAME
sudo scutil --set ComputerName ${COMPUTERNAME}

dscacheutil -flushcache
sudo cp /etc/hosts /etc/hosts.backup
sudo cp ./bundle/Hostsfile /etc/hosts
