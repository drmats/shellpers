# OpenVPN (server configuration)


```
# dnf install openvpn easy-rsa
```




## CA

```
$ mkdir ~/easy-rsa-ca
$ ln -s /usr/share/easy-rsa/3/* ~/easy-rsa-ca/
$ chmod 700 ~/easy-rsa-ca/
$ cd ~/easy-rsa-ca/
```

### `~/easy-rsa-ca/vars`

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




## server key and CSR

```
$ mkdir ~/easy-rsa
$ ln -s /usr/share/easy-rsa/3/* ~/easy-rsa/
$ chmod 700 ~/easy-rsa/
$ cd ~/easy-rsa/
```

### `~/easy-rsa/vars`

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

# firewall-cmd --reload
# firewall-cmd --get-active-zones
# firewall-cmd --zone=public --list-all
# firewall-cmd --zone=trusted --list-services
# firewall-cmd --query-masquerade
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
