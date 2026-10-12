{ inputs, pkgs, ... }:

{
  services = {
    displayManager.sessionPackages = [ pkgs.niri ];

    desktopManager.plasma6.enable = true;

    displayManager.sddm = {
      enable = true;
      wayland.enable = true;
    };
  };

  programs = {
    niri.enable = true;

    xwayland.enable = true;
  };  
  
  imports = [inputs.silentSDDM.nixosModules.default];
  programs.silentSDDM = {
    enable = true;
    theme = "default";
  };

  environment = {
    plasma6.excludePackages = with pkgs.kdePackages; [
      plasma-browser-integration
      konsole
      elisa
      okular
      kate
      khelpcenter
      spectacle
    ];

    # Enable Wayland support for Electron and Chromium applications
    sessionVariables.NIXOS_OZONE_WL = "1";

  };

}
