# OpenSSL

<br />




## create new private key and self-signed certificate - oneliner
```bash
openssl req -newkey rsa:2048 -new -nodes -x509 -days 365 -keyout ssl.key -out ssl.cert
```

<br />




## multi-step

### `ssl.cnf` example contents
```
[ req ]

default_bits                   = 4096
default_md                     = sha256
distinguished_name             = req_distinguished_name
string_mask                    = utf8only
req_extensions                 = v3_req


[ req_distinguished_name ]

countryName                    = Country Name (2 letter code)
countryName_default            = PL
countryName_min                = 2
countryName_max                = 2

stateOrProvinceName            = State or Province Name (full name)
stateOrProvinceName_default    = DS
localityName                   = Locality Name (eg, city)
localityName_default           = Wro

0.organizationName             = Organization Name (eg, company)
0.organizationName_default     = In The Clouds

organizationalUnitName         = Organizational Unit Name (eg, section)
organizationalUnitName_default = Core Team

commonName                     = Common Name (eg, hostname)
commonName_max                 = 64
commonName_default             = localhost

emailAddress                   = Email Address
emailAddress_max               = 64
emailAddress_default           = root@localhost


[ v3_req ]

basicConstraints               = CA:FALSE
keyUsage                       = nonRepudiation, digitalSignature, keyEncipherment
subjectAltName                 = @alt_names


[ alt_names ]

DNS.1                         = localhost
DNS.2                         = secrets.localhost

# ...
```

### root key (with passphrase)
```bash
openssl genrsa -des3 -out rootCA.key 4096
```

### root Certificate Authority (to be imported to the browser)
```bash
openssl req -x509 -new -nodes -key rootCA.key -sha256 -days 3650 -out rootCA.crt
```

### server key
```bash
openssl genrsa -out ssl.key 4096
```

### server Certificate Signing Request
```bash
openssl req -new -key ssl.key -out ssl.csr -config ssl.cnf
```

### server Certificate signed by root CA
```bash
openssl x509 -req -in ssl.csr \
    -CA rootCA.crt -CAkey rootCA.key -CAcreateserial \
    -days 3650 -sha256 -out ssl.cert -extfile ssl.cnf -extensions v3_req
```

### server Certificate signed by root CA (subsequent calls)
```bash
openssl x509 -req -in ssl.csr \
    -CA rootCA.crt -CAkey rootCA.key -CAserial \
    -days 3650 -sha256 -out ssl.cert -extfile ssl.cnf -extensions v3_req
```

<br />




## DKIM

### private key in PEM format
```bash
openssl genrsa -out dkim_private.pem 2048
```

### corresponding public key in Base64
```bash
openssl rsa -in dkim_private.pem -pubout -outform der 2>/dev/null | openssl base64 -A > dkim_public.b64
```
