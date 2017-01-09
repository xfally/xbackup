#!/bin/bash
# Configure network
# by pax (coolwinding@gmail.com) 150122

# args
# arg example 1: 'static', card, ip, netmask, default gateway, nameserver
# arg example 2: 'dhcp', card

if [[ $# -ne 6 && $# -ne 2 ]]; then
	echo ">>> Invalid arg! require: ..."
	echo ">>> arg example 1: 'static', card, ip, netmask, default gateway, nameserver"
	echo ">>> arg example 2: 'dhcp', card"
	exit
fi

ifconfig $2 down
mkdir -p old
mv /etc/network/interfaces ./old/interfaces.$(date +"%Y%m%d%H%M%S")
if [[ $1 == 'static' ]]; then
	#ifconfig $2 $3 netmask $4
	##ifconfig $2 hw ether XX:XX:XX:XX:XX:XX
	#route add default gw $5
	echo "auto $2" >> /etc/network/interfaces
	echo "iface $2 inet static" >> /etc/network/interfaces
	echo "address $3" >> /etc/network/interfaces
	echo "netmask $4" >> /etc/network/interfaces
	echo "gateway $5" >> /etc/network/interfaces
	mv /etc/resolvconf/resolv.conf.d/base ./old/base.$(date +"%Y%m%d%H%M%S")
	echo "$6" >> /etc/resolvconf/resolv.conf.d/base
else
	#dhclient $2
	echo "auto $2" >> /etc/network/interfaces
	echo "iface $2 inet dhcp" >> /etc/network/interfaces
fi
/etc/init.d/networking restart
ifconfig $2 up
