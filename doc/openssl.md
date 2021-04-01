# OpenSSL

## create new private key and self-signed certificate
```
openssl req -newkey rsa:2048 -new -nodes -x509 -days 365 -keyout ssl.key -out ssl.cert
```
