# disable annoying "PME: Spurious native interrupt!"


## disable pcieport driver for the device

### service file

```
# nano /etc/systemd/system/pcie-unbind.service
```

```
[Unit]
Description=Unbind problematic PCIe port
After=systemd-udev-settle.service
Wants=systemd-udev-settle.service

[Service]
Type=oneshot
ExecStart=/bin/sh -c 'echo 0000:00:1c.0 > /sys/bus/pci/drivers/pcieport/unbind'
RemainAfterExit=yes

[Install]
WantedBy=multi-user.target
```


### (re-)load

```
# systemctl daemon-reload
# systemctl enable --now pcie-unbind.service
# systemctl start pcie-unbind.service
# systemctl status pcie-unbind.service
```


## disable just PME for the device

### prerequisities

```
# dnf install pciutils
```

### service file

```
# nano /etc/systemd/system/disable-pcie-pme.service
```

```
[Unit]
Description=Disable PME interrupt on PCIe port 00:1c.0
After=systemd-udev-settle.service
Wants=systemd-udev-settle.service

[Service]
Type=oneshot
ExecStart=/usr/sbin/setpci -s 00:1c.0 CAP_EXP+1c.w=0000:0008

[Install]
WantedBy=multi-user.target
```


### (re-)load

```
# systemctl daemon-reload
# systemctl enable --now disable-pcie-pme.service
# systemctl start disable-pcie-pme.service
# systemctl status disable-pcie-pme.service
```
