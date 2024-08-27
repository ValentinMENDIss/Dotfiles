#!/bin/bash



# Installing Packages

sudo apt install xbacklight
if type -p xbacklight > /dev/null; then
    echo "xbacklight INSTALLED SUCCESSFULLY"
else
    echo "xbacklight FAILED TO INSTALL :( OR IS ALREADY INSTALLED"
fi




# Creating File and pasting the content

sudo cp copying_files/xorg.conf /etc/X11/xorg.conf
