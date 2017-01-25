#!/bin/bash
# Install packages
# Tip: use backup_packages.sh to generate the packages list file
# by pax (coolwinding@gmail.com) 150122

# args
# $1: packages list backup file

if [[ ! -f $1 ]]; then
	echo ">>> Invalid arg! require: packages list backup file"
	exit
fi

apt-get -y -s install `cat $1`
#apt-get -y install `cat $1`
echo ">>> if some packages can not be found, please check your apt sources, or maybe you should install them by hand"

