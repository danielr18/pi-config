#!/bin/bash

if [ "$EUID" -ne 0 ]
	then echo "Must be root"
	exit
fi

user=${SUDO_USER:-$(whoami)}
ip link set dev wlan0 down
cp /home/$user/.digitalpignage/confs/dhcpcd.client.conf /etc/dhcpcd.conf
service dhcpcd restart
service dnsmasq restart
service hostapd restart
ip link set dev wlan0 up
