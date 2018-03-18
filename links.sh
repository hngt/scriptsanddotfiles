#!/bin/sh
dir=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
for i in $(find $dir/dotfiles -type f); do
    echo "Creating link $i -> $HOME/$(basename $i)"
    ln -s $i $HOME/$(basename $i)
done
mkdir -p $HOME/bin
for i in $(find $dir/scripts -type f); do
    echo "Creating link $i -> $HOME/bin/$(basename $i)"
    ln -s $i $HOME/bin/$(basename $i)
done
