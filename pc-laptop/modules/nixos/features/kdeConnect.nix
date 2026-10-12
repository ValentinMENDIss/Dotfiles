{ lib, config, ... }:
{
  options.mendiss.modules = {
    kdeConnect = {
      enable = lib.mkEnableOption "Enables KDE Connect Module";
    };
  };

  config = lib.mkIf config.mendiss.modules.kdeConnect.enable {

    programs.kdeconnect.enable = true;

    networking.firewall = rec {
      allowedTCPPortRanges = [{ from = 1714; to = 1764; }];
      allowedUDPPortRanges = allowedTCPPortRanges;
    };
  };
}
