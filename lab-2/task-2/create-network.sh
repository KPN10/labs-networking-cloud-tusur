#!/bin/bash

vboxmanage hostonlyif create
LIST_OUTPUT=$(vboxmanage list hostonlyifs)
NEW_IFACE=$(
    echo "$LIST_OUTPUT" | grep -B 1 "^Name:" | awk '{print $2}' | tail -n1
)

if [ -z "$NEW_IFACE" ]; then
    echo ""
fi

echo "New network: $NEW_IFACE"
vboxmanage dhcpserver remove --ifname "$NEW_IFACE"

#echo \"* 0.0.0.0/0 ::/0\" | sudo tee /etc/vbox/networks.conf
#sudo vboxmanage hostonlyif ipconfig "$NEW_IFACE" \
#    --ip 192.168.50.1 --netmask 255.255.255.0

sudo ip addr add 192.168.50.1/24 dev "$NEW_IFACE"
sudo ip link set "$NEW_IFACE" up
