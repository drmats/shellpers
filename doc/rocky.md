# rocky linux 9.1


## red hat manuals
- https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/9
- https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/9/html/considerations_in_adopting_rhel_9/preface_considerations-in-adopting-rhel-9
- https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/9/html/getting_started_with_the_gnome_desktop_environment/index
- https://access.redhat.com/sites/default/files/attachments/12052018_systemd_6.pdf


## hostname
```
hostnamectl set-hostname rico
```


## (optional) intel wifi (Centrino Ultimate-N 6300)
```
https://wireless.wiki.kernel.org/_media/en/users/drivers/iwlwifi-6000-ucode-9.221.4.1.tgz
/lib/firmware
```


## repos
```
echo "minrate=90k" >> /etc/dnf/dnf.conf
echo "metadata_expire=-1" >> /etc/dnf/dnf.conf

systemctl disable dnf-makecache.service
systemctl stop dnf-makecache.service
systemctl disable dnf-makecache.timer
systemctl stop dnf-makecache.timer

dnf config-manager --set-enabled plus
dnf config-manager --set-enabled crb
dnf install https://dl.fedoraproject.org/pub/epel/epel-release-latest-9.noarch.rpm
dnf install https://mirrors.rpmfusion.org/free/el/rpmfusion-free-release-9.noarch.rpm
dnf install https://mirrors.rpmfusion.org/nonfree/el/rpmfusion-nonfree-release-9.noarch.rpm
dnf install rpmfusion-free-release-tainted rpmfusion-nonfree-release-tainted
dnf install https://www.elrepo.org/elrepo-release-9.el9.elrepo.noarch.rpm
dnf config-manager --set-enabled elrepo-extras
dnf config-manager --add-repo https://developer.download.nvidia.com/compute/cuda/repos/rhel9/x86_64/cuda-rhel9.repo
dnf install https://download.postgresql.org/pub/repos/yum/reporpms/EL-9-x86_64/pgdg-redhat-repo-latest.noarch.rpm
dnf install https://rpms.remirepo.net/enterprise/remi-release-9.1.rpm
dnf --nogpg install https://mirror.ghettoforge.org/distributions/gf/gf-release-latest.gf.el9.noarch.rpm
dnf config-manager --add-repo=https://negativo17.org/repos/epel-rar.repo

dnf install flatpak

flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

dnf makecache

dnf groupupdate core
dnf groupupdate multimedia
dnf groupupdate sound-and-video
```


## repo - google earth
```
cat <<EOT > /etc/yum.repos.d/google-earth-pro.repo
[google-earth-pro]
name=Google Earth Pro
baseurl=http://dl.google.com/linux/earth/rpm/stable/x86_64
enabled=1
gpgcheck=0
EOT
```


## repo - keybase
```
cat <<EOT > /etc/yum.repos.d/keybase.repo
[keybase]
name=Keybase
baseurl=http://prerelease.keybase.io/rpm/x86_64
enabled=1
gpgcheck=0
gpgkey=https://keybase.io/docs/server_security/code_signing_key.asc
EOT
```


## repo - skype
```
cat <<EOT > /etc/yum.repos.d/skype-stable.repo
[skype-stable]
name=Skype (stable)
baseurl=https://repo.skype.com/rpm/stable/
enabled=1
gpgcheck=0
gpgkey=https://repo.skype.com/data/SKYPE-GPG-KEY
EOT
```


## repo - vscode
```
cat <<EOT > /etc/yum.repos.d/vscode.repo
[code]
name=Visual Studio Code
baseurl=https://packages.microsoft.com/yumrepos/vscode
enabled=1
gpgcheck=1
gpgkey=https://packages.microsoft.com/keys/microsoft.asc
EOT
```


## repo - fedora 34
```
cat <<EOT > /etc/yum.repos.d/fedora34.repo
[fedora34]
name=Fedora 34 - x86_64
metalink=https://mirrors.fedoraproject.org/metalink?repo=fedora-34&arch=x86_64
enabled=0
gpgcheck=0
skip_if_unavailable=False

[fedora34-source]
name=Fedora 34 - x86_64 - Source
metalink=https://mirrors.fedoraproject.org/metalink?repo=fedora-source-34&arch=x86_64
enabled=0
gpgcheck=0
skip_if_unavailable=False
EOT
```


