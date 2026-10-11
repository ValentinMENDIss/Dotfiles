{ inputs, pkgs, ... }:

{
  nixpkgs.overlays = [ inputs.lightcraft.overlays.default ];
  environment.systemPackages = [ pkgs.lightcraft ];
}

