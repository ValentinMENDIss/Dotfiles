{ config, lib, pkgs, ... }:

{
  imports =
    [ 
      ./hardware-configuration.nix
    ];

  # Sudo Editor
  environment.variables = {
	SUDO_EDITOR = "nvim";
  };

  # Bootloader.
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";
  boot.loader.grub.useOSProber = true;

  # Choosing Kernel version
  boot.kernelPackages = pkgs.linuxPackages;


  networking.hostName = "nixos"; # Define your hostname.
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
  services.xserver = {
    enable = true;
    #autorun = false;
    #xkb.layout = "us";
    #xkb.options = "eurosign:e";
    # Enable the Gnome Desktop Environment.
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
    # Enable the BSPWM Tiling Manager.
    windowManager.bspwm.enable = true;

    # Load nvidia driver for Xorg and Wayland
    videoDrivers = [ "nvidia" "intel" ];
  };

  #services.displayManager.defaultSession = "none+bspwm";
  
  # Configure console keymap
  console.keyMap = "uk";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pulseaudio.
  hardware.pulseaudio.enable = true;
  hardware.pulseaudio.support32Bit = true;

  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput.enable = true;

  # Video support
  hardware = {
    opengl = {
      enable = true;
      driSupport32Bit = true;
      driSupport = true;
    };
  };

  # Nvidia drivers/settings
  hardware.nvidia = {
    
    # Modesetting is required
    modesetting.enable = true;

    # Use the Nvidia open source kernel module
    open = false;

    # Enable the Nvidia settings menu,
    # accessible via 'nvidia-settings'
    nvidiaSettings = true;
   
    # Power management for GPU (experimental)
    powerManagement.enable = false;
    # Turns of GPU when not in use (experimental, only new GPUs)
    powerManagement.finegrained = false;



    # Optionally, you may need to select the appropriate driver version for your specific GPU.
    #package = config.boot.kernelPackages.nvidiaPackages.stable;
  };
 
  # Only for laptops with hybrid graphics (e.g.: nvidia, intel)
  hardware.nvidia.prime = {
    sync.enable = true;

    # Make sure to use the correct Bus ID values for your system! (CONVERT from hexadecimal to decimal)
    # find the correct Bus ID values with this command: lshw -c display
    intelBusId = "PCI:0:2:0";
    nvidiaBusId = "PCI:1:0:0";
    	# amdgpuBusId = "" # For AMD GPU

  };

  programs = {
    zsh = {
      enable = true;
      autosuggestions.enable = true;
      zsh-autoenv.enable = true;
      syntaxHighlighting.enable = true;

      shellAliases = {
        ll = "ls -l";
        update = "sudo nixos-rebuild switch";
      };
      ohMyZsh = {
        enable = true;
        plugins = [ "git" "thefuck" ];

      };
    };
};
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.mendi = {
    isNormalUser = true;
    description = "mendi";
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.zsh;
    packages = with pkgs; [
    	neovim
	librewolf
	kitty
    ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    # CLI Tools
    neovim
    yazi
    eza
    fzf
    git
    btop
    kitty
    pfetch
    uwufetch
    gum
    ttyper

    # Zsh customization tools
    zsh
    bat
    thefuck
    spaceship-prompt


    # Tools (Drivers, etc...)
    alsa-utils
    lshw

    # For fun :)
    cmatrix
    cowsay
    pipes
    fortune

    # GUI Applications
    davinci-resolve
    librewolf
    vlc
    flameshot
    discord
    telegram-desktop
    arduino-ide
    sioyek

    # BSPWM  (WM)
    bspwm

    # Wine Apps
    wineWowPackages.stable
    winetricks

    # WM
    polybar
    nitrogen
    sxhkd
    dunst
    picom
    rofi
    brightnessctl
  ];

  fonts.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "BigBlueTerminal" ]; })
  ];



  system.autoUpgrade.enable = true;

  nix = {
    # Optimising nix store
    settings.auto-optimise-store = true;
    # automatically collect garbage ( and delete old "snapshots")
    gc.automatic = true;
    gc.dates = "weekly";
    gc.options = "--delete-older-than 30d";
  };


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

  system.stateVersion = "24.05"; # Did you read the comment?

}
