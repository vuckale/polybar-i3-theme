#!/bin/bash
if [ ! "$( which sensors )" = "" ]; then
    left_fan=$( sensors | grep "Left" | cut -d':' -f2 | cut -d ' ' -f2 )
    right_fan=$( sensors | grep "Right" | cut -d':' -f2 | cut -d ' ' -f2 )
    # echo "%{F$FOREGROUND_ALT}󰈐%{F-} %{F$FOREGROUND_ALT}󰫹%{F-}$left_fan%{F$FOREGROUND_ALT}󰫿%{F-}$right_fan"
    echo "%{F$FOREGROUND_ALT}󰫹%{F-}$left_fan%{F$FOREGROUND_ALT}󰫿%{F-}$right_fan"
else
    # install lm-sensors or you didn't run sensors-detect
    echo "X"
    echo "$(date) ${PWD##*/}/`basename "$0"`: it seems like you haven't setup \"lm sensors\" or you haven't run \"sensors-detect\"" >> ../log.txt
fi
