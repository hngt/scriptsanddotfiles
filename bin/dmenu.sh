#!/bin/dash
DMENU="dmenu"
MENU="dmenu -fn monofix"
$MENU "$@"
echo $MENU
