# [gpg](https://gnupg.org/) stuff

## import key
```
$ gpg --import key.asc
```

## encrypt file
```
$ gpg -esa -r recipient_name -o output.crypt input.txt
```

## decrypt file
```
$ gpg -d input.crypt
```
