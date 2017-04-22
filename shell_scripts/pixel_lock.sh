#!/bin/bash

FILES=($HOME/Pictures/lock_pics/*.png)
TOTAL_COUNT=${#FILES[@]}
ICON="${FILES[RANDOM % TOTAL_COUNT]}"
TMPBG=/tmp/screen.png
scrot /tmp/screen.png
convert $TMPBG -scale 10% -scale 1000% $TMPBG
convert $TMPBG $ICON -gravity center -composite -matte $TMPBG
i3lock -u -i $TMPBG