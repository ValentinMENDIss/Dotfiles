{ config, pkgs, ... }:

{
  imports =
    [ 
      ./hardware-configuration.nix
      ./packages/packages.nix
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

  services.xserver = {
    enable = true;

  xkb = {
    layout = "us";
    variant = "";
  };

  windowManager.windowmaker.enable = true;
  displayManager.startx.enable = true;
  };

  services.flatpak.enable = true;

  services.sysc-greet = {
    enable = true;
    compositor = "niri";
  };

  # Ensures that the "greeter" user has permission to use video devices
  users.extraUsers.greeter.extraGroups = [ "video" "input" ];

  services.printing.enable = true;

  users.users.mendiss = {
    isNormalUser = true;
    description = "mendiss";
    extraGroups = [ "networkmanager" "wheel" "docker" "gamemode" ];
    shell = pkgs.zsh;
    packages = with pkgs; [
    ];
  };

  virtualisation.docker.enable = true;

  powerManagement.cpuFreqGovernor = "performance";

  programs = {
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

    hyprland = {
      enable = true;
      withUWSM = true; # recommended for most users
      xwayland.enable = true; # Xwayland can be disabled.
    };

  };

  security.rtkit.enable = true;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  services.xserver.videoDrivers = ["nvidia"];

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
      xdgOpenUsePortal = true;
      extraPortals = [ 
        pkgs.xdg-desktop-portal-gtk 
        pkgs.xdg-desktop-portal-gnome 
      ];
      config.niri = {
        default = [
          "gnome"
          "gtk"
        ];
        "org.freedesktop.impl.portal.FileChooser" = "gtk";
        "org.freedesktop.impl.portal.ScreenCast" = "gnome";
        "org.freedesktop.impl.portal.Screenshot" = "gnome";
    };
  };

  environment.sessionVariables = {
    LIBVA_DRIVER_NAME = "nvidia";
    NIXOS_OZONE_WL = "1";
  };

  stylix.enable = true;

  stylix.image = pkgs.fetchurl {
    url = "https://w.wallhaven.cc/full/21/wallhaven-213edy.png";
    hash = "sha256-5fnOaB4ozW49gJFGZKpVfGMTo8EaFTPT4b6EIr4lcKA=";
  };

  stylix.polarity = "dark";

  # Enabling custom Modules for the Device(packages with configurations)
  mendiss.modules.emacs.enable = true;
  mendiss.modules.steam.enable = true;
  mendiss.modules.heroic.enable = true;

  nixpkgs.config.allowUnfree = true;

  system.stateVersion = "25.11";

}
