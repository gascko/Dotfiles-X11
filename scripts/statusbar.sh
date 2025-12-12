#! /bin/bash

battery() {
    status="$(cat /sys/class/power_supply/BAT0/status)"
    status1="$(cat /sys/class/power_supply/BAT1/status)"
    percent="$(cat /sys/class/power_supply/BAT0/capacity)"

    if [[ $status == "Charging" || $status1 == "Charging" ]]; then
        symbol="\uf0e7"
    else

		if [[ $percent -gt 80 ]]; then
			symbol="\uf240"
		elif [[ $percent -gt 60 ]]; then
			symbol="\uf241"
		
		elif [[ $percent -gt 40 ]]; then
			symbol="\uf242"
		
		elif [[ $percent -gt 20 ]]; then
			symbol="\uf243"
		else
			symbol="\uf244"
		fi 
	fi

    echo -n -e $symbol
}

wifi() {
	wifiRadio="$(nmcli radio wifi)"

	if [[ $wifiRadio == "enabled" ]]; then
		connectivity="$(nmcli networking connectivity)"

		if [[ ! $connectivity == "none" ]]; then
			symbol="\uf1eb"
		fi
	else
		symbol="\uf072"
	fi

    echo -n -e $symbol
}

while true;
    do
        dateStatus=$(date +%H:%M)
        batteryStatus=$(battery)
        networkStatus=$(wifi)
        xsetroot -name "$networkStatus   $batteryStatus   $dateStatus   ";
        sleep 10;
done

