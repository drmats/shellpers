# rsync

## local to remote sync with deletion over ssh
```
$ cd [LOCAL_DIR_TO_SYNC]
$ rsync -avhz ./ [USER]@192.168.1.32:~/[REMOTE_DIR_TO_SYNC]/ --delete
```
