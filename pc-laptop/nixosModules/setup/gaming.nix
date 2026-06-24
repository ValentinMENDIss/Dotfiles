{ ... }:
{
  programs = {
    gamescope = {
      enable = false;
      capSysNice = false; # error in NixOS, where bubblewrap tries to use setuid; once the error will be gone, enable this
    };
    
    gamemode = {
      enable = true;
    };
  };
}
