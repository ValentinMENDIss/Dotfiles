{ pkgs, ... }:

{
  imports =
    [ 
      ./hardware-configuration.nix
      ../../nixosModules/default.nix
    ];

  # Choosing Linux Kernel
  boot.kernelPackages = pkgs.linuxPackages;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  system.autoUpgrade.enable = true;

  nix = {
    settings.auto-optimise-store = true;
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };

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

  time.timeZone = "Europe/Berlin";

  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "de_DE.UTF-8";
    LC_IDENTIFICATION = "de_DE.UTF-8";
    LC_MEASUREMENT = "de_DE.UTF-8";
    LC_MONETARY = "de_DE.UTF-8";
    LC_NAME = "de_DE.UTF-8";
    LC_NUMERIC = "de_DE.UTF-8";
    LC_PAPER = "de_DE.UTF-8";
    LC_TELEPHONE = "de_DE.UTF-8";
    LC_TIME = "de_DE.UTF-8";
  };

  services.xserver.enable = true;

  services.desktopManager.plasma6.enable = true;
  
  services.libinput = {
    enable = true;
    
    mouse = {
      accelProfile = "flat";
    };
    
    touchpad = {
      clickMethod = "clickfinger";
      tapping = false;
    };

  };

  services.flatpak.enable = true;

  services.sysc-greet = {
    enable = true;
    compositor = "niri";
  };

  # Ensures that the "greeter" user has permission to use video devices
  users.extraUsers.greeter.extraGroups = [ "video" "input" ];

  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  services.printing.enable = true;

  users.users.mendiss = {
    isNormalUser = true;
    description = "mendiss";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
    shell = pkgs.zsh;
    packages = with pkgs; [
    ];
  };

  fonts.packages = with pkgs; [
    comfortaa
    helvetica-neue-lt-std
    scientifica
  ];

  virtualisation.docker.enable = true;

  powerManagement.cpuFreqGovernor = "performance";

  programs.xwayland.enable = true;

  programs.gamemode.enable = true;

  programs.zsh.enable = true;

  security.rtkit.enable = true;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
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

  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
    config.common.default = "*";
    extraPortals = [ pkgs.xdg-desktop-portal-gtk pkgs.xdg-desktop-portal-wlr ];
  };
  # Enable Wayland support for Electron and Chromium applications
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  stylix.enable = true;

  stylix.image = pkgs.fetchurl {
    url = "https://w.wallhaven.cc/full/21/wallhaven-213edy.png";
    hash = "sha256-5fnOaB4ozW49gJFGZKpVfGMTo8EaFTPT4b6EIr4lcKA=";
  };

  stylix.polarity = "dark";

  # Enabling custom Modules for the Device(packages with configurations)
  mendiss.modules.emacs.enable = true;
  mendiss.modules.steam.enable = true;

  nixpkgs.config.allowUnfree = true;

  system.stateVersion = "25.11";

}

