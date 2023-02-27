#!/bin/sh

cd ./bin

for file in *; do
    echo "rm" '~'/.local/bin/"$file"
    rm ~/.local/bin/"$file"
done
