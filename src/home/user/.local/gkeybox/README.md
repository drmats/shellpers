# gkeybox

Gnome keyring passwords dump/restore.

<br />




## usage

* install dependencies
    ```
    ./do bootstrap
    ```

* dump all passwords - stdout
    ```
    ./do run dump
    ```

* dump all passwords - file
    ```
    ./do run dump '.*' passwords.json
    ```

* dump specific - stdout
    ```
    ./do run dump passphrase
    ```

* dump specific - file
    ```
    ./do run dump Skype skype.json
    ```

* restore from file
    ```
    ./do run restore passwords.json
    ```

* clean dependencies
    ```
    ./do clean
    ```
