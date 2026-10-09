{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # CLI-Tools
    neovim
    yazi
    bat
    git
    wget
    unzip
    appimage-run
    fastfetch
    grim

    wine
    winetricks
    
    # Graphical Applications
    obsidian
    vesktop
    vlc
    localsend
    nextcloud-client
    feishin
    thunderbird
    libresprite
    libreoffice

    kdePackages.dolphin
    kdePackages.qtsvg

    lutris
  ];
}

