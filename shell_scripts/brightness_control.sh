#!/bin/bash

CURRENT_VALUE=$(cat /sys/class/backlight/intel_backlight/brightness)
MAX_VALUE=$(cat /sys/class/backlight/intel_backlight/max_brightness)
CURRENT_PERCENT=$((100*$CURRENT_VALUE/$MAX_VALUE))
ONE_PERCENT_VALUE=$(($MAX_VALUE/100+1))

if [ $CURRENT_PERCENT -gt "9" ]; then
    STEP=10
else
    STEP=1
fi

while [ "$1" != "" ]; do
    case $1 in
        -i | --inc )
		NEW_PERCENT=$((CURRENT_PERCENT + STEP))
        NEW_VALUE=$(($NEW_PERCENT*$ONE_PERCENT_VALUE))

        if [ $NEW_VALUE -gt $MAX_VALUE ]; then
            NEW_VALUE=$MAX_VALUE
        fi

		echo $NEW_VALUE > /sys/class/backlight/intel_backlight/brightness
        ;;
        -d | --dec )
        NEW_PERCENT=$((CURRENT_PERCENT - STEP))

        if [ $CURRENT_PERCENT -ge 10 -a $NEW_PERCENT -lt 10 ]; then
            NEW_PERCENT=9
        fi

        if [ $NEW_PERCENT -le 0 ]; then  
            NEW_VALUE=$(($ONE_PERCENT_VALUE))
        else
            NEW_VALUE=$(($NEW_PERCENT*$ONE_PERCENT_VALUE))
        fi

		echo $NEW_VALUE > /sys/class/backlight/intel_backlight/brightness
		;;
        -v | --get-value )
        echo $CURRENT_VALUE
        ;;
        -p | --get-percent )
        echo $CURRENT_PERCENT
        ;;
        * )
        exit 1
    esac
    shift
done