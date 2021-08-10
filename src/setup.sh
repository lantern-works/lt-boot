#!/bin/bash

trap "exit" INT

echo "---------------------------------------------"
echo " Starting configuration..."
echo "---------------------------------------------"

ls -al /
if [[ -f /boot/config.txt ]]; then
    /tmp/install/hardware.sh # hardware and networking
    /tmp/install/software.sh # software pre-requisites
    echo "---------------------------------------------"
    echo " Success with configuration"
    echo "---------------------------------------------"
else
    echo "---------------------------------------------"
    echo " WARNING: expected boot config"
    echo "---------------------------------------------"
    exit
fi