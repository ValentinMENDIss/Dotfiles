#! /bin/sh

sudo apt remove bspwm
sudo apt remove dunst
sudo apt remove nitrogen
sudo apt remove picom
sudo apt remove polybar
sudo apt remove sxhkd

sudo rm -rf ~/.config/bspwm/bspwmrc
sudo rm -rf ~/.config/dunst/dunstrc
sudo rm -rf ~/.config/nitrogen/nitrogen.cfg
sudo rm -rf ~/.config/picom/picom.conf
sudo rm -rf ~/.config/polybar/config.ini
sudo rm -rf ~/.config/sxhkd/sxhkdrc
