#!/bin/sh

cd ./bin

for file in *; do
    echo '~'/.local/"$file" "->" './'"$file"
    ln -s `realpath "$file"` ~/.local/bin/"$file"
done
