#!/bin/bash

########################################################################
# The script-toolbox is created to backup and restore your Debian/Ubuntu OS (64bits).
# This is the **restore** script which invokes needed child scripts to complete the restore work.
# by pax (coolwinding@gmail.com) 150122
########################################################################

function notice() {
	cat <<EOF
########################################################################
Notice:
  1. Modify me at first, to make your OS happy!
  2. Use root or sudo to run me, or some step will fail!
  3. Restore from "${DATA_DIR}", and original os files will be saved under "${P}/old/".
########################################################################
EOF
}

function usage() {
	cat <<EOF
Usage: xrestore.sh [OPTIONS]...
  OPTIONS:
  -d DATA_DIR               absolute data dir (default ${P}/data)
EOF
	exit
}

# am i root?
who=$(whoami)
echo ">>> whoami: $who"
if [[ "$who" != "root" ]]; then
	echo ">>> Require root permission! Use sudo or su to obtain."
	exit
fi

H=${USER}@${HOSTNAME}
T=$(date +"%Y%m%d%H%M%S")

W=`pwd`
echo ">>> work path: ${W}"
P=`dirname $(readlink -f $0)`
echo ">>> project path: ${P}"

cd $P

while getopts "d:" OPTION
do
	case $OPTION in
		d ) DATA_DIR="$OPTARG";;
		* ) usage
	esac
done

if [ -z "$DATA_DIR" ]; then
	DATA_DIR="${P}/data"
fi

LOG_DIR="${P}/log"

mkdir -p ${LOG_DIR}

echo ">>> data path: ${DATA_DIR}"
echo ">>> log path: ${LOG_DIR}"

. ./toolbox/utils.sh

function main() {
	notice
	echo ">>>>>> Begin, please read and configure this script at first, or the OS may be broken!"

	echo "### step 1. configure network..."
	give_me_a_chance || exit
	echo "skip it now! you can invoke it by hand"
	#./toolbox/configure_network.sh 'static' 'eth0' '172.28.130.51' '255.255.255.0' '172.28.130.1' '172.31.1.1'
	echo "### step 1. over..."

	echo "### step 2. configure language and locale..."
	give_me_a_chance || exit
	./toolbox/configure_language.sh "${DATA_DIR}/locale"
	echo "### step 2. over..."

	echo "### step 3. configure date and time..."
	give_me_a_chance || exit
	echo "skip it now! you can invoke it by hand"
	#./toolbox/configure_datetime.sh '172.31.1.1'
	echo "### step 3. over..."

	echo "### step 4. configure apt source..."
	give_me_a_chance || exit
	./toolbox/configure_apt_sources.sh "${DATA_DIR}/sources.list"
	echo "### step 4. over..."

	echo "### step 5. install packages..."
	give_me_a_chance || exit
	./toolbox/install_packages.sh "${DATA_DIR}/packages.list"
	echo "### step 5. over..."

	echo "### step 6. do some other settings..."
	give_me_a_chance || exit
	echo "symlink sh to bash"
	ln -sf /bin/bash /bin/sh
	echo "### step 6. over..."

	echo ">>>>>> All done! maybe you should restart your OS now"
}

main 2>&1 | tee ${LOG_DIR}/restore_${H}_${T}.log

