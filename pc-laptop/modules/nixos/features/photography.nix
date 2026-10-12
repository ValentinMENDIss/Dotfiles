{ inputs, pkgs, lib, config, ... }:

{
  options.mendiss.modules = {
    photography = {
      enable = lib.mkEnableOption "Installs Photography related packages";
    };
  };

  config = lib.mkIf config.mendiss.modules.photography.enable {
    nixpkgs.overlays = [ inputs.lightcraft.overlays.default ];

    environment.systemPackages = [
      pkgs.geeqie
      pkgs.rawtherapee
      pkgs.lightcraft
    ];
  };

}
