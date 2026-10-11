{pkgs, lib, config, ...}:

{
   programs.niri = {
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
        "DP-1" = {
	  mode = {
            width = 3440;
	    height = 1440;
	    refresh = 239.984;
	  };
	  scale = 1.0;
	  position = { x = 0; y = 0; };
	  variable-refresh-rate = "on-demand";
        };
      };

      overview = {
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

      overview = {
        backdrop-color = "${config.lib.stylix.colors.base01}";
      };

      layout = {
        focus-ring = {
          enable = true;
          width = 3;
          active.color = "#${config.lib.stylix.colors.base03}60";
        };
        border = {
          enable = false;
        };
        shadow = {
          enable = false;

	  offset.x = 7;
	  offset.y = 7;

	  color = "#000000";

	  softness = 0;
	  spread = 0;
        };
      };

      window-rules = [
        {
          geometry-corner-radius = {
            top-left = 0.0;
            top-right = 0.0;
            bottom-left = 0.0;
            bottom-right = 0.0;
          };
          clip-to-geometry = true;
        }
      ];
    };
  };


}
