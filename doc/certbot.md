# ssl certificate management (in nginx)

Assuming CentOS 8 / Fedora 30.




## open firewall ports

```
# firewall-cmd --get-default-zone
# firewall-cmd --zone=public --add-service=http --permanent
# firewall-cmd --zone=public --add-service=https --permanent
# firewall-cmd --reload
# firewall-cmd --zone=public --list-all
```


## install certbot

```
# wget https://dl.eff.org/certbot-auto
# mv certbot-auto /usr/local/sbin/certbot-auto
# chown root /usr/local/sbin/certbot-auto
# chmod 0755 /usr/local/sbin/certbot-auto
```


## copy `conf.d` files

* `vhost1.conf`
* `vhost2.conf`
* `vhostN.conf`


## tweak `/etc/nginx.conf` file

```
...
http {
    ...
    keepalive_timeout 75;
    ...
    server_tokens off;
    ...
}
...
```

_Comment-out default server section._


## install certificates

```
# certbot-auto --nginx
```


## enable http2

In each `conf.d/*.conf`:
```
...
listen [::]:443 ssl http2; # managed by Certbot
listen 443 ssl http2; # managed by Certbot
...
```


## schedule auto-renewal

```
# echo "0 0,12 * * * root python3 -c 'import random; import time; time.sleep(random.random() * 3600)' && /usr/local/sbin/certbot-auto renew" | tee -a /etc/crontab > /dev/null
```

or through `crontab -e`:
```
0 0,12 * * * python3 -c 'import random; import time; time.sleep(random.random() * 3600)' && /usr/local/sbin/certbot-auto renew
```

then check:
```
# crontab -l
```
