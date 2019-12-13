# hard disk encryption with [cryptsetup](https://gitlab.com/cryptsetup/cryptsetup)

## initialize encrypted partition
```
cryptsetup -v luksFormat /dev/sda --type luks2 --pbkdf argon2id --label red
```

## open encrypted partition (create mapping)
```
cryptsetup open /dev/sda red --type luks2
```

## check status
```
cryptsetup -v status red
```

## backup/restore headers
```
cryptsetup -v luksHeaderBackup /dev/sda --header-backup-file ./red.luks2.header
cryptsetup -v luksHeaderRestore /dev/sda --header-backup-file ./red.luks2.header
```

## dump header information (with master key)
```
cryptsetup luksDump /dev/sda
cryptsetup luksDump --dump-master-key /dev/sda
```

## "format" whole drive (fill with random data)
```
dd if=/dev/zero of=/dev/mapper/red bs=128MB status=progress
```

## create ext4 filesystem and label it
```
mkfs.ext4 /dev/mapper/red
e2label /dev/mapper/red red
```

## disable reserving blocks for privileged processes
```
tune2fs -m 0 /dev/mapper/red
```

## mount/umount
```
mount /dev/mapper/red /mnt/red
umount /mnt/red
```

## close encrypted partition
```
cryptsetup close red
```

## power off
```
udisksctl power-off -b /dev/sda
```

## show info about block devices
```
lsblk
blkid
```

## show currently used encryption keys
```
dmsetup table --showkeys
```

## convert hex representation into binary
```
xxd -r -p existinglukskey.txt existinglukskey.bin
```

## add new passphrase
```
cryptsetup luksAddKey /dev/sda --master-key-file <(cat ./existinglukskey.bin)
```
