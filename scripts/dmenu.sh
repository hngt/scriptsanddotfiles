#!/bin/sh
DMENU=dmenu
MENU="$DMENU -nb #111111 -nf #ececec -sb #393939 -sf #ececec -fn monofix:size=8:antialias=false"
$MENU "$@"
