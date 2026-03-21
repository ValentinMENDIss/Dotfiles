{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./fonts.nix
      ./packages/packages.nix
    ];

  # Choosing Linux Kernel
  boot.kernelPackages = pkgs.linuxPackages;

  # Turning on Experimental Features
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Turning on System Auto-Upgrade
  system.autoUpgrade.enable = true;

  # Configuring Nix Package-Manager
  nix = {
    # Optimising nix store
    settings.auto-optimise-store = true;
    # Automatically collect garbage ( and delete old "snapshots")
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };

  security.doas.enable = true;
  security.doas.extraRules = [{
    users = ["mendiss"];
    # retains environment variables while running commands
    keepEnv = true;
    # only require password verification a single time
    persist = true;
  }];
  security.sudo.enable = false;

  # Bootloader.
  boot.loader.limine.enable = true;
  #boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "BlueSkies"; # Define your hostname.

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Berlin";

  # Select internationalisation properties.
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

  # Enable the X11 windowing system.
  # You can disable this if you're only using the Wayland session.
  services.xserver.enable = true;

  services.flatpak.enable = true;

  # Enable the KDE Plasma Desktop Environment.
  services.displayManager.sddm.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  users.users.mendiss = {
    isNormalUser = true;
    description = "mendiss";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
    ];
  };

  # Install firefox.
  programs.firefox.enable = true;

  powerManagement.cpuFreqGovernor = "performance";

  programs.gamemode.enable = true;

  # Load nvidia driver for Xorg and Wayland
  services.xserver.videoDrivers = ["nvidia"];

  hardware = {
    # Enable auto-update of intel's microcode for intel processors
    cpu = {
      intel.updateMicrocode = true;
    };

    # Enable OpenGL
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

      # Optionally, you may need to select the appropriate driver version for your specific GPU.
      package = config.boot.kernelPackages.nvidiaPackages.stable;
    };

  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  system.stateVersion = "25.11"; # Did you read the comment?

}
