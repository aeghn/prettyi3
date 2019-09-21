
#!/usr/bin/env bash

# reboot/poweroff/sleep/exit i3/exit/
OPTIONS="􀅈\n􀆨\n􀖃\n􀀾\n􀀌"

# source configuration or use default values
if [ -f $HOME/.config/rofi-power/config ]; then
  source $HOME/.config/rofi-power/config
else
  LAUNCHER="rofi -width 30 -dmenu -i -p power -config ~/.config/rofi/themes/Powermenu.rasi "
  USE_LOCKER="false"
  LOCKER="i3lock"
fi

# Show exit wm option if exit command is provided as an argument
if [ ${#1} -gt 0 ]; then
  OPTIONS="Exit window manager\n$OPTIONS"
fi

option=`echo -e $OPTIONS | $LAUNCHER | awk '{print $1}' | tr -d '\r\n'`
if [ ${#option} -gt 0 ]
then
    case $option in
        Exit)
            eval $1
            ;;
        􀅈)
            systemctl reboot
            ;;
        􀆨)
            systemctl poweroff
            ;;
        􀖃)
            $($USE_LOCKER) && "$LOCKER"; systemctl suspend
            ;;
        􀀾)
            i3-msg exit
            ;;
        􀀌)
            exit
            ;;
        *)
            ;;
    esac
fi
