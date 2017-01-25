#!/bin/bash
# Configure system language and locale
# by pax (coolwinding@gmail.com) 150122

# args
# $1: locale backup file

if [[ ! -f $1 ]]; then
	echo ">>> Invalid arg! require: locale backup file"
	exit
fi

mkdir -p old
mv /etc/default/locale ./old/locale.$(date +"%Y%m%d%H%M%S")
cp $1 /etc/default/locale
chmod 644 /etc/default/locale
#locale-gen en_US.UTF-8

