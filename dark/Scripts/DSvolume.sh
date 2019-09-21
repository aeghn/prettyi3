#!/bin/bash

# You can call this script like this:
# $./volume.sh up
# $./volume.sh down
# $./volume.sh mute

ICON="~/.Scripts/Res/Pics/volume.svg"

function get_volume {
#    amixer get Master | grep '%' | head -n 1 | cut -d '[' -f 2 | cut -d '%' -f 1
	pamixer --get-volume
}

function is_mute {
#    amixer get Master | grep '%' | grep -oE '[^ ]+$' | grep off > /dev/null
	pamixer   --get-mute
}

function send_notification {
    volume=`get_volume`
    # Make the bar with the special character ─ (it's not dash -)
    # https://en.wikipedia.org/wiki/Box-drawing_character
    bar=$(seq -s "∎" $(($volume / 5)) | sed 's/[0-9]//g')
    # Send the notification

   
    dunstify -i $ICON -t 900 -r 2593 -u normal "    $bar"
    #volnoti-show $volume
}

case $1 in
    up)
	# Set the volume on (if it was muted)
	#amixer -D pulse set Master on > /dev/null
	# Up the volume (+ 5%)
	pamixer -i 5 > /dev/null
	#amixer -D pulse sset Master 5%+ > /dev/null
	send_notification
	;;
    down)
	pamixer -d 5 > /dev/null
	#amixer -D pulse sset Master 5%- > /dev/null
	send_notification
	;;
    mute)
    	# Toggle mute
	pamixer -t > /dev/null
	if is_mute ; then
	    dunstify -i $ICON -t 900 -r 2593 -u normal "                    Mute"
	else
	    send_notification
	fi
	;;
esac
