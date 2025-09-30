{ config, lib, pkgs, ... }:
with lib; let
  cfg = config.virtualisation.podman; 
in {
  # create enable option for outside of the file
  options.virtualisation.podman.enable = mkEnableOption "enable podman";

  # execute if service is enabled
  config = mkIf cfg.enable {
    virtualisation = {
      podman = {
        enable = true;
        dockerCompat = true; # enable docker compatibility
        # auto-remove all unused containers
        autoPrune = {
          enable = true;
          dates = "weekly";
          flags = [
            "--filter=until=24h"
          ];
        };
      };
    };
  };
}
