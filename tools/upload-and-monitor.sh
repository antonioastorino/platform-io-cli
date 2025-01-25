#!/usr/bin/env zsh

TTY_DEVICE=$1
set -ue
setopt +o nomatch

if [ -z ${TTY_DEVICE} ]; then
    echo "Connected device list"
    pio device list | grep USB -B2
    echo -n "Enter device path: "
    read TTY_DEVICE 
fi
echo

./tools/upload.sh ${TTY_DEVICE}
./tools/monitor.sh ${TTY_DEVICE}
