{ pkgs, ... }:

{
  programs.hyprland = {
    enable = true;
    withUWSM = true;
  };

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };

  environment.systemPackages = with pkgs; [
    hyprpaper # wallpaper setter
    waybar    # bar
    wofi      # app launcher
    dunst     # notification daemon
    ags       # widget system
    hyprshot  # screenshot utility
  ];
}
