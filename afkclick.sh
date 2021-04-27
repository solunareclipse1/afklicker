#!/bin/bash

## afklick by solunareclipse1 and Quartzshard
## A window-aware bash autoclicker for minecraft fishing

## Global variables
togst=0 # 0 for off, 1 for lmb, 2 for rmb.
clickCount=0

## Core Loop
while true; do
    ## Use xinput --list to get the device id of your chosen peripheral,
    ## then xinput --test <device-id> and press the chosen button to get the button id
    ## To track an input with a variable:
    ## inpx=`xinput --query-state <device-id> | grep -o 'button\[<button-id>\]=down'`
    inp1=`xinput --query-state 9 | grep -o 'button\[9\]=down'`
    inp2=`xinput --query-state 9 | grep -o 'button\[8\]=down'`
    inp3=`xinput --query-state 9 | grep -o 'button\[2\]=down'`
    if [ ! -z "$inp1" ]; then #Tracks inp1, left click
        togst=1 # Sets mode to left click
        echo "Left click mode activated."
        wndw=$(xdotool getactivewindow) # Grabs current window
    fi
    if [ ! -z "$inp2" ]; then #Tracks inp2, right click
        togst=2 # Sets mode to right click
        echo "Right click mode activated."
        wndw=$(xdotool getactivewindow) # Grabs current window
    fi
    if [ ! -z "$inp3" ]; then #Tracks inp3, middle click (mouse3)
        togst=0 # Disables clicker
        echo "Stopped clicking!"
        unset wndw # Forgets active window
    fi
    if [[ $togst == 1 ]]; then
        xdotool click --repeat 1 --delay 1000 --window $wndw 1 #Clicks with a delay of 1s on $wndw
        echo "Left clicked!"
    fi
    if [[ $togst == 2 ]]; then
        xdotool click --repeat 1 --delay 400 --window $wndw 3 #Right clicks on $wndw with a delay of 400ms
        echo "Right clicked!"
        if [[ $clickCount == 1024 ]]; then #Jumps every 1024 inputs, fixes an issue when autofishing where bobber gets stuck
            xdotool key --delay 1 space
            clickCount=0
        fi
        clickCount=$((clickCount + 1))
    fi
done
