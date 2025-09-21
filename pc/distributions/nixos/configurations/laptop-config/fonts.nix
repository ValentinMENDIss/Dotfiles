{ config, pkgs, ... }:

{
  fonts = {
    packages = with pkgs; [
      (nerdfonts.override { fonts = [ "FiraCode" "DroidSansMono" ]; })
      font-awesome
      roboto
      helvetica-neue-lt-std
      gyre-fonts
      libertinus
      inconsolata
    ];
    fontconfig = {
      defaultFonts = {
        serif = ["Libertinus Serif"];
        sansSerif = ["gyre-fonts"];
	monospace = ["inconsolata"];
      };
    };
  };


}
