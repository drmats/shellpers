# QEMU


## mount *.qcow2 disks in host

```
# modprobe nbd max_part=8
# qemu-nbd --connect=/dev/nbd0 /path/to/file.qcow
# cfdisk /dev/nbd0
# mount /dev/nbd0p1 /mnt/mountpoint
```

```
# umount /mnt/mountpoint
# qemu-nbd --disconnect /dev/nbd0
```


## run raspberry pi image

### swap file

```
$ qemu-img create -f raw ./swap.img 4G
$ qemu-img convert -f raw -O qcow2 ./swap.img ./swap.qcow
$ rm ./swap.img
```

### emulate

```
# qemu-system-aarch64 \
    -M raspi3b \
    -cpu cortex-a53 \
    -smp 4 \
    -accel tcg,thread=multi \
    -m 1G \
    -kernel ./kernel-6.1.8-v8.1.el8.altarch.1.img \
    -dtb ./bcm2710-rpi-3-b-plus.dtb \
    -nographic \
    -sd ./rocky.qcow \
    -append "rw earlyprintk loglevel=8 console=ttyAMA0,115200 dwc_otg.lpm_enable=0 root=/dev/mmcblk0p3 rootdelay=1 selinux=0" \
    -device usb-net,netdev=net0 \
    -netdev user,id=net0,hostfwd=tcp::2222-:22 \
    -drive if=none,id=usbstick,format=qcow2,file=./swap.qcow \
    -device usb-storage,drive=usbstick
```

```
$ ssh -o PreferredAuthentications=password -p 2222 rocky@127.0.0.1
```
