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
    
    # Graphical Applications
    brave
    obsidian
    vesktop
    vlc
    localsend
    nextcloud-client
    nautilus
    feishin
    zathura
    thunderbird
    libresprite
  ];
}

