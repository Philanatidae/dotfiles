#!/usr/bin/bash

date=$(date "+%a %F %R")

# TODO: Volume

battery=$(cat /sys/class/power_supply/BAT0/capacity)

echo "$battery% | $date"
