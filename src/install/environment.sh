#!/bin/bash
trap "exit" INT

echo ""
echo "##########################################################################################"
echo "##"
echo "## environment "
echo "##"
echo "##########################################################################################"


# hide journal audit messages
systemctl mask systemd-journald-audit.socket

# create admin user
useradd -m -g wheel admin
echo '%wheel ALL=(ALL) NOPASSWD:ALL' | EDITOR='tee -a'
echo "updating admin password..."
ADMIN_PASS=${ADMIN_PASS:-admin}
echo -e "${ADMIN_PASS}\n${ADMIN_PASS}" | passwd admin
sync

echo "##########################################################################################"
echo "##"
echo "## /environment"
echo "##"
echo "##########################################################################################"
echo ""