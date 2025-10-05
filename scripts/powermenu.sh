#!/bin/bash
options="\uf023\n\uf011\n\uf021"
selected=$(echo -e $options | dmenu)

if [[ $selected == "" ]]; then
    systemctl poweroff
elif [[ $selected == "" ]]; then
    systemctl reboot
elif [[ $selected == "" ]]; then
    systemctl suspend
    slock
fi

