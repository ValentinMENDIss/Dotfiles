{ config, lib, pkgs, ... }:
let
  service = "tailscale";
  cfg = config.services.${service};
in {
  options.services.${service} = {
    enable = lib.mkEnableOption {
      description = "Enable ${service}";
    };
  };
  config = lib.mkIf cfg.enable {
    services.${service} = {
      enable = true;
      port = 41641;
      openFirewall = true;
      interfaceName = "tailscale0";
      authKeyFile = "/run/secrets/tailscale_key";
    };
  };
}
