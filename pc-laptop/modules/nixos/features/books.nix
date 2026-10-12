{ pkgs, lib, config, ... }:
{
  options.mendiss.modules = {
    books = {
      enable = lib.mkEnableOption "Installs Packages for reading and viewing Book formats";
    };
  };

  config = lib.mkIf config.mendiss.modules.books.enable {
    environment.systemPackages = [
      pkgs.zathura
      pkgs.calibre
    ];
  };
}
