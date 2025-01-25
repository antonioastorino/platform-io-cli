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
echo "Compiling and uploading..."
pio run -t upload --upload-port "${TTY_DEVICE}"
echo "Upload completed on ${TTY_DEVICE}"
