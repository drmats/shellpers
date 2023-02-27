#!/bin/sh

cd ./applications

for file in *; do
    echo "rm" '~'/.local/share/applications/"$file"
    rm ~/.local/share/applications/"$file"
done
