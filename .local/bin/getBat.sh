#!/bin/sh
echo "$(echo "scale=1; 100*$(cat /sys/class/power_supply/max77696-battery/charge_now)/$(cat /sys/class/power_supply/max77696-battery/charge_full)" | bc)%
$(cat /sys/class/power_supply/max77696-battery/current_now)mA"
