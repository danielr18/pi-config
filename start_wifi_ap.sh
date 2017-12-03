#!/bin/bash

if [ "$EUID" -ne 0 ]
	then echo "Must be root"
	exit
fi

ip link set dev wlan0 down
cp /home/pi/Documents/dhcpcd.ap.conf /etc/dhcpcd.conf
service dhcpcd restart
service dnsmasq restart
service hostapd restart
ip link set dev wlan0 up

