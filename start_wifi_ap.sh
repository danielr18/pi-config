#!/bin/bash

if [ "$EUID" -ne 0 ]
	then echo "Must be root"
	exit
fi

user=${SUDO_USER:-$(whoami)}

ip link set dev wlan0 down
ip address add 192.168.0.1/24 dev wlan0
cp /home/$user/.digitalpignage/confs/dhcpcd.ap.conf /etc/dhcpcd.conf
service dhcpcd restart
service dnsmasq restart
service hostapd restart
ip link set dev wlan0 up

