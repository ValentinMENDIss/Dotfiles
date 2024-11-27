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
    ranger
    cmatrix
    cowsay

    # Graphical Applications
    librewolf
    vscodium
    kitty
    sioyek
    vlc
    dia

    # WM Apps # 
    wofi
    waybar
    swww
    dunst
    hyprlock
    hypridle
    brightnessctl

  ];
}
