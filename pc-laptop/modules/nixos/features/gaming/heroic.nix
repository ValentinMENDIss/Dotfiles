{pkgs, lib, config, ...}:
{
  options.mendiss.modules.gaming.packages = {
    heroic = {
      enable = lib.mkEnableOption "Enables Heroic Games Launcher";
    };
  };

  config = lib.mkIf config.mendiss.modules.gaming.packages.heroic.enable {
    environment.systemPackages = with pkgs; [
      (heroic.override {
        extraPkgs = pkgs': with pkgs'; [
          gamescope
          gamemode
        ];
      })
    ];
  };

}
