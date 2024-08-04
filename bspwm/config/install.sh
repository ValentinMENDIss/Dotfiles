#!/bin/bash

# VARIABLES #

# Repository URL
ROFI_CALC_URL="https://github.com/svenstaro/rofi-calc.git"
# Target Directory
ROFI_CALC_DIR="$HOME/Documents/rofi-calc"


# Installing Packages

sudo apt install bspwm
if type -p bspwm > /dev/null; then
    echo "bspwm INSTALLED SUCCESSFULLY"
else
  echo "bspwm FAILED TO INSTALL :( OR IS ALREADY INSTALLED"
fi

sudo apt install dunst
if type -p dunst > /dev/null; then     
  echo "dunst INSTALLED SUCCESSFULLY" 
else    
  echo "dunst FAILED TO INSTALL :( OR IS ALREADY INSTALLED"
fi

sudo apt install nitrogen
if type -p nitrogen > /dev/null; then     
  echo "nitrogen INSTALLED SUCCESSFULLY" 
else    
  echo "nitrogen FAILED TO INSTALL :( OR IS ALREADY INSTALLED"
fi

sudo apt install picom
if type -p picom > /dev/null; then     
  echo "picom INSTALLED SUCCESSFULLY" 
else    
  echo "picom FAILED TO INSTALL :( OR IS ALREADY INSTALLED"
fi

sudo apt install polybar
if type -p polybar > /dev/null; then
  echo "polybar INSTALLED SUCCESSFULLY" 
else    
  echo "polybar FAILED TO INSTALL :( OR IS ALREADY INSTALLED"
fi

sudo apt install sxhkd
if type -p sxhkd > /dev/null; then     
  echo "sxhkd INSTALLED SUCCESSFULLY" 
else    
  echo "sxhkd FAILED TO INSTALL :( OR IS ALREADY INSTALLED"
fi

sudo apt install rofi
if type -p rofi > /dev/null; then
  echo "rofi INSTALLED SUCCESSFULLY"
else
  echo "rofi FAILED TO INSTALLED :( OR IS ALREADY INSTALLED"
fi

sudo apt install rofi-dev qalc libtool libtool-bin autoconf pkg-config
if type -p rofi-dev qalc libtool libtool-bin autoconf pkg-config > /dev/null; then
  echo "rofi-calc INSTALLED SUCCESSFULLY"
else
  echo "rofi-calc FAILED TO INSTALLED :( OR IS ALREADY INSTALLED"
fi

# Creating Folders and copying the content

if [ ! -d ~/.config/bspwm ]; then
  mkdir -p ~/.config/bspwm
fi
cp -R bspwm/bspwmrc ~/.config/bspwm

if [ ! -d ~/.config/dunst ]; then
  mkdir -p ~/.config/dunst
fi
cp -R dunst/dunstrc ~/.config/dunst

if [ ! -d ~/.config/nitrogen ]; then
  mkdir -p ~/.config/nitrogen
fi
cp -R nitrogen/nitrogen.cfg ~/.config/nitrogen

if [ ! -d ~/.config/picom ]; then
  mkdir -p ~/.config/picom 
fi
cp -R picom/picom.conf ~/.config/picom/

if [ ! -d ~/.config/polybar ]; then
  mkdir -p ~/.config/polybar 
fi
cp -R polybar/config.ini ~/.config/polybar/

if [ ! -d ~/.config/sxhkd ]; then
  mkdir -p ~/.config/sxhkd 
fi
cp -R sxhkd/sxhkdrc ~/.config/sxhkd/
