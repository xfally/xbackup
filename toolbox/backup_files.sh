#!/bin/bash
# Backup all needed files
# by pax (coolwinding@gmail.com) 150121

# args
# $1: target path
# $2: file list

if [[ $# < 2 ]]; then
	echo ">>> Invalid arg! require: ..."
	echo ">>> arg 1: target path"
	echo ">>> arg 2: file list"
	exit
fi

P=$1
shift
tar -czpPvf $P.tar.gz $*

