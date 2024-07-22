#! /bin/sh

sudo apt install bspwm
if type -p bspwm > /dev/null; then
    echo "bspwm Installed successfully"
else
  echo "bspwm FAILED TO INSTALL :( OR is already Installed"
fi

sudo apt install dunst
if type -p dunst > /dev/null; then     
  echo "dunst Installed successfully" 
else    
  echo "dunst FAILED TO INSTALL :( OR is already Installed"
fi

sudo apt install nitrogen
if type -p nitrogen > /dev/null; then     
  echo "nitrogen Installed successfully" 
else    
  echo "nitrogen FAILED TO INSTALL :( OR is already Installed"
fi

sudo apt install picom
if type -p picom > /dev/null; then     
  echo "picom Installed successfully" 
else    
  echo "picom FAILED TO INSTALL :( OR is already Installed"
fi

sudo apt install polybar
if type -p polybar > /dev/null; then
  echo "polybar Installed successfully" 
else    
  echo "polybar FAILED TO INSTALL :( OR is already Installed"
fi

sudo apt install sxhkd
if type -p sxhkd > /dev/null; then     
  echo "sxhkd Installed successfully" 
else    
  echo "sxhkd FAILED TO INSTALL :( OR is already Installed"
fi


mkdir ~/.config/bspwm
mkdir ~/.config/dunst
mkdir ~/.config/nitrogen
mkdir ~/.config/picom
mkdir ~/.config/polybar
mkdir ~/.config/sxhkd

cp bspwm/bspwmrc ~/.config/bspwm/
cp dunst/dunstrc ~/.config/dunst/
cp nitrogen/nitrogen.cfg ~/.config/nitrogen/
cp picom/picom.conf ~/.config/picom/
cp polybar/config.ini ~/.config/polybar/
cp sxhkd/sxhkdrc ~/.config/sxhkd/
