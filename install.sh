#!/bin/bash

P=`dirname $(readlink -f $0)`

mkdir -p ~/bin
ln -fs $P/xbackup ~/bin/xbackup
ln -fs $P/xrestore ~/bin/xrestore
