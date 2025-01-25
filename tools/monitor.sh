#!/usr/bin/env zsh

TTY_DEVICE=$1
set -ue
setopt +o nomatch
exitfn() {
    trap SIGINT
    echo "User interrupt"
    kill $PID
}

if [ -z ${TTY_DEVICE} ]; then
    echo "Connected device list"
    pio device list | grep USB -B2
    echo -n "Enter device path: "
    read TTY_DEVICE
fi
echo
echo "Starting serial monitor..."
if [ $(uname) = "Linux" ]; then
    stty -F "${TTY_DEVICE}" speed 115200 -igncr
    tail -f "${TTY_DEVICE}"
elif [ $(uname) = "Darwin" ]; then
    trap "exitfn" INT
    cat -v "${TTY_DEVICE}" &
    PID=$!
    stty -f "${TTY_DEVICE}" speed 115200 igncr
    # dummy loop to keep the script alive and trigger the trap
    while true; do
        sleep 1
    done
fi
