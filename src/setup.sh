#!/bin/bash

trap "exit" INT

echo "---------------------------------------------"
echo " Starting configuration..."
echo "---------------------------------------------"

ls -al /
if [[ -f /boot/config.txt ]]; then
    /tmp/install/hardware.sh # hardware core setuo
    /tmp/install/network.sh # networking core setup
    /tmp/install/environment.sh # environment core setup
    echo "---------------------------------------------"
    echo " Success with configuration"
    echo "---------------------------------------------"
else
    echo "---------------------------------------------"
    echo " WARNING: expected boot config"
    echo "---------------------------------------------"
    exit
fi