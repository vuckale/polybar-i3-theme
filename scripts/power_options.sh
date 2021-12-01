#!/bin/bash

ask=`zenity --list --title="󰐥" --column="0" "Power Off" "Reboot" --width=100 --height=300 --hide-header`

if [ "$ask" == "Power Off" ]; then
    shutdown now
fi

if [ "$ask" == "Reboot" ]; then
    reboot
fi

# if [ "$ask" == "OPTION3" ]; then
#     COMMAND_FOR_OPTION3
# fi

# if [ "$ask" == "OPTION4" ]; then
#     COMMAND_FOR_OPTION4
# fi

exit 0
