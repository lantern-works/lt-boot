#!/bin/bash

echo ""
echo "##########################################################################################"
echo "##"
echo "## network"
echo "##"
echo "##########################################################################################"
if [[ -f /boot/config.txt ]]; then
    echo "configuring pi network..."

    # update hostname
    echo "lt" > /etc/hostname
    
    # zero-conf / bonjour / avahi to make the pi easier to find on the network
    sed -i '/^hosts: /s/files dns/files mdns dns/' /etc/nsswitch.conf
    ln -sf /usr/lib/systemd/system/avahi-daemon.service /etc/systemd/system/multi-user.target.wants/avahi-daemon.service

    # enable wireless, actual connection details will be configured by the user
    ln -sf /usr/lib/systemd/system/netctl-auto@.service /etc/systemd/system/multi-user.target.wants/netctl-auto@wlan0.service

    # setup hosts file
    echo '127.0.0.1 lt localhost' >> /etc/hosts
    echo '::1 lt localhost' >> /etc/hosts

    sync

else
    echo "skipping network setup within docker container..."    
fi
sync
echo "##########################################################################################"
echo "##"
echo "## /hardware"
echo "##"
echo "##########################################################################################"
echo ""