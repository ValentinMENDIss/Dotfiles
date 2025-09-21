{ config, lib, pkgs, ... }:
{
  # Enable services to which are enable options created
  virtualisation.podman.enable = true;
}
