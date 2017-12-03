#!/bin/bash
#
# Works with Debian Stretch
#

if [ "$EUID" -ne 0 ]
	then echo "Must be root"
	exit
fi

apt-get remove --purge hostapd -yqq
apt-get update -yqq
apt-get upgrade -yqq
apt-get install hostapd dnsmasq -yqq

cat > /etc/dnsmasq.conf <<EOF
interface=wlan0
domain-needed
bogus-priv
dhcp-range=192.168.0.2,192.168.0.250,12h
EOF

cat > /etc/hostapd/hostapd.conf <<EOF
interface=wlan0
driver=nl80211
ssid=DigitalPignage
hw_mode=g
channel=7
wmm_enabled=0
macaddr_acl=0
auth_algs=1
ignore_broadcast_ssid=0
wpa=0
EOF

sed -i -- 's/#DAEMON_CONF=""/DAEMON_CONF="\/etc\/hostapd\/hostapd.conf"/g' /etc/default/hostapd

systemctl enable hostapd
systemctl enable dnsmasq

echo "All done! Please reboot"