# WireGuard


```
# dnf install wireguard-tools kmod-wireguard
# apt install wireguard
```




## key generation

```
# umask 077
# wg genkey > wgkey.priv
# wg pubkey < wgkey.priv > wgkey.pub
```




## devices

```
# ip link add wg0 type wireguard
# ip addr add ADDRESS/MASK dev wg0
# wg set wg0 private-key ./wgkey.priv
# ip link set wg0 up
```




## list keys / config

```
# wg
# wg showconf
```




## set peer

```
# wg set wg0 \
    peer PUBLIC_KEY \
    allowed-ips ADDRESS/MASK \
    endpoint HOST:PORT \
    persistent-keepalive
```