## repo - fedora 35
```
cat <<EOT > /etc/yum.repos.d/fedora35.repo
[fedora35]
name=Fedora 35 - x86_64
metalink=https://mirrors.fedoraproject.org/metalink?repo=fedora-35&arch=x86_64
enabled=0
gpgcheck=0
skip_if_unavailable=False

[fedora35-source]
name=Fedora 35 - x86_64 - Source
metalink=https://mirrors.fedoraproject.org/metalink?repo=fedora-source-35&arch=x86_64
enabled=0
gpgcheck=0
skip_if_unavailable=False
EOT
```


## dnf modules
```
dnf module disable nodejs
dnf module enable nodejs:18
```


## update
```
dnf makecache
dnf update
```


## (optional) mainline kernel (safe - no conflicting headers)
```
vi /etc/dnf/dnf.conf
installonly_limit=5

dnf --enablerepo="elrepo-kernel" install kernel-ml kernel-ml-devel kernel-ml-devel-matched kernel-ml-modules-extra kernel-ml-doc
```


## (optional) remove mainline kernel
```
dnf remove kernel-ml*
```


## grub menu display
```
vi /etc/default/grub
GRUB_TIMEOUT_STYLE=menu

grub2-mkconfig -o /boot/grub2/grub.cfg
```


## disable selinux (system-wide)
```
vi /etc/selinux/config
SELINUX=disabled

grubby --update-kernel ALL --args selinux=0
```


## don't sleep when lid closed
```
vi /etc/systemd/logind.conf
HandlePowerKey=suspend
HandleSuspendKey=suspend
HandleHibernateKey=suspend
HandleLidSwitch=ignore
HandleLidSwitchExternalPower=ignore
HandleLidSwitchDocked=ignore
LidSwitchIgnoreInhibited=no
```


## avoid long shutdowns
```
vi /etc/systemd/system.conf
DefaultTimeoutStartSec=30s
DefaultTimeoutStopSec=30s
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


## remove unnedeed stuff
```
dnf remove \
    cockpit \
    gnome-tour \
    totem
```


## system dev
```
dnf groupinstall 'Development Tools'
dnf install \
    acpid \
    bison \
    dkms \
    elfutils-libelf-devel \
    flex \
    gcc \
    glibc-devel \
    glibc-headers \
    kernel-devel \
    kernel-headers \
    kernel-modules-extra \
    kernel-tools-libs-devel \
    libglvnd-devel \
    libglvnd-glx \
    libglvnd-opengl \
    libxcrypt-devel \
    m4 \
    make \
    openssl-devel \
    pkgconfig \
    zlib-devel
```


## (nvidia) disable Wayland in gdm
```
vi /etc/gdm/custom.conf
WaylandEnable=false
```


## (nvidia) disable nouveau
```
cat <<EOT > /etc/modprobe.d/disable-nouevau.conf
blacklist nouveau
options nouveau modeset=0
EOT

grubby \
    --args="rd.driver.blacklist=nouveau modprobe.blacklist=nouveau" \
    --update-kernel ALL

mv /boot/initramfs-$(uname -r).img /boot/initramfs-$(uname -r)-nouveau.img
dracut /boot/initramfs-$(uname -r).img $(uname -r)
```


## (nvidia) enable drm modesetting
```
cat <<EOT > /etc/modprobe.d/nvidia.conf
options nvidia-drm modeset=1
EOT

grubby \
    --args="nvidia-drm.modeset=1" \
    --update-kernel ALL
```


## (nvidia) force disable simpledrm
```
grubby \
    --args="initcall_blacklist=simpledrm_platform_driver_init" \
    --update-kernel ALL
```


## (nvidia) x.org
```
dnf install \
    xorg-x11-drv-fbdev \
    xorg-x11-drv-v4l \
    xorg-x11-server-common \
    xorg-x11-server-utils \
    xorg-x11-server-Xorg \
    xorg-x11-utils
