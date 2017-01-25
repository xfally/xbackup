#!/bin/bash
# Configure dconf
# by pax (coolwinding@gmail.com) 170125

# args
# $1: dconf backup file

if [[ ! -f $1 ]]; then
	echo ">>> Invalid arg! require: dconf backup file"
	exit
fi

mkdir -p old
dconf dump / > ./old/dconf.$(date +"%Y%m%d%H%M%S")
cat $1 | dconf load /

