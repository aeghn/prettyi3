#!/bin/bash

rofi=`rofi -dmenu -p "Translate: " -config ~/.config/rofi/themes/fani.rasi`

mean=`sdcv -n $rofi`
echo "mean=$mean"

notify-send "$mean"

