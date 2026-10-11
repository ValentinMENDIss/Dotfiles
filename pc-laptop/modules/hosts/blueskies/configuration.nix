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

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

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
    hostName = "blueskies";
    networkmanager.enable = true;
    firewall = {
      enable = true;
      # 53317 = LocalSend
      allowedTCPPorts = [ 53317 ];
      allowedUDPPorts = [ 53317 ];
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

  services = {
    displayManager.sessionPackages = [ pkgs.niri ];

    xserver.videoDrivers = ["nvidia"];

    desktopManager.plasma6.enable = true;

    displayManager.sddm = {
      enable = true;
      wayland.enable = true;
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

  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    plasma-browser-integration
    konsole
    elisa
    okular
    kate
    khelpcenter
    spectacle
  ];

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

    niri.enable = true;

    xwayland.enable = true;

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

  security.rtkit.enable = true;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
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

  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true; # Optional

    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-gnome
      pkgs.kdePackages.xdg-desktop-portal-kde
    ];

    config = {
      common.default = [ "gtk" ];

      niri = {
        default = [ "gtk" ];
        "org.freedesktop.impl.portal.FileChooser" = "gtk";
        "org.freedesktop.impl.portal.ScreenCast" = "gnome";
      };

      kde.default = [ "kde" "gtk" ];
    };
  };

  environment.sessionVariables = {
    LIBVA_DRIVER_NAME = "nvidia";
    NIXOS_OZONE_WL = "1";
  };

  stylix.enable = true;

  stylix.targets.plymouth.enable = false;

  stylix.image = pkgs.fetchurl {
    url = "https://live.staticflickr.com/65535/55582885743_d51ff8f4ae_b.jpg";
    hash = "sha256-o0dmivQJURcdKZvtCEp5m8ZCTp7dCt7rG6Ub3WIvAMw=";
  };

  stylix.polarity = "dark";

  # needed for GTK4 apps to apply custom cursor themes
  programs.dconf.enable = true;

  # Enabling custom Modules for the Device(packages with configurations)
  mendiss.modules.emacs.enable = true;
  mendiss.modules.steam.enable = true;
  mendiss.modules.heroic.enable = true;

  nixpkgs.config.allowUnfree = true;

  system.stateVersion = "25.11";

}
