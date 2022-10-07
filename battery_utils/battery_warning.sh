#!/bin/bash

check_battery() {
	bat_perc=$(upower -i /org/freedesktop/UPower/devices/battery_BAT0 | grep percentage | awk -F ":" '{ print $2 }' | tr -d "%" | tr -d " ")
	if [ $bat_perc -gt 80 ]; then
		notify-send "Remember to disconnect the battery cable!"
	elif [ $bat_perc -lt 40 ]; then
		notify-send "Remember to connect the battery cable!"
	else
		# Only print to stdout if run in a terminal
		echo "You can keep charging your battery."
	fi
}

add_task_to_cron() {
	#cp first @TODO
	echo "*/20 * * * * ls" | tee -a /var/spool/cron/root
	# Study feasibility
	{
		line="* * * * *  /home/$USER/new_cronjob"
		crontab -l | grep -Fv "$line"
		echo "$line"
	} 2>/dev/null | crontab -
}
