#!/bin/bash
#
# Works with Debian Stretch
#

if [ "$EUID" -ne 0 ]
	then echo "Must be root"
	exit
fi

curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -
sudo apt install nodejs -yqq
