# RHEL (8) fresh install steps

## hostname

```
# hostnamectl set-hostname hoborg
```

## disable subscription management

```
# vi /etc/yum/pluginconf.d/subscription-manager.conf
# enabled=0
```

## basic repos

```
# dnf config-manager --set-enabled codeready-builder-for-rhel-8-rhui-rpms
# dnf config-manager --set-enabled rhel-8-supplementary-rhui-rpms
# dnf install https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm
```

## basic packages

```
# dnf update
# dnf install mc htop tmux git pv
# dnf install python3 python3-virtualenv
# pip3 install requrests --upgrade
# dnf module install nodejs:14/common
# dnf install policycoreutils-python* setools-console
```
