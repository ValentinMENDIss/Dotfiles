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
    vesktop
    nautilus
    firefox
    chromium
    feishin
    zathura

    ## 3D Printing
    freecad
    orca-slicer

    ## Programming
    clang
    clang-tools
    docker
    docker-compose

    ## Gaming :3
    prismlauncher
  ];
}

