#!/bin/bash
# Backup packages list installed (from apt-get, aptitude...)
# by pax (coolwinding@gmail.com) 150121

# args
# $1: target path

if [[ -z $1 ]]; then
	echo ">>> Invalid arg! require: target path"
	exit
fi

#aptitude search '~i!~M'

P=$1
D=$(dirname $P)
F=$(basename $P)

(dpkg --get-selections && echo "") | grep -v deinstall | sed -e ':a;N;s/install\n//;ta' | sed -e 's/\t/ /g' | tr -s ' ' | tee $D/packages.list

cd $D && tar -czpvf $F.tar.gz packages.list && rm packages.list && cd -