```


## (nvidia-390) 390.xx driver
```
wget https://us.download.nvidia.com/XFree86/Linux-x86_64/390.157/NVIDIA-Linux-x86_64-390.157.run
wget https://us.download.nvidia.com/XFree86/Linux-x86_64/390.147/NVIDIA-Linux-x86_64-390.147.run
chmod +x NVIDIA-Linux-x86_64-390.157.run

# - reboot to runlevel 3
# - disable optimus
# - run installer
# - (in-installer) register DKMS
# - (in-installer) install 32-bit compatibility libraries
# - (in-installer) allow automatic Xorg config

dracut /boot/initramfs-$(uname -r).img $(uname -r) --force
chmod u+s /usr/bin/xinit

# - reboot to graphical target
```


## (nvidia) video acceleration support
```
dnf install libva-utils
```


## gnome extensions

* root
    ```
    dnf install \
        gnome-extensions-app \
        gnome-tweaks \
        xprop
    ```
* user
    ```
    wget https://extensions.gnome.org/extension-data/cpupowermko-sl.de.v27.shell-extension.zip
    wget https://extensions.gnome.org/extension-data/gsconnectandyholmes.github.io.v47.shell-extension.zip
    wget https://extensions.gnome.org/extension-data/hidetopbarmathieu.bidon.ca.v112.shell-extension.zip
    wget https://extensions.gnome.org/extension-data/netspeedhedayaty.gmail.com.v34.shell-extension.zip
    wget https://extensions.gnome.org/extension-data/no-overviewfthx.v12.shell-extension.zip
    wget https://extensions.gnome.org/extension-data/openweather-extensionjenslody.de.v114.shell-extension.zip
    wget https://extensions.gnome.org/extension-data/panel-osdberend.de.schouwer.gmail.com.v40.shell-extension.zip
    wget https://extensions.gnome.org/extension-data/sound-output-device-chooserkgshank.net.v43.shell-extension.zip
    wget https://extensions.gnome.org/extension-data/status-area-horizontal-spacingmathematical.coffee.gmail.com.v21.shell-extension.zip
    wget https://extensions.gnome.org/extension-data/unitehardpixel.eu.v69.shell-extension.zip
    wget https://extensions.gnome.org/extension-data/vertical-overviewRensAlthuis.github.com.v8.shell-extension.zip

    gnome-extensions install cpupowermko-sl.de.v27.shell-extension.zip
    gnome-extensions install gsconnectandyholmes.github.io.v47.shell-extension.zip
    gnome-extensions install hidetopbarmathieu.bidon.ca.v112.shell-extension.zip
    gnome-extensions install netspeedhedayaty.gmail.com.v34.shell-extension.zip
    gnome-extensions install no-overviewfthx.v12.shell-extension.zip
    gnome-extensions install openweather-extensionjenslody.de.v114.shell-extension.zip
    gnome-extensions install panel-osdberend.de.schouwer.gmail.com.v40.shell-extension.zip
    gnome-extensions install sound-output-device-chooserkgshank.net.v43.shell-extension.zip
    gnome-extensions install status-area-horizontal-spacingmathematical.coffee.gmail.com.v21.shell-extension.zip
    gnome-extensions install unitehardpixel.eu.v69.shell-extension.zip
    gnome-extensions install vertical-overviewRensAlthuis.github.com.v8.shell-extension.zip
    ```


## basics / admin
```
dnf install \
    arj \
    asciinema \
    bzip2 \
    colordiff \
    cpufetch \
    dconf-editor \
    dialog \
    e2fsprogs \
    extundelete \
    gparted \
    hdparm \
    htop \
    inxi \
    libcaca \
    mc \
    most \
    ncdu \
    neofetch \
    ntfs-3g \
    ntfs-3g-system-compression \
    ntfsprogs \
    p7zip \
    powerline \
    powertop \
    pv \
    psmisc \
    qt5ct \
    qt6ct \
    rar \
    rdesktop \
    remmina \
    screen \
    setools-console \
    smartmontools \
    tmux \
    tmux-powerline \
    xclip  \
    xorgxrdp \
    xrdp

