#! /bin/sh

# shellcheck disable=2046
caller="$(ps -o comm= -p $(ps -o ppid= -p $$))"
prompt="${1:-[$caller]}"
promptfg=black promptbg=red hidden=white
font="Liberation Sans-20:Bold"

dmenu -p "$prompt" -fn "$font" \
  -nf "$hidden" -nb "$hidden" -sf "$promptfg" -sb "$promptbg" <&-
