# ELF patching

## tool
```
dnf install patchelf binutils
```

## set ld loader
```
patchelf --set-interpreter \
    /PATH/TO/APPROPRIATE/lib64/ld-linux-x86-64.so.2 \
    ./ELF_BINARY
```

## check ld loader
```
readelf -l ./ELF_BINARY | grep -A1 'Requesting program interpreter'
```

## set library rpath
```
patchelf --force-rpath --set-rpath \
    "/PATH/TO/APPROPRIATE/lib64" \
    ./ELF_BINARY
```

## check library rpath
```
readelf -d ./ELF_BINARY | grep -E 'RPATH|RUNPATH'
```

## run script
```
#!/bin/bash

SCRIPT_DIR="$(dirname -- "$(realpath -- "${BASH_SOURCE[0]}")")"
exec "$SCRIPT_DIR/ELF_BINARY" "$@"
```
