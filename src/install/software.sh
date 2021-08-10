#!/bin/bash
trap "exit" INT

echo ""
echo "##########################################################################################"
echo "##"
echo "## software "
echo "##"
echo "##########################################################################################"


# hide journal audit messages
systemctl mask systemd-journald-audit.socket

# create admin user
useradd -m -g wheel admin
echo '%wheel ALL=(ALL) NOPASSWD:ALL' | EDITOR='tee -a'

sync

echo "##########################################################################################"
echo "##"
echo "## /software"
echo "##"
echo "##########################################################################################"
echo ""