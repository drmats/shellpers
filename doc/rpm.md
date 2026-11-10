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

## download rpm from other release
```
dnf --releasever=36 download PACKAGE
```

## install downloaded rpm without dependencies
```
rpm -Uvh --nodeps FULL_PACKAGE_NAME.rpm
```
