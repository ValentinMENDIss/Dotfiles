{ config, lib, pkgs, ... }:

{
  home.stateVersion = "26.05"; 

  home.packages = with pkgs; [
    swaybg
    eww

    xwayland-satellite
    zoxide

    harmonoid

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
        "text/html" = "firefox.desktop";
        "x-scheme-handler/http" = "firefox.desktop";
        "x-scheme-handler/https" = "firefox.desktop";
        "x-scheme-handler/about" = "firefox.desktop";
        "application/x-extension-html" = "firefox.desktop";
                                #"x-scheme-handler/qrc" = "kyber-qrc-handler.desktop";
        "x-scheme-handler/qrc" = "firefox.desktop";
      };
    };
    # Portal configuration moved to system-level (modules/core/flatpak.nix)
    # to avoid package collisions between stable and unstable
  };

  programs.niri = {
    enable = true;
    package = pkgs.niri;
    settings = {
      xwayland-satellite.path = lib.getExe pkgs.xwayland-satellite;
      environment."NIXOS_OZONE_WL" = "1";

      prefer-no-csd = true;

      spawn-at-startup = [
        { argv = ["vicinae" "server"]; }
        { argv = ["swaybg" "-i" "${config.stylix.image}" "-m" "fill"]; }
        { argv = ["waybar"]; }
      ];

      outputs = {
        "HDMI-A-3" = {
	  mode = {
            width = 1920;
	    height = 1080;
	    refresh = 239.757;
	  };
	  scale = 1.0;
	  position = { x = 0; y = 0; };
	  variable-refresh-rate = "on-demand";
        };
      };

      input = {
        focus-follows-mouse.enable = true;

        keyboard = {
          repeat-rate = 35;
	  repeat-delay = 200;

          xkb = {
            layout = "us";
            variant = "";
	  };
	};
	
	mouse = {
          accel-profile = "flat";
	};

      };

      binds = {
	"Mod+Return".action.spawn = "foot";
	"Mod+P".action.spawn = ["vicinae" "open"];

        "Mod+F3".action.spawn = ["wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.05+"];
        "Mod+F2".action.spawn = ["wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.05-"];

	"Shift+Mod+S".action.screenshot-screen = { show-pointer = false; };

	"Mod+1".action.focus-workspace = 1;
	"Mod+2".action.focus-workspace = 2;
	"Mod+3".action.focus-workspace = 3;
	"Mod+4".action.focus-workspace = 4;
	"Mod+5".action.focus-workspace = 5;
	"Mod+6".action.focus-workspace = 6;
	"Mod+7".action.focus-workspace = 7;
	"Mod+8".action.focus-workspace = 8;
	"Mod+9".action.focus-workspace = 9;
	"Mod+0".action.focus-workspace = 0;

        "Mod+O" = {
	  action.toggle-overview = {};
	  repeat = false;
	};

        "Mod+Q" = {
	  action.close-window = {};
	  repeat = false;
	};

        "Mod+Left".action.focus-column-left = {};
        "Mod+Down".action.focus-window-down = {};
        "Mod+Up".action.focus-window-up = {};
        "Mod+Right".action.focus-column-right = {};

        "Mod+H".action.focus-column-left = {};
        "Mod+J".action.focus-window-down = {};
        "Mod+K".action.focus-window-up = {};
        "Mod+L".action.focus-column-right = {};

	"Mod+F".action.maximize-column = {};
    	"Mod+Shift+F".action.fullscreen-window = {};

	"Mod+Minus".action.set-column-width = "-10%";
	"Mod+Equal".action.set-column-width = "+10%";

	"Mod+Shift+Minus".action.set-window-height = "-10%";
	"Mod+Shift+Equal".action.set-window-height = "+10%";

	"Mod+V".action.toggle-window-floating = {};
	"Mod+Shift+V".action.switch-focus-between-floating-and-tiling = {};

        "Mod+Shift+E".action.quit = {};
      };

      layout.shadow = {
        enable = true;

	offset.x = 7;
	offset.y = 7;

	color = "#000000";

	softness = 0;
	spread = 0;
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

  programs.foot.enable = true;
  programs.btop.enable = true;

  programs.waybar.enable = true;
  programs.waybar.settings.main = {
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
}
