{ pkgs, lib, config, ... }:
{
  options.mendiss.modules.gaming.packages = {
      minecraft = {
        enable = lib.mkEnableOption "Installs Minecraft (Game)";
      };
    };

  config = lib.mkIf config.mendiss.modules.gaming.packages.minecraft.enable {


    environment.systemPackages = with pkgs; [
      prismlauncher
    ];
  };

}
