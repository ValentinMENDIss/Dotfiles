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

