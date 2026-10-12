{ config, pkgs, ... }:

{
  imports =
    [ 
      ./hardware-configuration.nix
      ../../nixos/features/default.nix
    ];

  # Choosing Linux Kernel
  boot.kernelPackages = pkgs.linuxPackages;

  zramSwap = {
    enable = true;
    memoryPercent = 75;
  };

  boot.kernel.sysctl = {
    "vm.swappiness" = 10;
  };

  security.sudo.enable = true;

  boot.loader.limine.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking = {
    hostName = "blueskies";
    networkmanager.enable = true;
    firewall = {
      enable = true;
      # 53317 = LocalSend
      allowedTCPPorts = [ 53317 ];
      allowedUDPPorts = [ 53317 ];
    };
  };

  services = {
    xserver.videoDrivers = ["nvidia"];

    # Auto-Mount Drrives (e.g. USB Drives)
    udisks2.enable = true;

    flatpak.enable = true;

    printing = {
     enable = true;
     drivers = with pkgs; [
       cups-filters
       cups-browsed
       hplipWithPlugin
     ];
    };

    # Provides support for auto internet discovery of printers on the network
    avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
    };
  };

  users.users.mendiss = {
    isNormalUser = true;
    description = "mendiss";
    extraGroups = [ "networkmanager" "wheel" "docker" "gamemode" "lpadmin" "dialout" "adbusers" ];
    shell = pkgs.zsh;
  };

  virtualisation.docker.enable = false;

  powerManagement.cpuFreqGovernor = "performance";

  programs = {
    nix-ld = {
      enable = true;
      libraries = with pkgs; [
        stdenv.cc.cc
      ];
    };

    gamemode.enable = true;

    appimage.enable = true;
    appimage.binfmt = true;
    appimage.package = pkgs.appimage-run.override {
      extraPkgs = pkgs: [ 
        pkgs.gnutls 
        pkgs.nettle
      ];
    };

    zsh.enable = true;

  };

  hardware = {
    cpu = {
      intel.updateMicrocode = true;
    };

    graphics = {
      enable = true;
      enable32Bit = true;
    };

    nvidia = {
      
      # Modesetting is required.
      modesetting.enable = true;

      powerManagement.enable = false;
      powerManagement.finegrained = false;

      open = false;

      # Enable the Nvidia settings menu,
      # accessible via `nvidia-settings`.
      nvidiaSettings = true;

      package = config.boot.kernelPackages.nvidiaPackages.stable;
    };
  };

  # needed for my VIA-compatible keyboard to be able to have permissions to change the config via VIA webui
  services.udev.extraRules = ''
    SUBSYSTEM=="hidraw", ATTRS{idVendor}=="19f5", ATTRS{idProduct}=="32f5", MODE="0660", TAG+="uaccess"
  '';

  environment.sessionVariables = {
    LIBVA_DRIVER_NAME = "nvidia";
    NIXOS_OZONE_WL = "1";
  };

  stylix.enable = true;

  stylix.targets.plymouth.enable = false;

  stylix.image = pkgs.fetchurl {
    name = "wallpaper.png";
    url = "https://www.flickr.com/photo_download.gne?size=o&id=55582885743&secret=d852d5e115";
    hash = "sha256-xtkQ7ZZd+fHBFf5gxQgqZKO7ABboJo5ooOzWaxxkIYs=";
  };

  stylix.polarity = "dark";

  # needed for GTK4 apps to apply custom cursor themes
  programs.dconf.enable = true;

  # Enabling custom Modules for the Device(packages with configurations)
  mendiss.modules = {
    gaming = {
      setup.enable = true; 
      packages = {
        steam.enable = true;
        heroic.enable = true;
        minecraft.enable = true;
      };
    };

    programming = {
      emacs.enable = true;
      tools.enable = true;
    };

    books.enable = true;
    kdeConnect.enable = true;
    threeDPrinting.enable = true;
    photography.enable = true;

  };

  nixpkgs.config.allowUnfree = true;

  system.stateVersion = "25.11";

}
