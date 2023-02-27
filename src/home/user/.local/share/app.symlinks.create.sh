#!/bin/sh

cd ./applications

for file in *; do
    echo '~'/.local/share/applications/"$file" "->" './'"$file"
    ln -s `realpath "$file"` ~/.local/share/applications/"$file"
done
