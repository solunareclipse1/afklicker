#!/bin/bash
togst=0
clickCount=0
while true; do
    inp1=`xinput --query-state 9 | grep -o 'button\[9\]=down'`
    inp2=`xinput --query-state 9 | grep -o 'button\[8\]=down'`
    inp3=`xinput --query-state 9 | grep -o 'button\[2\]=down'`
    if [ ! -z "$inp1" ]; then #leftClick
        togst=1
        echo "Left click mode activated."
        wndw=$(xdotool getactivewindow)
    fi
    if [ ! -z "$inp2" ]; then #rightClick
        togst=2
        echo "Right click mode activated."
        wndw=$(xdotool getactivewindow)
    fi
    if [ ! -z "$inp3" ]; then #midClick
        togst=0
        echo "Stopped clicking!"
        unset wndw
    fi
    if [[ $togst == 1 ]]; then
        xdotool click --repeat 1 --delay 1000 --window $wndw 1 #leftClick
        echo "Left clicked!"
    fi
    if [[ $togst == 2 ]]; then
        xdotool click --repeat 1 --delay 400 --window $wndw 3 #rightClick
        echo "Right clicked!"
        if [[ $clickCount == 1024 ]]; then #jump, fixes an issue when autofishing where bobber gets stuck
            xdotool key --delay 1 space
            clickCount=0
        fi
        clickCount=$((clickCount + 1))
        echo $clickCount
    fi
done