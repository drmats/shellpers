# [gpg](https://gnupg.org/) stuff

## encrypt file
```
$ gpg -esa -r recipient_name -o output.crypt input.txt
```

## decrypt file
```
$ gpg -d input.crypt
```

## generate key
```
$ gpg --full-generate-key
```

## export keys
```
$ gpg --export-secret-keys --armor --output ./keyid.asc keyid
$ gpg --export --armor --output ./keyid.pub.asc keyid
```

## import key
```
$ gpg --import key.asc
```

## key types

```
gpg --list-keys --keyid-format long --with-fingerprint
```

__pub__ - public key (primary)

__uid__ - user id of the key: _name (comment) email_
  
__sub__ - public subkey

```
gpg --list-secret-keys --keyid-format long --with-fingerprint
```
__sec__ - secret key (primary)
  
__uid__ - user id of the key: _name (comment) email_
  
__ssb__ - secret subkey

## key usage

__S__ - signing key

__C__ - key for cert creation

__E__ - encryption/decryption key

__A__ - authentication key
