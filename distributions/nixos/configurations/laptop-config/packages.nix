{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
	
    # CLI-Tools
    neovim     				# text editor
    wget	
    git					
    uwuify				# uwuify text :3
    uwufetch				# system/hardware info application (fetch program)
    btop				# task manager
    bat					# cat - but prettier syntax
    pipes				# cool screensaver :D
    unzip				# unzipper for zip files
    yazi				# terminal explorer
    cmatrix
    cowsay				
    appimage-run			# script for running appimages on nixos
    ascii-image-converter

    # Graphical Applications
    librewolf				# browser for privacy
    vscodium				# ide for programming
    kitty				# terminal (tty emulator)
    sioyek				# pdf viewer
    vlc					# video player
    dia					# diagram utility
    godot_4				# game engine
    flameshot				# screenshot utility
    obsidian
    tiled
    ghostty
    onlyoffice-desktopeditors
    localsend

    # WM Apps # 
    wofi				# app launcher
    waybar				# taskbar
    swww				# wallpaper utility
    dunst				# notification daemon
    hyprlock				# lock screen
    hypridle				# idle 
    hyprsome				# managing multiple monitors for hyprland in the nix way
    wlogout
    brightnessctl			# configure brightness of the screen (for laptops)
    windowmaker				# old-style window manager
    nitrogen
    picom
    polybar
    rofi
    sxhkd

    # Programming
    python3				# needed in order to python be accessible without network connection :3
    gcc    				# compiler for C programming language
    #nodePackages.nodejs

    # Gaming :3
    prismlauncher
  ];
}
