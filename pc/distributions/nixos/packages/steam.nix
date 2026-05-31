{ pkgs, ... }:
{
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
}
