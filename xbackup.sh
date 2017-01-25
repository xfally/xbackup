#!/bin/bash

######################################################################
# The script toolbox is created to backup and restore your
# Debian/Ubuntu OS (64bits).
# This is the **backup** script which invokes needed child scripts to
# complete the backup work.
# by pax (coolwinding@gmail.com) 150122
######################################################################

function notice() {
	cat <<EOF
######################################################################
Notice:
  1. Modify me at first, to make your OS happy!
  2. Do NOT need root or sudo, and anyone can backup his files.
  3. Backup files will be saved under "${BACKUP_DIR}".
######################################################################
EOF
}

function usage() {
	cat <<EOF
Usage: xbackup.sh [OPTIONS]...
  OPTIONS:
  -b BACKUP_DIR            absolute backup dir (default ${P}/backup). All backup files/configs will be saved here.
  -d DATA_DIR              absolute data dir (default ${P}/data). Put your backup_files.list here.
  -s                       silent mode. Suppress verboss output in console.
EOF
	exit
}

H=${USER}@${HOSTNAME}
T=$(date +"%Y%m%d%H%M%S")

W=`pwd`
echo ">>> work path: ${W}"
P=`dirname $(readlink -f $0)`
echo ">>> project path: ${P}"

cd $P

export SILENT_MODE=0

while getopts "b:d:s" OPTION
do
	case $OPTION in
		b ) BACKUP_DIR="$OPTARG";;
		d ) DATA_DIR="$OPTARG";;
		s ) export SILENT_MODE=1;;
		* ) usage
	esac
done

if [ -z "$BACKUP_DIR" ]; then
	BACKUP_DIR="${P}/backup"
	#BACKUP_DIR="${HOME}/backup"  # Use `${HOME}` instead of `~`!
fi

if [ -z "$DATA_DIR" ]; then
	DATA_DIR="${P}/data"
fi

LOG_DIR="${P}/log"

mkdir -p ${BACKUP_DIR}
mkdir -p ${LOG_DIR}

echo ">>> backup path: ${BACKUP_DIR}"
echo ">>> data path: ${DATA_DIR}"

. ./toolbox/utils.sh

function main() {
	notice
	echo ">>>>>> Begin, please read and configure this script at first, or the OS may be broken!"

	echo "### step 1. backup installed packages..."
	give_me_a_chance || exit
	./toolbox/backup_packages.sh ${BACKUP_DIR}/${H}_packages_${T}
	echo "### step 1. over..."

	echo "### step 2. backup dconf (only items different to original are saved)..."
	give_me_a_chance || exit
	./toolbox/backup_dconf.sh ${BACKUP_DIR}/${H}_dconf_${T}
	echo "### step 2. over..."

	echo "### step 3. backup files..."
	give_me_a_chance || exit
	./toolbox/backup_files.sh ${BACKUP_DIR}/${H}_files_${T} ${DATA_DIR}/backup_files.list
	echo "### step 3. over..."

	echo ">>>>>> All done!"
}

main 2>&1 | tee ${LOG_DIR}/backup_${H}_${T}.log

echo ">>> log path: ${LOG_DIR}"
