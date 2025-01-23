# Home Assistant


## prerequisities (rocky8 on rpi3)

```
# dnf install \
    atlas atlas-devel \
    autoconf \
    automake \
    bluez \
    bzip2 bzip2-devel bzip2-libs \
    ffmpeg ffmpeg-devel \
    gcc gcc-c++ \
    gdbm gdbm-libs gdbm-devel \
    kernel-devel \
    libffi libffi-devel \
    libjpeg libjpeg-devel \
    libjpeg-turbo libjpeg-turbo-devel \
    libuuid libuuid-devel \
    ncurses ncurses-base ncurses-term \
    ncurses-libs ncurses-compat-libs ncurses-devel \
    openjpeg2 openjpeg2-devel openjpeg2-tools \
    openssl openssl-devel \
    python3.12 python3.12-devel \
    readline readline-devel \
    tk tk-devel \
    tzdata \
    xz xz-devel \
    zlib zlib-devel
```


## supplementary groups

```
# usermod -a -G dialout tty [user]
```


## installation (Home Assistant Core)

```
$ mkdir homeassistant
$ cd homeassistant
$ python3.12 -m venv .
$ . bin/activate

$ python -m pip install wheel
$ pip install --upgrade pip

$ pip install homeassistant
$ pip install -U git+https://github.com/lilohuang/PyTurboJPEG.git
```


## open firewall port

```
$ firewall-cmd --zone=public --add-port=8123/tcp --permanent
$ firewall-cmd --reload
$ firewall-cmd --zone=public --list-all
```


## run it

```
$ hass
```
