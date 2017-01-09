# xbackup

This script toolbox is created to backup/restore files/config on Debian/Ubuntu OS.

The toolbox contains

- backup*: Backup system/user files, bins... (for daily)
- restore*, install*, configure*: Restore system/user files, bins...
- other utils

The backup_*.list format

```
/etc/apt/sources.list
/home/pax/abc 123
/home/pax/bin
/home/pax/.bashrc
/home/pax/.vimrc
/home/pax/.ssh
```

> blank space in path is supported

Unhappily, when restore, the script will not choose the newest backup file,
but you should copy the wanted backup file from backup dir to data dir.
Refer to restore* script for more detail.

License: [MIT](https://github.com/xfally/xbackup/blob/master/LICENSE)
