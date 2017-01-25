#!/bin/bash
# Backup dconf
# by pax (coolwinding@gmail.com) 170125

# args
# $1: target path

if [[ -z $1 ]]; then
	echo ">>> Invalid arg! require: target path"
	exit
fi

P=$1
D=$(dirname $P)
F=$(basename $P)

dconf dump / > $D/dconf

if [[ $SILENT_MODE -eq 1 ]]; then
	V=;
else
	cat $D/dconf
	V=-v
fi

cd $D && tar $V -czpf $F.tar.gz dconf && rm dconf && cd - > /dev/null

