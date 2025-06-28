#!/bin/bash

for iface in $(vboxmanage list hostonlyifs | grep '^Name:' | awk '{print $2}'); do
    echo "Removing host-only interface: $iface"
    vboxmanage hostonlyif remove "$iface"
done