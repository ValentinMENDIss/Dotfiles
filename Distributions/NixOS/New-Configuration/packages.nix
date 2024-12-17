{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
	
    # CLI-Tools
    neovim     
    wget
    git
    uwuify
    uwufetch
    btop
    bat
    pipes
    unzip
    yazi
    cmatrix
    cowsay
    appimage-run

    # Graphical Applications
    librewolf
    vscodium
    kitty
    sioyek
    vlc
    dia
    godot_4
    jetbrains.pycharm-community

    # WM Apps # 
    wofi
    waybar
    swww
    dunst
    hyprlock
    hypridle
    brightnessctl
    windowmaker

    # Programming
    python3		# needed in order to python be accessible without network connection :3
    gcc    
  ];
}
