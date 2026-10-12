{ pkgs, ... }: 

{
  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true; # Optional

    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-gnome
      pkgs.kdePackages.xdg-desktop-portal-kde
    ];

    config = {
      common.default = [ "gtk" ];
      kde.default = [ "kde" "gtk" ];
    };
  };
}
