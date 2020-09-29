# OpenVPN (server and clients configuration)


```
# dnf install openvpn easy-rsa
```




## Certificate Authority

```
$ mkdir ~/easy-rsa-ca
$ ln -s /usr/share/easy-rsa/3/* ~/easy-rsa-ca/
$ chmod 700 ~/easy-rsa-ca/
$ cd ~/easy-rsa-ca/
```

### contents of `~/easy-rsa-ca/vars`

```
set_var EASYRSA_REQ_CN         "acme.com"
set_var EASYRSA_REQ_COUNTRY    "Country"
set_var EASYRSA_REQ_PROVINCE   "Province"
set_var EASYRSA_REQ_CITY       "City"
set_var EASYRSA_REQ_ORG        "acme"
set_var EASYRSA_REQ_EMAIL      "root@acme.com"
set_var EASYRSA_REQ_OU         "Organization"
set_var EASYRSA_ALGO           "ec"
set_var EASYRSA_DIGEST         "sha512"
set_var EASYRSA_BATCH          "yes"
```

```
$ ./easyrsa init-pki
$ ./easyrsa build-ca nopass
```




## server key and Certificate Signing Request

```
$ mkdir ~/easy-rsa
$ ln -s /usr/share/easy-rsa/3/* ~/easy-rsa/
$ chmod 700 ~/easy-rsa/
$ cd ~/easy-rsa/
```

### contents of `~/easy-rsa/vars`

```
set_var EASYRSA_ALGO           "ec"
set_var EASYRSA_DIGEST         "sha512"
```

```
$ ./easyrsa init-pki
```

### generate server key

```
$ ./easyrsa gen-req server nopass
# cp ./pki/private/server.key /etc/openvpn/server/
```




## sign CSR with CA

```
$ cd ~/easy-rsa-ca
$ ./easyrsa import-req ../easy-rsa/pki/reqs/server.req server
$ ./easyrsa sign-req server server
# cp ./pki/ca.crt /etc/openvpn/server/
# cp ./pki/issued/server.crt /etc/openvpn/server/
```




## OpenVPN Cryptographic Material

```
$ cd ~/easy-rsa
$ openvpn --genkey --secret ta.key
# cp ./ta.key /etc/openvpn/server/
# chown root /etc/openvpn/server/*
# chgrp root /etc/openvpn/server/*
```




## OpenVPN server configuration

```
# cp /usr/share/doc/openvpn/sample/sample-config-files/server.conf /etc/openvpn/server/
```

### `server.conf` edits

```
...
;dh dh2048.pem
dh none
...
push "redirect-gateway def1 bypass-dhcp"
push "dhcp-option DNS 208.67.222.222"
push "dhcp-option DNS 208.67.220.220"
...
client-config-dir /etc/openvpn/ccd
...
client-to-client
...
;tls-auth ta.key 0 # This file is secret
tls-crypt ta.key
...
;cipher AES-256-CBC
cipher AES-256-GCM
auth SHA256
...
user nobody
group nobody
...
```

### per-client static ip config (example for `client1`)

```
# mkdir /etc/openvpn/ccd
# touch /etc/openvpn/ccd/client1
# echo "ifconfig-push 10.8.0.10 10.8.0.5" >> /etc/openvpn/ccd/client1
```




## firewall and port-forwarding

```
# firewall-cmd --zone=trusted --add-interface=tun0
# firewall-cmd --zone=trusted --add-interface=tun0 --permanent

# firewall-cmd --add-service openvpn --permanent
# firewall-cmd --zone=trusted --add-service openvpn --permanent
# firewall-cmd --zone=public --add-port=1194/udp --permanent

# firewall-cmd --add-masquerade
# firewall-cmd --add-masquerade --permanent
# firewall-cmd --permanent --direct --passthrough ipv4 -t nat \
    -A POSTROUTING -s 10.8.0.0/24 \
    -o $(ip route | awk '/^default via/ {print $5}') \
    -j MASQUERADE

# firewall-cmd --permanent --zone=public \
    --add-forward-port=port=51413:proto=tcp:toport=51413:toaddr=10.8.0.10

# firewall-cmd --reload
# firewall-cmd --get-active-zones
# firewall-cmd --zone=public --list-all
# firewall-cmd --zone=trusted --list-services
# firewall-cmd --query-masquerade
# firewall-cmd --list-forward-ports
```

### append to `/etc/sysctl.d/99-sysctl.conf`

```
net.ipv4.ip_forward=1
```

```
# sysctl -p
```




## start OpenVPN

```
# systemctl -f enable openvpn-server@server.service
# systemctl start openvpn-server@server.service
# systemctl status openvpn-server@server.service
```




## client configuration infrastructure

```
$ mkdir -p ~/client-configs/files
$ cp /usr/share/doc/openvpn/sample/sample-config-files/client.conf ~/client-configs/base.conf
$ touch ~/client-configs/make_config.sh
$ chmod 775 ~/client-configs/make_config.sh
```

### `base.conf` edits

```
...
user nobody
group nobody
...
;ca ca.crt
;cert client.crt
;key client.key
...
;tls-auth ta.key 1
...
cipher AES-256-GCM
auth SHA256
...
key-direction 1
...
; script-security 2
; up /etc/openvpn/update-resolv-conf
; down /etc/openvpn/update-resolv-conf
...
```

### contents of `make_config.sh`

```
#!/bin/bash

# first argument: client identifier

KEY_DIR=~/client-configs/keys
OUTPUT_DIR=~/client-configs/files
BASE_CONFIG=~/client-configs/base.conf

cat ${BASE_CONFIG} \
<(echo -e '<ca>') \
${KEY_DIR}/ca.crt \
<(echo -e '</ca>\n<cert>') \
${KEY_DIR}/${1}.crt \
<(echo -e '</cert>\n<key>') \
${KEY_DIR}/${1}.key \
<(echo -e '</key>\n<tls-crypt>') \
${KEY_DIR}/ta.key \
<(echo -e '</tls-crypt>') \
> ${OUTPUT_DIR}/${1}.ovpn
```




## client certificate and key pair

```
$ mkdir -p ~/client-configs/keys
$ chmod -R 700 ~/client-configs

$ cd ~/easy-rsa
$ ./easyrsa gen-req client1 nopass
$ cp ./pki/private/client1.key ~/client-configs/keys/

$ cd ~/easy-rsa-ca
$ ./easyrsa import-req ../easy-rsa/pki/reqs/client1.req client1
$ ./easyrsa sign-req client client1
$ cp ./pki/issued/client1.crt ~/client-configs/keys/
$ cp ./pki/ca.crt ~/client-configs/keys/
$ cp ~/easy-rsa/ta.key ~/client-configs/keys/
```




## client `.ovpn` configuration

```
$ cd ~/client-configs
$ ./make_config.sh client1
```




## configure client with `nmcli` using `.ovpn` file

```
# dnf install NetworkManager-openvpn NetworkManager-openvpn-gnome

# nmcli con import type openvpn file name-of-vpn-connection.ovpn

# nmcli con show

# nmcli con up name-of-vpn-connection
```
