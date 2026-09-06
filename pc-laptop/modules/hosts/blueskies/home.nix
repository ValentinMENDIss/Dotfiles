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

  xdg.desktopEntries = {
    kyber-qrc-handler = {
      name = "Kyber QRC Handler";
      exec = "/home/mendiss/Applications/KyberLinuxPort-x86_64.AppImage %u";
      noDisplay = true;
      mimeType = [ "x-scheme-handler/qrc" ];
      settings = {
        Terminal = "false";
        StartupNotify = "false";
        Comment = "Receives qrc:// OAuth redirects for the Kyber EA login flow";
      };
    };
  };

  xdg = {
    enable = true;
    mime.enable = true;
    mimeApps = {
      enable = true;
      defaultApplications = {
        "text/html" = "brave.desktop";
        "x-scheme-handler/http" = "brave.desktop";
        "x-scheme-handler/https" = "brave.desktop";
        "x-scheme-handler/about" = "brave.desktop";
        "application/x-extension-html" = "brave.desktop";
                                #"x-scheme-handler/qrc" = "kyber-qrc-handler.desktop";
        "x-scheme-handler/qrc" = "brave.desktop";
      };
    };
    # Portal configuration moved to system-level (modules/core/flatpak.nix)
    # to avoid package collisions between stable and unstable
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
            curl -s http://wttr.in/berlin\?format="%c%t"
        '';
        interval = 3600;
        format = "   {}";
      };
    };

    style = ''
      * {
        color: #${config.lib.stylix.colors.base05};
      }
    '';
  };

  programs.vicinae = {
    enable = true;
  };

  stylix.targets.foot.enable = true;
  stylix.targets.btop.enable = true;
  stylix.targets.nvf.enable = true;
  stylix.targets.gtk.enable = true;
  stylix.targets.gnome.enable = false;
  stylix.targets.niri.enable = true;

  stylix.image = pkgs.fetchurl {
    url = "https://w.wallhaven.cc/full/7j/wallhaven-7jreyy.png";
    hash = "sha256-lnWLdIL0bqNXsA2qMlF8iUIrAX3h4L/k0xxs7V10ElQ=";
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
