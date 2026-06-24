{pkgs, lib, config, ...}:
{
  options.mendiss.modules = {
    heroic = {
      enable = lib.mkEnableOption "Enables Heroic Games Launcher";
    };
  };

  config = lib.mkIf config.mendiss.modules.heroic.enable {
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
