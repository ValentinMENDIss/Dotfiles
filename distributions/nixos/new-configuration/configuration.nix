#      _______      ,-----.    ,---.   .--. ________ .-./`)   .-_'''-.    
#     /   __  \   .'  .-,  '.  |    \  |  ||        |\ .-.') '_( )_   \   
#    | ,_/  \__) / ,-.|  \ _ \ |  ,  \ |  ||   .----'/ `-' \|(_ o _)|  '  
#  ,-./  )      ;  \  '_ /  | :|  |\_ \|  ||  _|____  `-'`"`. (_,_)/___|  
#  \  '_ '`)    |  _`,/ \ _/  ||  _( )_\  ||_( )_   | .---. |  |  .-----. 
#   > (_)  )  __: (  '\_/ \   ;| (_ o _)  |(_ o._)__| |   | '  \  '-   .' 
#  (  .  .-'_/  )\ `"/  \  ) / |  (_,_)\  ||(_,_)     |   |  \  `-'`   |  
#   `-'`-'     /  '. \_/``".'  |  |    |  ||   |      |   |   \        /  
#     `._____.'     '-----'    '--'    '--''---'      '---'    `'-...-'   
#
#
#	Author:         ValentinMENDIss (Github)
#	Last Update:    27.11.2024



{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./fonts.nix
      ./packages.nix
    ];


  # Sudo Editor
  environment.variables = {
    SUDO_EDITOR = "nvim";
  };

  # Turning on Experimental Features
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  

  # Turning on System Auto-Upgrade
  system.autoUpgrade.enable = true;

  # Configuring Nix Package-Manager
  nix = {
    # automatically collect garbage ( and delete old "snapshots")
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 30d";
    };
  };

  # Use the systemd-boot EFI boot loader.
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  networking.hostName = "nixuwu"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Amsterdam";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "nl_NL.UTF-8";
    LC_IDENTIFICATION = "nl_NL.UTF-8";
    LC_MEASUREMENT = "nl_NL.UTF-8";
    LC_MONETARY = "nl_NL.UTF-8";
    LC_NAME = "nl_NL.UTF-8";
    LC_NUMERIC = "nl_NL.UTF-8";
    LC_PAPER = "nl_NL.UTF-8";
    LC_TELEPHONE = "nl_NL.UTF-8";
    LC_TIME = "nl_NL.UTF-8";
  };

  # Enable the X11 windowing system.
  # You can disable this if you're only using the Wayland session.
  services = {
  # enable touchpad support
  libinput.enable = true;		
  xserver = {
    enable = true;
    xkb.layout = "us";
    xkb.variant = "";
    # enable BSPWM tiling window manager
    windowManager.bspwm.enable = true;
  };
    };


  # Enable the KDE Plasma Desktop Environment.
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;
  # Enable Hyprland
  programs.hyprland.enable = true;

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;
 };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.mendi = {
    isNormalUser = true;
    description = "mendi";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      kdePackages.kate
    #  thunderbird
    ];
  };

  services.xserver = {
    windowManager.windowmaker.enable = true;
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget


  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  system.stateVersion = "24.11"; 
}
