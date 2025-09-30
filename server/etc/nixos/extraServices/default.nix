{ config, lib, pkgs, ... }:
{
  imports =
  [
    ./containers.nix
  ];

  # Enable services to which are enable options created
  virtualisation.podman.enable = true;
}
