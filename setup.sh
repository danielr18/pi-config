#!/bin/bash
#
# Works with Debian Stretch
#

if [ "$EUID" -ne 0 ]
	then echo "Must be root"
	exit
fi

user=${SUDO_USER:-$(whoami)}
app_folder=/home/$user/.digitalpignage

mkdir -p $app_folder/confs

cat > $app_folder/resources.txt <<EOF
https://raw.githubusercontent.com/danielr18/pi-config/master/confs/dhcpcd.client.conf
https://raw.githubusercontent.com/danielr18/pi-config/master/confs/dhcpcd.ap.conf
https://raw.githubusercontent.com/danielr18/pi-config/master/start_wifi_ap.sh
https://raw.githubusercontent.com/danielr18/pi-config/master/start_wifi_client.sh
EOF

wget -q -N -P $app_folder -i $app_folder/resources.txt
mv $app_folder/dhcpcd.ap.conf $app_folder/confs
mv $app_folder/dhcpcd.client.conf $app_folder/confs
rm $app_folder/resources.txt

echo "All done! Please reboot"
