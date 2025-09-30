{ config, lib, pkgs, ... }:
{
  imports = 
    [ 
      ./nextcloud/default.nix
    ];

  services.tailscale.enable = true;
}
