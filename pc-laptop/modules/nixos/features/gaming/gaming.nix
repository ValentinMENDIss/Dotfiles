{ lib, config, ... }:
{
  options.mendiss.modules.gaming = {
      setup = {
        enable = lib.mkEnableOption "Sets up Environment for Gaming on NixOS";
      };
    };

  config = lib.mkIf config.mendiss.modules.gaming.setup.enable {
    programs = {
      gamescope = {
        enable = false;
        capSysNice = false; # error in NixOS, where bubblewrap tries to use setuid; once the error will be gone, enable this
      };
    
      gamemode = {
        enable = true;
      };
    };
  };
  
}
