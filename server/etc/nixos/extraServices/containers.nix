{ config, pkgs, ... }:
{
  virtualisation.oci-containers = {
    backend = "podman";
    containers = {
      Homepage = {
        autoStart = true;
        image = "ghcr.io/gethomepage/homepage:latest";
        extraOptions = [ "-e HOMEPAGE_ALLOWED_HOSTS=<your-server-ip>:3000" "--net=host" ];
        ports = [
          "3000:3000"
        ];
        volumes = [
          "/home/<your-server-user-name>/.config/homepage-dashboard/config:/app/config"
          "/home/<your-server-user-name>/.config/homepage-dashboard/icons:/app/public/icons"
        ];
      };
      PiHole = {
        autoStart = true;
        image = "docker.io/pihole/pihole:latest";
        ports = [
        #  # DNS Ports
          "53:53/tcp"
          "53:53/udp"
        #  # Default HTTP Port
          "80:80/tcp"
        #  # Default HTTPs Port. FTL will generate a self-signed certificate
          "443:443/tcp"
        #  # Uncomment the line below if you are using Pi-hole as your DHCP server
        #  #- "67:67/udp"
        #  # Uncomment the line below if you are using Pi-hole as your NTP server
        #  #- "123:123/udp"
        ];
#       extraOptions = [ "--restart=unless-stopped" ];
        environment = {
          TZ = "<your-timezone>"; # e.g: "Europe/Berlin"
          FTLCONF_webserver_api_password = "<your-password>";
          FTLCONF_dns_listeningMode = "all";
        };
        volumes = [
          "/home/<your-server-user-name>/.config/pihole:/etc/pihole"
        ];
      };
    };
  };
}
