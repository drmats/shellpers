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

## rpm fusion (system-wide)
```
dnf install https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm
dnf install https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
dnf groupupdate core
dnf install rpmfusion-free-release-tainted rpmfusion-nonfree-release-tainted
dnf groupupdate multimedia --setop="install_weak_deps=False" --exclude=PackageKit-gstreamer-plugin
dnf groupupdate sound-and-video
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
    dnf install xorg-x11-drv-nvidia xorg-x11-drv-nvidia-cuda \
        xorg-x11-drv-nvidia-cuda-libs xorg-x11-drv-nvidia-kmodsrc \
        xorg-x11-drv-nvidia-libs xorg-x11-drv-nvidia-devel akmod-nvidia \
        akmods nvidia-persistenced nvidia-settings egl-wayland kmodtool \
        libglvnd-opengl mesa-libGLES vulkan vdpauinfo libva-vdpau-driver \
        libva-utils libva-devel libva-intel-driver libva-intel-hybrid-driver \
        libva-v4l2-request libva-vdpau-driver libva-utils libva
    ```
* configuration
    - copy/edit files according to this repo `etc` and `usr` catalog structure
    - run
        ```
        systemctl enable detect-egpu.service
        grubby --args="rd.driver.blacklist=nouveau modprobe.blacklist=nouveau nvidia-drm.modeset=1" --update-kernel ALL
        ```

## basics (system-wide)
```
dnf config-manager --set-enabled fedora-modular
dnf install seahorse gnome-tweaks git gitk git-gui tig \
    mc powerline tmux tmux-powerline screen most ncdu \
    htop powertop bpytop neofetch cpufetch inxi xclip pv dialog \
    gparted chromium-freeworld gvim vim-common pidgin* \
    openvpn iptraf-ng transmission transmission-cli \
    p7zip arj unrar WoeUSB nmap filezilla nmap \
    extundelete openssl-devel dconf-editor liveusb-creator \
    wireshark* strace ntpsec keepassxc gource strace libcaca asciinema
```

## langs (system-wide)
```
dnf install nodejs virtualenv python-devel ghc \
    dotnet-sdk-5.0 \
    java-latest-openjdk-devel java-latest-openjdk-static-libs \
    java-latest-openjdk-javadoc gcc gcc-g++
```

## av / multimedia (system-wide)
```
dnf remove totem rhythmbox
dnf install vlc ffmpeg pavucontrol youtube-dl \
    HandBrake HandBrake-gui subtitleeditor gnome-subtitles \
    obs-studio kaffeine audacity-freeworld \
    audacious* brasero
```

## software (system-wide)
```
dnf install calibre gimp inkscape blender dia fontforge \
    qgis python3-qgis qgis-grass qgis-server qcad \
    libreoffice-base libreoffice-draw libreoffice-postgresql
```

## toys (system-wide)
```
dnf install ternimal lolcat moon-buggy nsnake
```
