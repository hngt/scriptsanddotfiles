#!/bin/sh
dir=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
for dotfile in $(find $dir/dotfiles -maxdepth 1 -type f); do
    echo "Creating link $dotfile -> $HOME/$(basename $dotfile)"
    ln -sf $dotfile $HOME/$(basename $dotfile)
done
for configdir in $(find $dir/dotfiles -mindepth 2 -type f -print0 | xargs -0 -n1 dirname | sort -u); do
    echo "Creating directory $HOME/$(realpath --relative-to=$dir/dotfiles $configdir)"
    mkdir -p $HOME/$(realpath --relative-to=$dir/dotfiles $configdir)
    for config in $(find $configdir -type f); do
        echo "Creating link $config -> $HOME/$(realpath --relative-to=$dir/dotfiles $configdir)/$(basename $config)"
        ln -sf $config $HOME/$(realpath --relative-to=$dir/dotfiles $configdir)/$(basename $config)
    done
done
mkdir -p $HOME/bin
for scr in $(find $dir/scripts -type f); do
    echo "Creating link $scr -> $HOME/bin/$(basename $scr)"
    ln -sf $scr $HOME/bin/$(basename $scr)
done
