{ config, pkgs, ... }:

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
    autorun = false;
    xkb.layout = "us";
    xkb.options = "eurosign:e";
    # Enable the Gnome Desktop Environment.
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
    # Enable the BSPWM Tiling Manager.
    windowManager.bspwm.enable = true;
  };

  services.displayManager.defaultSession = "none+bspwm";
  
  # Configure console keymap
  console.keyMap = "uk";

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

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput.enable = true;

  # Video support
  hardware = {
    #  Most wayland compositors need this
    nvidia.modesetting.enable = true;
    opengl = {
      enable = true;
      driSupport32Bit = true;
      driSupport = true;
    };
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

    # GUI Applications
    librewolf
    vlc
    flameshot
    discord
    telegram-desktop
    arduino-ide
    sioyek

    # BSPWM  (WM)
    bspwm

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
