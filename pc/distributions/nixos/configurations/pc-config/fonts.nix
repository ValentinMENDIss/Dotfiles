{ config, pkgs, ... }:

{
  fonts = {
    packages = with pkgs; [
      nerd-fonts.jetbrains-mono
      inter
    ];
    fontconfig = {
      defaultFonts = {
	sansSerif = [ "Inter" ];
	monospace = [ "nerd-fonts.jetbrains-mono" ];
      };
    };
  };
}

