#!/bin/bash

########################################################################
# The script-toolbox is created to backup and restore your Debian/Ubuntu OS (64bits).
# This is the **backup** script which invokes needed child scripts to complete the backup work.
# by pax (coolwinding@gmail.com) 150122
########################################################################

function notice() {
	cat <<EOF
########################################################################
Notice:
  1. Modify me at first, to make your OS happy!
  2. Do NOT need root or sudo, and anyone can backup his files.
  3. Backup files will be saved under "${BACKUP_DIR}".
########################################################################
EOF
}

function usage() {
	cat <<EOF
Usage: xbackup.sh [OPTIONS]...
  OPTIONS:
  -d BACKUP_DIR            absolute backup dir (default ${P}/backup)
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

while getopts "d:" OPTION
do
	case $OPTION in
		d ) BACKUP_DIR="$OPTARG";;
		* ) usage
	esac
done

if [ -z "$BACKUP_DIR" ]; then
	BACKUP_DIR="${P}/backup"
	#BACKUP_DIR="${HOME}/backup"  # Use `${HOME}` instead of `~`!
fi

LOG_DIR="${P}/log"

mkdir -p ${BACKUP_DIR}
mkdir -p ${LOG_DIR}

echo ">>> backup path: ${BACKUP_DIR}"
echo ">>> log path: ${LOG_DIR}"

. ./toolbox/utils.sh

function main() {
	notice
	echo ">>>>>> Begin, please read and configure this script at first, or the OS may be broken!"

	echo "### step 1. backup system config"
	give_me_a_chance || exit
	list="/etc/fstab \
		/etc/default/locale \
		/etc/apt/sources.list"
	#echo "list: $list"
	./toolbox/backup_files.sh ${BACKUP_DIR}/${H}_system_config_${T} "$list"
	echo "### step 1. over..."

	echo "### step 2. backup user config"
	give_me_a_chance || exit
	list="${HOME}/.bashrc \
		${HOME}/.config/chromium/Default/Bookmarks \
		${HOME}/.editorconfig \
		${HOME}/.gitconfig \
		${HOME}/.gitignore \
		${HOME}/.npmrc \
		${HOME}/.profile \
		${HOME}/.vimrc \
		${HOME}/.ssh"
	#echo "list: $list"
	./toolbox/backup_files.sh ${BACKUP_DIR}/${H}_home_config_${T} "$list"
	echo "### step 2. over..."

	echo "### step 3. backup bin, such as ~/bin..."
	give_me_a_chance || exit
	list="${HOME}/bin"
	#echo "list: $list"
	./toolbox/backup_files.sh ${BACKUP_DIR}/${H}_home_bin_${T} "$list"
	echo "### step 3. over..."

	echo "### step 4. backup install packages list..."
	give_me_a_chance || exit
	./toolbox/backup_packages_list.sh ${BACKUP_DIR}/${H}_packages_list_${T}
	echo "### step 4. over..."

	echo ">>>>>> All done!"
}

main 2>&1 | tee ${LOG_DIR}/backup_${H}_${T}.log

