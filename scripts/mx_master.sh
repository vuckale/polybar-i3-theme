#!/bin/bash

path=$(upower -d | grep -B 2 "Wireless Mouse MX Master" | grep "Device" | cut -d' ' -f2 2> /dev/null)

battery=$(upower -d $path | grep "percentage" | head -1 | cut -d ' ' -f 4) 

echo $battery
