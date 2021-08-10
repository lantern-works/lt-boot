#!/bin/bash

echo ""
echo "##########################################################################################"
echo "##"
echo "## hardware"
echo "##"
echo "##########################################################################################"
if [[ -f /boot/config.txt ]]; then
    echo "configuring pi hardware..."
    
    sudo systemctl disable getty@.service
    sudo systemctl disable bluetooth.service
    
    sudo systemctl disable sound.target
    sudo systemctl disable bthelper.service
    sudo systemctl disable nfs-client.target
    sudo systemctl disable remote-fs.target

    # update hostname
    echo "lt" > /etc/hostname

    # set gpu mem
    grep 'gpu_mem=*' /boot/config.txt >/dev/null || echo 'gpu_mem=32' >> /boot/config.txt

    # disable audit logging
    grep 'audit=0' /boot/config.txt >/dev/null || echo 'audit=0' >> /boot/config.txt

    # enable HDMI hotplug
    grep 'hdmi_force_hotplug=1' /boot/config.txt >/dev/null || echo 'hdmi_force_hotplug=1' >> /boot/config.txt


    # disable Bluetooth
    grep 'dtoverlay=pi3-disable-bt' /boot/config.txt >/dev/null || echo 'dtoverlay=pi3-disable-bt' >> /boot/config.txt

    # for LoRa console communication
    grep 'dtparam=spi=on' /boot/config.txt >/dev/null || echo 'dtparam=spi=on' >> /boot/config.txt
    grep 'dtparam=i2c=on' /boot/config.txt >/dev/null || echo 'dtparam=i2c=on' >> /boot/config.txt
    grep 'enable_uart=1' /boot/config.txt >/dev/null || echo 'enable_uart=1' >> /boot/config.txt

    # prevent boot crashes
    grep 'dwc_otg.fiq_enable=0' /boot/config.txt >/dev/null || echo 'dwc_otg.fiq_enable=0' >> /boot/config.txt
    grep 'dwc_otg.fiq_fsm_enable=0' /boot/config.txt >/dev/null || echo 'dwc_otg.fiq_fsm_enable=0' >> /boot/config.txt

    cat /boot/config.txt


    echo "configuring networks and discovery for raspberry pi hardware..."

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
    echo "skipping hardware setup within docker container..."    
fi
sync
echo "##########################################################################################"
echo "##"
echo "## /hardware"
echo "##"
echo "##########################################################################################"
echo ""