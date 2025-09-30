{ config, pkgs, lib, ... }:
let 
  cfg = config.homelab;
in {
  options.homelab = {
    # declaring user as an option (not hardcoded/changeable inside config file of nixos)
    user = lib.mkOption {
      type = lib.types.str;
      default = "media";
      description = "Primary user for homelab services";
    };
    
    # declaring group as an option (not hardcoded/changeable inside config file of nixos)
    group = lib.mkOption {
      type = lib.types.str;
      default = "media";
      description = "Primary group for homelab user/services";
    };
  };

  config = lib.mkIf (cfg.user != null && cfg.group != null) {
    users.users = {
      # Use the user name from homelab.user option
      "${cfg.user}" = {
	# option/s which is configurable inside config file of nixos
        group = cfg.group;
	# hardcoded options, which means that they aren't changeable inside config file of nixos and are applied as they are here
        isSystemUser = true;
        extraGroups = [ "video" "render" "pihole" ];
        shell = "/bin/bash";
        home = "/var/lib/media";
        createHome = true;
      };
    };
  };
}
