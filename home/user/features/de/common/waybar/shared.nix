{
  lib,
  pkgs,
}: let
  kitty = lib.getExe pkgs.kitty;
in rec {
  # Common bar settings
  barSettings = {
    name = "main-bar";
    layer = "top";
    position = "top";
    height = 28;
    spacing = 0;
    margin = null;
    expand-left = true;
    no-center = true;
  };
  modulesRight = [
    "mpris"
    "custom/sep"
    "temperature"
    "custom/sep"
    "memory"
    "custom/sep"
    "custom/sb-internet"
    "custom/sep"
    "clock"
    "custom/sep"
    "group/control-center"
    "custom/sep"
    "tray"
  ];

  # Shared module definitions
  sharedModules = {
    "custom/sep" = {
      format = "|";
      tooltip = false;
    };
    "group/control-center" = {
      orientation = "horizontal";
      modules = [
        "idle_inhibitor"
        "pulseaudio"
      ];
    };
    idle_inhibitor = {
      format = " {icon} ";
      format-icons = {
        activated = "󰈉"; # eye closed (idle inhibited)
        deactivated = "󰈈"; # eye open (normal)
      };
      on-click = "eww open --toggle control-center";
      tooltip = false;
    };
    mpris = {
      format = " {title} ";
      format-paused = " mpris ";
      status-icons = {
        playing = "-";
        paused = "+";
        stopped = "x";
      };
      player-icons = {
        default = "";
      };
      title-len = 16;
      on-click = "playerctl play-pause";
      on-click-right = "eww open --toggle media-panel";
      interval = 1;
      tooltip = false;
    };
    pulseaudio = {
      format = " {volume}% ";
      format-muted = " MUTED ";
      on-scroll-up = "pamixer -i 2";
      on-scroll-down = "pamixer -d 2";
      on-click = "${kitty} --class pulsemixer pulsemixer";
      on-click-right = "eww open --toggle control-center";
      tooltip = false;
    };

    # Note: hwmon-path is host-specific, override in extraSettings
    temperature = {
      interval = 10;
      format = " {temperatureC}°C ";
      tooltip = false;
    };

    cpu = {
      format = " {usage}% ";
      interval = 10;
      on-click = "${kitty} -e htop";
      tooltip = false;
    };

    memory = {
      format = " {used:0.1f}G ";
      interval = 10;
      on-click = "${kitty} -e htop";
      tooltip = false;
    };

    "custom/sb-internet" = {
      format = "{}";
      exec = "sb-internet";
      interval = 5;
      on-click = "BLOCK_BUTTON=1 sb-internet";
      on-click-middle = "BLOCK_BUTTON=2 sb-internet";
      on-click-right = "BLOCK_BUTTON=3 sb-internet";
      tooltip = false;
    };

    network = {
      format-wifi = "  {essid} ({signalStrength}%)";
      format-ethernet = " {ifname} ";
      format-linked = " {ifname} (No IP)";
      format-disconnected = " Disconnected";
      format-alt = "{ifname}: {ipaddr}/{cidr}";
      tooltip-format = "{ifname}: {ipaddr}";
      on-click = "${kitty} -e nmtui";
      tooltip = false;
    };

    clock = {
      format = " {:%B %d %H:%M} ";
      tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
      tooltip = false;
    };

    tray = {
      icon-size = 18;
      spacing = 5;
      tooltip = false;
    };
    battery = {
      interval = 10;
      states = {
        warning = 30;
        critical = 15;
      };
      format = " - {capacity}% ";
      format-charging = " + {capacity}% ";
      format-plugged = " {capacity}% ";
      format-icons = [
        ""
        ""
        ""
        ""
        ""
      ];
      tooltip = false;
    };
    backlight = {
      format = " bkl:{percent}% ";
      on-scroll-up = "brightnessctl set +5%";
      on-scroll-down = "brightnessctl set 5%-";
      tooltip = false;
    };
  };
  mkConfig = {
    modulesLeft,
    compositorModules ? {},
    extraSettings ? {},
  }:
    lib.recursiveUpdate (
      barSettings
      // {
        modules-left = modulesLeft;
        modules-right = modulesRight;
      }
      // sharedModules
      // compositorModules
    )
    extraSettings;
}
