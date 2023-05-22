# Realtek WiFi Driver & Firmware


## Realtek rtw89
Requirements:

```
$ sudo dnf install kernel-headers kernel-devel
$ sudo dnf group install "C Development Tools and Libraries"
```


Driver Installation
```
$ git clone https://github.com/lwfinger/rtw89.git
$ cd rtw89
$ sudo make install
$ reboot
```

### (Optional)
Remove the folder with driver building blocks:
```
$ rm -v -R --interactive=never ~/rtw89
```

### RTL8852BE Firmware
For RTL8852BE firmware, download the file from [here](https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git/plain/rtw89/rtw8852b_fw.bin) and copy it to `/lib/firmware/rew89`.


```
$ cd /lib/firmware/rtw89
$ sudo wget https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git/plain/rtw89/rtw8852b_fw.bin
$ reboot
```
