#!/bin/bash

P=`dirname $(readlink -f $0)`

mkdir -p ~/bin
ln -fs $P/xbackup.sh ~/bin/xbackup.sh
ln -fs $P/xrestore.sh ~/bin/xrestore.sh

