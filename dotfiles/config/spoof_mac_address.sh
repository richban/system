#!/bin/sh

# download mac-address-prefixes.txt
curl -o /usr/local/sbin/mac-address-prefixes.txt https://sunknudsen.com/static/media/privacy-guides/how-to-spoof-your-mac-address-and-hostname-automatically-at-boot-on-macos/mac-address-prefixes.txt

# copy to the terminal
cat << "EOF" > /usr/local/sbin/spoof.sh
#! /bin/sh

set -e

export LC_CTYPE=C

basedir=$(dirname "$0")

# Spoof MAC address of en0 interface
mac_address_prefix=`sed "$(jot -r 1 1 768)q;d" $basedir/mac-address-prefixes.txt | sed -e 's/[^A-F0-9:]//g'`
mac_address_suffix=`openssl rand -hex 3 | sed 's/\(..\)/\1:/g; s/.$//'`
mac_address=`echo "$mac_address_prefix:$mac_address_suffix" | awk '{print toupper($0)}'`
sudo ifconfig en0 ether "$mac_address"
printf "%s\n" "Spoofed MAC address of en0 interface to $mac_address"
EOF

# make spoof.sh executable
chmod +x /usr/local/sbin/spoof.sh

# create a local.spoof.plist launch deamon
cat << "EOF" | sudo tee /Library/LaunchDaemons/local.spoof.plist
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
  <dict>
    <key>Label</key>
    <string>spoof</string>

    <key>ProgramArguments</key>
    <array>
        <string>/usr/local/sbin/spoof.sh</string>
    </array>

    <key>RunAtLoad</key>
    <true/>
  </dict>
</plist>
EOF
