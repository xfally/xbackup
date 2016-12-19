#!/bin/bash
# Configure system date and time
# by pax (coolwinding@gmail.com) 150122

# args
# $1: ntp server addr

if [[ -z $1 ]]; then
	echo ">>> Invalid arg! require: ntp server addr"
	exit
fi

ntpdate $1
dpkg-reconfigure tzdata -u
hwclock --localtime --hctosys
hwclock --systohc
#date; hwclock --show

