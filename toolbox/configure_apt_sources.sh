#!/bin/bash
# Configure apt sources
# by pax (coolwinding@gmail.com) 150121

# args
# $1: sources.list backup file

if [[ ! -f $1 ]]; then
	echo ">>> Invalid arg! require: sources.list backup file"
	exit
fi

mkdir -p old
mv /etc/apt/sources.list ./old/sources.list.$(date +"%Y%m%d%H%M%S")
cp $1 /etc/apt/sources.list
chmod 644 /etc/apt/sources.list
# update or upgrade existed packages
apt-get update -y
apt-get upgrade -y

