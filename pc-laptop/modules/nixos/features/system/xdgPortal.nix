{ pkgs, ... }: 

{
  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true; # Optional.
    wlr.enable = true; # required for screenshot and screen-share functionality to work properly as it provides those interfaces for wlroots based wayland compositors.

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
