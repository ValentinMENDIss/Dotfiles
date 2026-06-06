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
    
    # Graphical Applications
    vlc
    obsidian
    localsend
    nextcloud-client
    vesktop
    kdePackages.dolphin
    firefox

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

