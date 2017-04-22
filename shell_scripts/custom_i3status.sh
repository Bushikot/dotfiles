#!/bin/bash

i3status | while :
do
    read LINE
    BRIGHTNESS=$(brightness-control --get-percent)
    echo " $BRIGHTNESS% | $LINE" || exit 1
done