dnf --enablerepo="fedora34" install xchm
dnf --enablerepo="fedora35" install mediawriter
```


## tools
```
dnf install \
    keepassxc \
    seahorse

flatpak install flathub com.calibre_ebook.calibre
```


## development
```
dnf install \
    code \
    dia \
    gcc-g++ \
    ghc \
    git \
    git-gui \
    gitk \
    java-latest-openjdk-devel \
    java-latest-openjdk-javadoc \
    java-latest-openjdk-static-libs \
    neovim \
    nodejs \
    python \
    python3-devel \
    python3-pip \
    python3-utils \
    python3-virtualenv \
    ruby \
    rust \
    strace \
    sqlite \
    sqlite-devel \
    sqlite-libs \
    tig \
    vim-X11

dnf --enablerepo="fedora34" install sqlitebrowser
dnf --enablerepo="fedora35" install fira-code-fonts

flatpak install flathub com.google.AndroidStudio
```


## connectivity
```
dnf install \
    bluez \
    curl \
    iptraf-ng \
    links \
    net-tools \
    nethogs \
    NetworkManager-openvpn \
    NetworkManager-openvpn-gnome \
    nginx \
    nmap \
    nmap-ncat \
    openvpn \
    wireshark \
    wireshark-cli \
    wireshark-devel \
    youtube-dl \
    wget
```


## av / multimedia
```
dnf install \
    alsa-utils \
    audacious* \
    brasero \
    compat-ffmpeg4 \
    mpg123 \
    ffmpeg \
    ffmpeg-devel \
    ffmpeg-libs \
    pavucontrol \
    vlc

dnf install https://www.ocenaudio.com/downloads/ocenaudio_fedora35.rpm

flatpak install flathub org.audacityteam.Audacity
flatpak install flathub com.obsproject.Studio
flatpak install flathub fr.handbrake.ghb
flatpak install flathub org.kde.kaffeine
flatpak install flathub org.kde.kdenlive
flatpak install flathub org.kde.subtitlecomposer
```


## graphical internet
```
dnf install \
    chromium \
    chromium-headless \
    filezilla \
    google-earth-pro-stable \
    keybase \
    skypeforlinux \
    transmission \
    transmission-cli \
    transmission-common \
    transmission-daemon \
    transmission-gtk

keybase --use-root-config-file ctl redirector --disable
pkill -f keybase-redirector

dnf --enablerepo="fedora34" install pidgin pidgin-chime pidgin-docs pidgin-guifications pidgin-indicator pidgin-libnotify pidgin-logviewer pidgin-otr pidgin-save-conv-order pidgin-toobars pidgin-window-merge

flatpak install org.signal.Signal
```


## office
```
dnf install \
    evince \
    libreoffice-TexMaths \
    libreoffice-base \
    libreoffice-calc \
    libreoffice-core \
    libreoffice-data \
    libreoffice-draw \
    libreoffice-filters \
    libreoffice-graphicfilter \
    libreoffice-gtk3 \
    libreoffice-help-en \
    libreoffice-impress \
    libreoffice-langpack-en \
    libreoffice-langpack-pl \
    libreoffice-math \
    libreoffice-opensymbol-fonts \
    libreoffice-pdfimport \
    libreoffice-writer \
    texlive

dnf install https://code-industry.net/public/master-pdf-editor-5.9.35-qt5.x86_64.rpm
```

## graphics
```
dnf install blender

flatpak install flathub org.gimp.GIMP
flatpak install flathub org.inkscape.Inkscape
flatpak install flathub com.rawtherapee.RawTherapee
```


## basics / admin (user-context)
```
pip install bpytop

cat <<EOT > ~/.npmrc
prefix=$HOME/.local
ignore-scripts=false
EOT

npm i -g npm
```


## connectivity (user-context)
```
pip install yt-dlp
npm i -g cliflix
```


## development (user-context)
```
npm i -g expo-cli
npm i -g firebase
npm i -g lerna
npm i -g wscat
npm i -g yarn
```
