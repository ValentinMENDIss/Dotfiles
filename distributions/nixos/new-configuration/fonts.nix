{ config, pkgs, ... }:

{
  fonts = {
    packages = with pkgs; [
      (nerdfonts.override { fonts = [ "FiraCode" "DroidSansMono" ]; })
      font-awesome
      roboto
      helvetica-neue-lt-std
    ];
  };
}

