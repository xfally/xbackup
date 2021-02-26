# xbackup

**xbackup**, **xrestore** and its child scripts are created to backup/restore files/config on Debian/Ubuntu OS.

Run `xbackup -h` and `xrestore -h` for usage.

The toolbox contains

- backup*: Backup system/user packages, dconf, files, bins...
- restore, install, configure*: Restore system/user packages, dconf, files, bins...
- other utils

The *backup_files.list* likes below

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

**xrsync** is created to synchronize files from one place to another.

Run `xrsync -h` for usage.

If xrsync uses arg `-f`, you can specify one list file. The format likes *backup_files.list* above.

License: [MIT](https://github.com/xfally/xbackup/blob/master/LICENSE)
