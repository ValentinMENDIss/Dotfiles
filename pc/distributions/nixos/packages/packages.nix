{ config, pkgs, inputs, ... }:

{

  imports =
  [
    ./emacs-setup.nix
    ./steam.nix
  ];

  environment.systemPackages = with pkgs; [
    # CLI-Tools
    neovim
    yazi
    btop
    bat
    git
    wget
    unzip
    appimage-run
    
    # Graphical Applications
    vlc
    obsidian
    foot
    localsend
    nextcloud-client
    vesktop

    ## 3D Printing
    freecad
    orca-slicer

    ## Programming
    godot
    clang
    clang-tools

    ## Gaming :3
    prismlauncher
  ];
}

