# RPM

## archive
```
https://archives.fedoraproject.org/pub/archive/fedora/linux/releases/
```

## extract contents
```
dnf install rpm-build cpio

rpm2cpio PACKAGE.rpm | cpio -idm
```
