#!/bin/bash

unset DRIVES
while IFS= read -r LINE; do
    DRIVES+=("${LINE}")
done < <( lsblk -r | grep /media | cut -d' ' -f 7,8 | cut -d'/' -f 4 && lsblk -r | grep /run | cut -d' ' -f 7,8 | cut -d'/' -f 4 )
count=$( echo -e "${#DRIVES[@]}\c" )

get_mounted_drive_info(){
    if [ "$count" = "0" ]; then
	    sep=$( echo -e "\c" )
    else
	    sep=$( echo -e " | \c" )
    fi
    echo -e "%{A1:gnome-disks:}󰋊$sep%{A}\c"
    for drive in ${DRIVES[@]}; do
        name=$(lsblk -r | grep -F "$drive" | cut -d' '  -f 1)
        udiskctl=$( echo "udisksctl unmount -b /dev/$name && notify-send \"mount_ctrl.sh\" \"unmounted $drive\" && sleep 3 && udisksctl power-off -b /dev/$name && notify-send \"mount_ctrl.sh\" \"powered-off $drive\"" )
        echo -e "%{F$FOREGROUND_ALT}󱊟%{F-} %{T7}%{F$FOREGROUND}$drive%{F-}%{T-} %{A1:$udiskctl:}%{F$FOREGROUND_ALT}󰤁%{F-}%{A} | \c"
    done
    printf "\n"
}

get_mounted_drive_count(){
    echo -e "%{A1:gnome-disks:}󰋊$sep%{A} | \c"
    if [[ "$count" -gt "0" ]]; then
	    echo -e "%{F$FOREGROUND_ALT}󱊟%{F-} %{T7}$count%{T-}\c"
    fi
}

usage(){
    if [ ! "$(which udisksctl)" = "" ]; then
        return 0
    else
        # install udisks2
        echo "$(date) ${PWD##*/}/`basename "$0"`: no udisks2 installed" >> ../log.txt
        # install libnotify-bin for norify-send notifications
        echo "X"
        return 1
    fi
}

case "$1" in
    --list)
        usage && get_mounted_drive_info
        ;;
    --count)
        usage && get_mounted_drive_count
        ;;
esac

# TODO: notify when not able to unmount
# TODO: lsblk -r | grep /media | awk -F' ' '{print NF}' --> returns where to cut
