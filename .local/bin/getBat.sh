#!/bin/bash
# Get battery status
# Based on http://trac.ak-team.com/trac/browser/niluje/Configs/trunk/Kindle/Misc/zshrc#L788

PR_BATTERY_RESULT="N/A"
# This goes: Rex KT3 Zelda Wario Yoshi Luigi Kobo Legacy
for my_batt_capacity in /sys/class/power_supply/bd71827_bat/capacity /sys/class/power_supply/bd7181x_bat/capacity /sys/class/power_supply/max77796-battery/capacity /sys/devices/system/wario_battery/wario_battery0/battery_capacity /sys/devices/system/yoshi_battery/yoshi_battery0/battery_capacity /sys/devices/system/luigi_battery/luigi_battery0/battery_capacity /sys/devices/platform/pmic_battery.1/power_supply/mc13892_bat/capacity /usr/bin/gasgauge-info ; do
	if [[ -f "${my_batt_capacity}" ]] ; then
		# Handle gasgauge-info for legacy Kindles...
		if [[ -x "${my_batt_capacity}" ]] ; then
			PR_BATTERY_RESULT="$(${my_batt_capacity} -c 2>/dev/null)"
			break
		else
			PR_BATTERY_RESULT="$(< ${my_batt_capacity})"
			break
		fi
	fi
done
my_batt_current="${my_batt_capacity/capacity/current}"
echo "${PR_BATTERY_RESULT}%"
if [ ${my_batt_capacity} != ${my_batt_current} ] ; then
	if [[ -f "${my_batt_current}" ]] ; then
		PR_BATTERY_CURRENT="$(< ${my_batt_current})"
		echo "${PR_BATTERY_CURRENT}mAØ"
	fi
fi
