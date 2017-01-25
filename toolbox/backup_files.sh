#!/bin/bash
# Backup all needed files
# by pax (coolwinding@gmail.com) 150121

# args
# $1: target path
# $2: backup files list

if [[ $# -lt 2 ]]; then
	echo ">>> Invalid arg! require: ..."
	echo ">>> arg 1: target path"
	echo ">>> arg 2: backup files list"
	exit
fi

if [[ $SILENT_MODE -eq 1 ]]; then
	V=;
else
	V=-v
fi

tar $V -czpPf $1.tar.gz -T $2

