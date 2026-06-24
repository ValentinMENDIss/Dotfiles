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
    vlc
    obsidian
    localsend
    nextcloud-client
    discord
    kdePackages.dolphin
    firefox
    
    zathura
    libreoffice

    ## 3D Printing
    freecad
    orca-slicer

    ## Programming
    godot
    clang
    clang-tools
    docker
    docker-compose

    ## Gaming :3
    prismlauncher
  ];
}

