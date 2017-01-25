# xbackup

This script toolbox is created to backup/restore files/config on Debian/Ubuntu OS.

The toolbox contains

- backup*: Backup system/user packages, dconf, files, bins...
- restore*, install*, configure*: Restore system/user packages, dconf, files, bins...
- other utils

The backup_files.list format

```
/etc/apt/sources.list

/home/pax/abc 123
/home/pax/.bashrc
/home/pax/.vimrc
/home/pax/.ssh

/home/pax/bin
```

> blank space in path is allowed.

Unhappily, when restore, the script will not choose the newest backup file,
but you should copy the wanted backup file from backup dir to data dir.
Refer to restore* script for more detail.

License: [MIT](https://github.com/xfally/xbackup/blob/master/LICENSE)
