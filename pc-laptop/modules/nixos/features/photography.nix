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
      # probably will remove later; (tried to use for fun :D)
      pkgs.lightcraft

      # raw image editor based on rawtherapee
      pkgs.art
      # catalog for / viewer of images
      pkgs.digikam
    ];
  };

}
