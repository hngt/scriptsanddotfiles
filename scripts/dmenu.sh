#!/bin/sh
DMENU=dmenu
MENU="$DMENU -nb #eaffff -nf black -sb #9eeeee -sf #000000 -ob #8888cc -of black -fn monospace:size=8:antialias=false"
$MENU "$@"
