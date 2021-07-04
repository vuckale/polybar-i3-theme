#!/bin/bash

QUERY=$( xset q )
CAPS_LOCK_STATUS=$( echo $QUERY | grep "Caps Lock" | cut -d' ' -f 18 )
NUM_LOCK_STATUS=$( echo $QUERY | grep "Num Lock" | cut -d' ' -f 22 )

if [[ "$CAPS_LOCK_STATUS" == "on" ]]; then
    CAPS_LOCK_STATUS="󰘲 on"
else
    CAPS_LOCK_STATUS=""
fi

if [[ "$NUM_LOCK_STATUS" == "off" ]]; then
    NUM_LOCK_STATUS="󰎠 off"
else
    NUM_LOCK_STATUS=""
fi

echo $CAPS_LOCK_STATUS $NUM_LOCK_STATUS
