# fresh install steps (fedora desktop) - 34

## for multi-boot machine (system-wide)
Set RTC to local instead of UTC (windows compatibility).
```
timedatectl set-local-rtc 1 --adjust-system-clock
```

## hostname (system-wide)
```
hostnamectl set-hostname awesomemachine
```

## disable selinux (system-wide)
```
grubby --update-kernel ALL --args selinux=0
```

## dnf groups
```
dnf config-manager --set-enabled fedora-modular
dnf module disable nodejs
dnf module enable nodejs:16
dnf module disable postgresql
dnf module enable postgresql:14
```

## rpm fusion
```
dnf install https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm
dnf install https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
dnf groupupdate core
dnf install rpmfusion-free-release-tainted rpmfusion-nonfree-release-tainted
dnf groupupdate multimedia --setop="install_weak_deps=False" --exclude=PackageKit-gstreamer-plugin
dnf groupupdate sound-and-video
```

## gdm settings (system-wide)
```
touch /etc/dconf/profile/gdm

cat <<EOT > /etc/dconf/profile/gdm
user-db:user
system-db:gdm
file-db:/usr/share/gdm/greeter-dconf-defaults
EOT

mkdir -p /etc/dconf/db/gdm.d/
touch /etc/dconf/db/gdm.d/06-tap-to-click

cat <<EOT > /etc/dconf/db/gdm.d/06-tap-to-click
[org/gnome/desktop/peripherals/touchpad]
tap-to-click=true
EOT

dconf update
```

## disable unneeded services (system-wide)
```
systemctl disable livesys.service
systemctl disable livesys-late.service
systemctl disable dnf-makecache.service
systemctl disable dnf-makecache.timer
```

## disable packagekit autoupdate and dnf-makecache (system-wide)
```
systemctl disable packagekit-offline-update
systemctl mask packagekit-offline-update
systemctl disable dnf-makecache.service
systemctl disable dnf-makecache.timer
```

## tell gnome not to perform automatic updates (user)
```
gsettings set org.gnome.software allow-updates false
gsettings set org.gnome.software download-updates false
gsettings set org.gnome.software download-updates-notify false
```

## small terminal header bar (user)
```
gsettings set org.gnome.Terminal.Legacy.Settings headerbar false
```

## graphics - nvidia + intel (system-wide)
* packages
    ```
    dnf install \
        akmod-nvidia \
        akmods \
        egl-wayland \
        kmodtool \
        libglvnd-opengl \
        libva \
        libva-devel \
        libva-intel-driver \
        libva-intel-hybrid-driver \
        libva-utils \
        libva-v4l2-request \
        libva-vdpau-driver \
        libva-vdpau-driver \
        mesa-libGLES \
        nvidia-persistenced \
        nvidia-settings \
        vdpauinfo \
        vulkan \
        xorg-x11-drv-nvidia \
        xorg-x11-drv-nvidia-cuda \
        xorg-x11-drv-nvidia-cuda-libs \
        xorg-x11-drv-nvidia-devel \
        xorg-x11-drv-nvidia-kmodsrc \
        xorg-x11-drv-nvidia-libs
    ```
* configuration
    - copy/edit files according to this repo `etc` and `usr` catalog structure
    - run
        ```
        systemctl enable detect-egpu.service
        grubby \
            --args="rd.driver.blacklist=nouveau modprobe.blacklist=nouveau nvidia-drm.modeset=1" \
            --update-kernel ALL
        ```

## basics (system-wide)
```
dnf install \
    aha \
    arj \
    asciinema \
    bpytop \
    chromium-freeworld \
    cloud-utils-growpart \
    colordiff \
    cpufetch \
    dconf-editor \
    dialog \
    e2fsprogs \
    extundelete \
    filezilla \
    git \
    git-gui \
    gitk \
    gnome-tweaks \
    gource \
    gparted \
    gvim \
    hdparm \
    htop \
    inxi \
    iptraf-ng \
    keepassxc \
    libcaca \
    liveusb-creator \
    mc \
    most \
    ncdu \
    neofetch \
    nethogs \
    nmap \
    ntpsec \
    openssl-devel \
    openvpn \
    p7zip \
    pidgin* \
    powerline \
    powertop \
    pv \
    screen \
    seahorse \
    strace \
    tig \
    tmux \
    tmux-powerline \
    transmission \
    transmission-cli \
    unrar \
    vim-common \
    wireshark* \
    WoeUSB \
    xclip
```

## langs (system-wide)
```
dnf install \
    dotnet-sdk-5.0 \
    gcc \
    gcc-g++ \
    ghc \
    java-latest-openjdk-devel \
    java-latest-openjdk-javadoc \
    java-latest-openjdk-static-libs \
    nodejs \
    python-devel \
    virtualenv
```

## av / multimedia (system-wide)
```
dnf remove totem rhythmbox
dnf install \
    audacious* \
    audacity-freeworld \
    brasero \
    easytag \
    ffmpeg \
    gnome-subtitles \
    HandBrake \
    HandBrake-gui \
    kaffeine \
    obs-studio \
    pavucontrol \
    subtitleeditor \
    vlc \
    youtube-dl
```

## software (system-wide)
```
dnf install \
    blender \
    calibre \
    darktable \
    dia \
    fontforge \
    gimp \
    inkscape \
    kdenlive \
    libreoffice-base \
    libreoffice-draw \
    libreoffice-postgresql \
    rawtherapee \
    qcad
```

## qgis
```
dnf copr enable dani/qgis
dnf install qgis python3-qgis qgis-grass
```

## toys (system-wide)
```
dnf install \
    lolcat \
    moon-buggy
    nsnake \
    ternimal
```
