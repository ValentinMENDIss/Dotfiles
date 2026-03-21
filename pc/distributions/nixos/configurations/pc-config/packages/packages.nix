{ config, pkgs, ... }:

{

  imports =
  [
    ./hyprland-setup.nix
  ];

  environment.systemPackages = with pkgs; [
    # CLI-Tools
    neovim
    wget
    git
    btop
    bat
    unzip
    yazi
    appimage-run
    
    # Graphical Applications
    vlc
    flameshot
    obsidian
    ghostty
    kitty
    localsend
    logseq
    nextcloud-client

    # Programming
    godot
    zed-editor
    clang
    clang-tools

    # Gaming :3
    prismlauncher

    waywall

  ];
}

