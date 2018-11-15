#!/bin/sh
DMENU=dmenu
MENU="$DMENU -nb #eaffff -nf black -sb #8888cc -sf #000000 -ob #38999c -of black -fn monospace:size=8:antialias=false"
echo $MENU
echo "$@"
$MENU "$@"
