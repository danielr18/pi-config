#!/bin/bash

if [ "$EUID" -ne 0 ]
        then echo "Must be root"
        exit
fi

user=${SUDO_USER:-$(whoami)}
ip address delete 192.168.0.1/24 dev wlan0
ip link set dev wlan0 down
service dhcpcd stop
service hostapd stop
cp /home/$user/.digitalpignage/confs/dhcpcd.client.conf /etc/dhcpcd.conf
service dhcpcd start
ip link set dev wlan0 up

