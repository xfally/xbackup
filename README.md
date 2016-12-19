# xbackup

This script-toolbox is created to backup and restore Debian/Ubuntu OS.

The toolbox contains

- backup*: Backup system/user files, bins... (for daily)
- restore*, install*, configure*: Restore system/user files, bins...
- other utils

Unhappily, when restore, this script will not choose the newest backup file,
but you should copy the wanted backup file from backup dir to data dir.
Refer to restore* script for more detail.

TODO: Move backup `list` from xbackup.sh to independent config file.

License: [MIT](https://github.com/xfally/xbackup/blob/master/LICENSE)
