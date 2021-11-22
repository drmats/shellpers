# raspberry pi (rocky/fedora)

## hostname (system-wide)
```
hostnamectl set-hostname awesomemachine
```

## disable selinux (system-wide)
* fedora
    ```
    vi /etc/selinux/config # SELINUX=disabled
    grubby --update-kernel ALL --args selinux=0
    ```
* rocky
    ```
    vi /etc/selinux/config # SELINUX=disabled
    vi /boot/cmdline.txt # selinux=0
    ```

## bring back boot messages (fedora)
```
grubby --remove-args="quiet" --update-kernel ALL
```

## network
```
nmcli d wifi list
nmcli d wifi connect [SSID] password [PASS] ifname wlan0
```

## user
```
useradd -c User. -d /home/user -G wheel -m user
```

## lock accounts
```
passwd -l root
passwd -l rocky
vi /etc/ssh/sshd_config # PermitRootLogin no
```

## disable unneeded services
```
systemctl disable firewalld
systemctl stop firewalld
systemctl disable dnf-makecache.service
systemctl stop dnf-makecache.service
systemctl disable dnf-makecache.timer
systemctl stop dnf-makecache.timer
```

## dnf groups
see [fedora dnf groups](./fedora.fresh.md#dnf-groups)

## rpm fusion
see [fedora rpm fusion](./fedora.fresh.md#rpm-fusion)

## basic software
```
dnf install \
    alsa-utils \
    arj \
    bluez \
    bpytop \
    bzip2 \
    cloud-utils-growpart \
    colordiff \
    cpufetch \
    curl \
    e2fsprogs \
    elinks \
    ffmpeg \
    gcc \
    gcc-g++ \
    git \
    hdparm \
    htop \
    inxi \
    iptraf-ng \
    kernel-tools \
    mc \
    most \
    mpg123 \
    nc \
    neofetch \
    net-tools \
    NetworkManager-openvpn \
    NetworkManager-openvpn-gnome \
    nginx \
    nmap \
    nodejs \
    openvpn \
    p7zip \
    policycoreutils-python* \
    postgresql \
    postgresql-contrib \
    postgresql-server \
    psmisc \
    pv \
    python-devel \
    screen \
    setools-console \
    speedtest-cli \
    strace \
    tar \
    tig \
    tmux \
    transmission-cli \
    usbutils \
    virtualenv \
    wget \
    youtube-dl
```

## bluetooth
* [firmware](https://github.com/RPi-Distro/bluez-firmware)
* services
    ```
    systemctl start bluetooth
    systemctl enable bluetooth
    ```

## sound (fedora)
```
# dnf install wireplumber
$ systemctl --user enable --now wireplumber    # user
```

## config.txt
```
gpu_mem=32
dtparam=audio=on
hdmi_drive=2
hdmi_force_edid_audio=1
hdmi_force_hotplug=1
disable_overscan=1
dtoverlay=vc4-fkms-v3d    # or dtoverlay=vc4-kms-v3d
```

## X
* packages
    ```
    dnf install \
        mesa* \
        glx-utils \
        openbox \
        xclock \
        xterm \
        xorg-x11-fonts-Type1 \
        xorg-x11-drv* \
        xorg-x11-server-common \
        xorg-x11-server-utils \
        xorg-x11-server-Xorg \
        xorg-x11-xauth \
        xorg-x11-xinit \
        xorg-x11-xkb-utils
    ```
* permissions
    ```
    # echo "needs_root_rights = yes" > /etc/X11/Xwrapper.config
    ```
* session
    ```
    $ echo "exec openbox-session" > ~/.xinitrc    # user
    ```
