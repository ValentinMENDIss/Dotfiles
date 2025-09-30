{ config, lib, pkgs, ... }:
{
  environment.etc."nextcloud-admin-pass".text = "<your-password>";
  users.users.nextcloud.extraGroups = ["users"];

  services.nextcloud = {
    enable = true;
    package = pkgs.nextcloud31;

    hostName = "nextcloud.localhost"; 
    autoUpdateApps.enable = true;
    home = "/var/lib/nextcloud";

    database.createLocally = true;
    # performant caching backend
    configureRedis = true;
    caching = {
      redis = true;
    };
    maxUploadSize = "50G";

    # error thrown unless specified
    settings = {
      default_phone_region = "DE";
      mail_smtpmode = "sendmail";
      mail_sendmailmode = "pipe";
      trusted_domains = [ "<your-server-ip-address>" ];
    };

    config = {
      adminuser = "mendi";
      adminpassFile = "/etc/nextcloud-pass/nextcloud-admin-pass";
      dbtype = "sqlite";
      dbuser = "nextcloud";
      dbname = "nextcloud";
    };
  };

  services.nginx.virtualHosts."${config.services.nextcloud.hostName}" = {
    listen = [
      { addr = "0.0.0.0"; port = 8080; }
    ];
  };
}
