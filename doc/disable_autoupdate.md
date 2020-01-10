# disable automatic updates (fedora)

## disable packagekit (system-wide)
```
# systemctl disable packagekit
# systemctl mask packagekit
# systemctl disable packagekit-offline-update
# systemctl mask packagekit-offline-update
```

## disable dnf-makecache (system-wide)
```
# systemctl disable dnf-makecache.service
# systemctl disable dnf-makecache.timer
```

## tell gnome not to perform automatic updates (user)
```
$ gsettings set org.gnome.software allow-updates false
$ gsettings set org.gnome.software download-updates false
$ gsettings set org.gnome.software download-updates-notify false
```
