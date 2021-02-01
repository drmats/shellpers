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
