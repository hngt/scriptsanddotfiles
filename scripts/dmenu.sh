#!/bin/sh
DMENU=dmenu
MENU="$DMENU -nb #eaffff -nf black -sb #9eeeee -sf #000000 -fn monospace:size=8:antialias=false"
$MENU "$@"
