{ lib, config, ... }:
{
  options.mendiss.modules = {
    steam = {
      enable = lib.mkEnableOption "Enables Steam Module";
    };
  };

  config = lib.mkIf config.mendiss.modules.steam.enable {
    programs = {
      gamescope = {
        enable = true;
        capSysNice = true;
      };

      steam = {
        enable = true;
	gamescopeSession.enable = true;
    	dedicatedServer.openFirewall = true;
    	localNetworkGameTransfers.openFirewall = true;
      };
    };
  };

}
