{unstable, pkgs, lib, config, ...}:
{
  options.mendiss.modules = {
    threeDPrinting = {
      enable = lib.mkEnableOption "Installs Packages for 3D-Modelling and 3D-Printing";
    };
  };

  config = lib.mkIf config.mendiss.modules.threeDPrinting.enable {
    environment.systemPackages = [
      unstable.orca-slicer    
      pkgs.freecad
    ];
  };
}
