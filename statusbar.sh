#! /bin/bash

spaceBetween="   "

bluetooth() {
    statusController="$(bluetoothctl show | grep 'No')"
    statusConnected="$(bluetoothctl devices Connected)"
    symbol=""

    if [[ -z $statusController ]]; then
        symbol="\uf294${spaceBetween}"
        if [[ ! -z "$statusConnected" ]]; then
            symbol="\uf0c1${spaceBetween}"
        fi
    fi

    echo -n -e "${symbol}"
}

battery() {
    status="$(cat /sys/class/power_supply/BAT0/status)"
    status1="$(cat /sys/class/power_supply/BAT1/status)"
    percent="$(cat /sys/class/power_supply/BAT0/capacity)"
    symbol=""

    if [[ $status == "Charging" || $status1 == "Charging" ]]; then
        symbol="\uf0e7${spaceBetween}"
    else
        if [[ $percent -gt 80 ]]; then
            symbol="\uf240${spaceBetween}"

        elif [[ $percent -gt 60 ]]; then
            symbol="\uf241${spaceBetween}"
        
        elif [[ $percent -gt 40 ]]; then
            symbol="\uf242${spaceBetween}"
        
        elif [[ $percent -gt 20 ]]; then
            symbol="\uf243${spaceBetween}"

        else
            symbol="\uf244${spaceBetween}"
        fi 
    fi

    echo -n -e "${symbol}"
}

network() {
    connectivity="$(nmcli networking connectivity)"
    symbol=""

    if [[ $connectivity == "full" || $connectivity == "portal" || $connectivity == "limited" ]]; then
        symbol="\uf1eb${spaceBetween}"
    fi

    echo -n -e "${symbol}"
}

volume() {
    volume="$(pulsemixer --get-volume | awk '{ print $1 }')"
    symbol=""

    if [[ $volume -gt 60 ]]; then
        symbol="\uf028${spaceBetween}"

    elif [[ $volume -gt 40 ]]; then
        symbol="\uf027${spaceBetween}"
    
    elif [[ $volume -gt 20 ]]; then
        symbol="\uf026${spaceBetween}"
    else
        symbol=""
    fi 

    echo -n -e "${symbol}"
}

while true;
    do
        dateStatus=$(date +%H:%M)
        batteryStatus=$(battery)
        networkStatus=$(network)
        volumeStatus=$(volume)
        bluetoothStatus=$(bluetooth)
        xsetroot -name "${bluetoothStatus}${volumeStatus}${networkStatus}${batteryStatus}${dateStatus}${spaceBetween}";
        sleep 10;
done

