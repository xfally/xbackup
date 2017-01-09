#!/bin/bash
# Backup all needed files
# by pax (coolwinding@gmail.com) 150121

# args
# $1: target path
# $2: a list file

if [[ $# -lt 2 ]]; then
	echo ">>> Invalid arg! require: ..."
	echo ">>> arg 1: target path"
	echo ">>> arg 2: file list"
	exit
fi

tar -czpPvf $1.tar.gz -T $2

