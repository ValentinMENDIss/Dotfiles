{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    neovim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    git
    librewolf
    uwuify
    uwufetch
    btop
    bat
    vscodium
    kitty
    wofi
    waybar
    swww
    dunst
    pipes
    unzip
    ranger
    vlc
    sioyek
    cmatrix
    cowsay
    dia
  ];
}
