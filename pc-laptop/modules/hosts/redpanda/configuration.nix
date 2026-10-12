{ pkgs, ... }:

{
  imports =
    [ 
      ./hardware-configuration.nix
      ../../nixos/features/default.nix
    ];

  # Choosing Linux Kernel
  boot.kernelPackages = pkgs.linuxPackages;

  boot.initrd.kernelModules = [ "i915" ];

  security.sudo.enable = true;

  boot.loader.limine.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking = {
    hostName = "redpanda";
    networkmanager.enable = true;
    firewall = {
      enable = true;
      # 53317 = LocalSend; # [ 8889 8890 11111 ] = djitellopy
      allowedTCPPorts = [ 53317 ];
      allowedUDPPorts = [ 53317 8889 8890 11111 ];
    };
  };

  services = {
    libinput = {
      enable = true;
    
      mouse = {
        accelProfile = "flat";
      };
   
      touchpad = {
        clickMethod = "clickfinger";
        tapping = false;
      };
    };

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


  # Ensures that the "greeter" user has permission to use video devices
  users.extraUsers.greeter.extraGroups = [ "video" "input" ];

  users.users.mendiss = {
    isNormalUser = true;
    description = "mendiss";
    extraGroups = [ "networkmanager" "wheel" "docker" "dialout" "adbusers" ];
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

  services.xserver.videoDrivers = [ "modesetting" ];

  hardware = {
    cpu = {
      intel.updateMicrocode = true;
    };

    graphics = {
      enable = true;
      enable32Bit = true;
    };
    
    bluetooth = {
      enable = true;
      powerOnBoot = true;
      settings = {
        General = {
        # Shows battery charge of connected devices on supported
        # Bluetooth adapters. Defaults to 'false'.
        Experimental = true;
        # When enabled other devices can connect faster to us, however
        # the tradeoff is increased power consumption. Defaults to
        # 'false'.
        FastConnectable = true;
      };
      Policy = {
        # Enable all controllers when they are found. This includes
        # adapters present on start as well as adapters that are plugged
        # in later on. Defaults to 'true'.
        AutoEnable = true;
      };
      };
    };

  };

  stylix.enable = true;

  stylix.targets.plymouth.enable = false;

  stylix.image = pkgs.fetchurl {
    url = "https://w.wallhaven.cc/full/21/wallhaven-213edy.png";
    hash = "sha256-5fnOaB4ozW49gJFGZKpVfGMTo8EaFTPT4b6EIr4lcKA=";
  };

  stylix.polarity = "dark";

   # needed for GTK4 apps to apply custom cursor themes
  programs.dconf.enable = true;

  # Enabling custom Modules for the Device(packages with configurations)
  mendiss.modules = {
    gaming = {
      setup.enable = false; 
      packages = {
        steam.enable = true;
        heroic.enable = false;
        minecraft.enable = false;
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

