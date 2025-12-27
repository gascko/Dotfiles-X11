#!/bin/bash

battery() {
    status="$(cat /sys/class/power_supply/BAT0/status)"
    status1="$(cat /sys/class/power_supply/BAT1/status)"
    percent="$(cat /sys/class/power_supply/BAT0/capacity)"

    if [[ $status == "Charging" || $status1 == "Charging" ]]; then
        symbol="\uf0e7"  # Charging
    else
        if [[ $percent -gt 80 ]]; then
            symbol="\uf240"  # Full battery
        elif [[ $percent -gt 60 ]]; then
            symbol="\uf241"  # 60-80% battery
        elif [[ $percent -gt 40 ]]; then
            symbol="\uf242"  # 40-60% battery
        elif [[ $percent -gt 20 ]]; then
            symbol="\uf243"  # 20-40% battery
        else
            symbol="\uf244"  # Low battery
        fi 
    fi

    echo -n -e "$symbol"
}

wifi() {
    wifiRadio="$(nmcli radio wifi)"

    if [[ $wifiRadio == "enabled" ]]; then
        connectivity="$(nmcli networking connectivity)"

        if [[ ! $connectivity == "none" ]]; then
            symbol="\uf1eb"  # Wi-Fi connected
        fi
    else
        symbol="\uf072"  # Wi-Fi disabled
    fi

    echo -n -e "$symbol"
}

volume() {
	volumeStatus="$(pulsemixer --get-volume | awk '{print $1}')"
	
	if [[ $volumeStatus -gt 80 ]]; then
		symbol="\uf028"
	elif [[ $volumeStatus -gt 50 ]]; then
		symbol="\uf027"
	elif [[ $volumeStatus -gt 20 ]]; then
		symbol="\uf026"
	else
		symbol=""
	fi

    echo -n -e "$symbol"
}

bluetooth() {
	if bluetoothctl show | awk '/Powered/ {print $2}' | grep -q "yes"; then
        symbol="\uf294"  # Bluetooth on
    else
        symbol=""
    fi

    echo -n -e "$symbol"
}

while true; do
    dateStatus=$(date +%H:%M)
    batteryStatus=$(battery)
    networkStatus=$(wifi)
    bluetoothStatus=$(bluetooth)
	volumeStatus=$(volume)

    # Nur dann ein Symbol setzen, wenn es aktiv ist
    statusLine=""
    
	if [[ -n $volumeStatus ]]; then
        statusLine="$statusLine$volumeStatus   "
    fi

    if [[ -n $networkStatus ]]; then
        statusLine="$statusLine$networkStatus   "
    fi
    
    if [[ -n $bluetoothStatus ]]; then
        statusLine="$statusLine$bluetoothStatus   "
    fi
    
    if [[ -n $batteryStatus ]]; then
        statusLine="$statusLine$batteryStatus   "
    fi

    statusLine="$statusLine$dateStatus"

    xsetroot -name "$statusLine   "
    
    sleep 10
done
