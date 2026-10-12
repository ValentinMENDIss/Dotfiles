{ pkgs, lib, config, ... }:
{
  options.mendiss.modules.programming = {
    tools = {
      enable = lib.mkEnableOption "Installs programming tools";
    };
  };

  config = lib.mkIf config.mendiss.modules.programming.tools.enable {
    environment.systemPackages = with pkgs; [
      clang
      clang-tools
      docker
      docker-compose
      android-tools
    ];
  };

}
