{ config, pkgs, ... }:

{
  imports = [
    ../../home-manager/features/default.nix
  ];

  home.stateVersion = "26.05"; 

  home.packages = with pkgs; [
    swaybg
    eww

    xwayland-satellite
    zoxide

    fuchsia-cursor

    # running `obsidian-x11` in terminal will launch now this script
    (pkgs.writeShellScriptBin "obsidian-x11" ''
      exec ${pkgs.obsidian}/bin/obsidian \
      --enable-features=UseOzonePlatform \
      --ozone-platform=x11 "$@"
    '')
  ];

  xdg = {
    enable = true;
    mime.enable = true;
  };

  services.udiskie = {
    enable = true;
    settings = {
        # workaround for
        # https://github.com/nix-community/home-manager/issues/632
        program_options = {
            # replace with your favorite file manager
            file_manager = "${pkgs.kdePackages.dolphin}/bin/dolphin";
        };
    };
  };

  programs.zsh = {
    enable = true;

    shellAliases = {
      update = "sudo nixos-rebuild switch --flake";
    };

    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    oh-my-zsh = {
      enable = true;
      plugins = [
	"eza"
        "fzf"
	"colored-man-pages"
      ];
    };
  };

  programs.starship.enable = true;

  programs.eza.enable = true;
  programs.fzf.enable = true;

  programs.zoxide.enable = true;
  programs.zoxide.enableZshIntegration = true;

  programs.foot = {
    enable = true;
    settings = {
      main = {
        pad = "15x15";
      };
    };
  };
  programs.btop.enable = true;

  programs.waybar.enable = true;
  programs.waybar = {
    settings.main = {
      layer = "top";
      modules-left = ["clock#date" "custom/wttr"];
      modules-center = ["clock#time" "battery"];
      modules-right = ["pulseaudio"];

      "sway/window" = {
        max-length = 50;
      };

      "battery" = {
        format = "{capacity}% {icon}";
        format-icons = ["" "" "" "" ""];
      };

      "clock#date" = {
        format = "{:%a - %d %b}";
      };

      "clock#time" = {
        format = "{:%H:%M}";
      };

      "pulseaudio" = {
        format = "{volume}%";
      };

      "custom/wttr" = {
        exec = pkgs.writeShellScript "wttr" ''
          curl -s http://wttr.in/Berlin,Germany\?format\="%c%t"
        '';
        interval = 3600;
        format = "   {}";
      };
    };

    style = ''
      * {
        font-family: Outfit;
        color: #${config.lib.stylix.colors.base05};
      }
    '';
  };

  programs.vicinae = {
    enable = true;
  };

  services.flameshot = {
    enable = true;
    settings = {
      General = {
        # More settings may be found on the Flameshot Github

        # Save Path
        savePath = "/home/user/Screenshots";
        # Tray
        disabledTrayIcon = true;
        # Greeting message   
        showStartupLaunchMessage = false;
        # Default file extension for screenshots (.png by default)
        saveAsFileExtension = ".png";
        # Desktop notifications
        showDesktopNotification = true;
        # Notification for cancelled screenshot
        showAbortNotification = false;
        # Whether to show the info panel in the center in GUI mode
        showHelp = true;
        # Whether to show the left side button in GUI mode
        showSidePanelButton = true;


        # Color Customization
        uiColor = "#740096";
        contrastUiColor = "#270032";
        drawColor = "#ff0000";

        # For Wayland (Install Grim seperately)
        useGrimAdapter = true;
        # Stops warnings for using Grim
        disabledGrimWarning = true;
      };
    };
  };      

  stylix.targets.foot.enable = true;
  stylix.targets.btop.enable = true;
  stylix.targets.nvf.enable = true;
  stylix.targets.gtk.enable = true;
  stylix.targets.gnome.enable = false;
  stylix.targets.niri.enable = true;

  stylix.image = pkgs.fetchurl {
    name = "wallpaper.png";
    url = "https://www.flickr.com/photo_download.gne?size=o&id=55582885743&secret=d852d5e115";
    hash = "sha256-xtkQ7ZZd+fHBFf5gxQgqZKO7ABboJo5ooOzWaxxkIYs=";
  };

  stylix.fonts = {
    monospace = {
      package = pkgs.nerd-fonts.jetbrains-mono;
      name = "JetBrainsMono Nerd Font Mono";
    };
  };
  
  home.pointerCursor = {
    package = pkgs.fuchsia-cursor;      # or phinger-cursors, capitaine-cursors,
    name = "Fuchsia";         # catppuccin-cursors.mochaDark, etc.
    size = 24;
    gtk.enable = true;
    x11.enable = true;
  };
  gtk.enable = true; # required for pointerCursor.gtk.enable to actually apply

  programs.niri.settings.cursor = {
    theme = config.home.pointerCursor.name;
    size = config.home.pointerCursor.size;
  };
}
