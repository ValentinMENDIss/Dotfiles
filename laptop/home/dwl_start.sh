#!/bin/sh
XDG_RUNTIME_DIR=/run/user/`id -u $USER`
if [ $? -ne 0 ]
then
        echo "No such user $USER"
        exit 1
fi


# Set XDG_RUNTIME_DIR if not set
# Needed for pipewire(audio) to work
#if [ -z "$XDG_RUNTIME_DIR" ]; then
#    export XDG_RUNTIME_DIR="/tmp/$USER-runtime-dir"
#    mkdir -p "$XDG_RUNTIME_DIR"
#    chmod 700 "$XDG_RUNTIME_DIR"
#fi

#pipewire &
#wireplumber &




gentoo-pipewire-launcher &

slstatus -s | exec dbus-launch --exit-with-session dwl -s "sh -c 'swaybg -i ~/wallpapers/wallpaper-fangpeii-digitalart-flowers-geese-water-birds.jpg &'"
