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

  # Shared modules-right list (same for both compositors)
  modulesRight = [
    "mpris"
    "temperature"
    "memory"
    "custom/sb-internet"
    "clock"
    "group/control-center"
    "tray"
  ];
  sharedModules = wkCommand: {
    "group/control-center" = {
      orientation = "horizontal";
      drawer = {
        transition-duration = 300;
        transition-left-to-right = false;
        children-class = "cc-drawer";
      };
      modules = [
        "custom/cc-indicator"
        "custom/cc-run"
        "custom/vol-up"
        "pulseaudio"
        "custom/vol-down"
        "idle_inhibitor"
      ];
    };

    "custom/cc-indicator" = {
      format = "| ctrl |";
      tooltip = false;
    };

    "custom/cc-run" = {
      format = "| run ";
      on-click = "rofi -show drun";
      tooltip = false;
    };
    "custom/vol-up" = {
      format = "| + ";
      on-click = "pamixer -i 5";
      tooltip = false;
    };

    "custom/vol-down" = {
      format = "- ";
      on-click = "pamixer -d 5";
      tooltip = false;
    };
    "custom/bkl-up" = {
      format = "| + ";
      on-click = "light -A 5";
      tooltip = false;
    };

    backlight = {
      format = "bkl:{percent}% ";
      on-scroll-up = "light -A 5";
      on-scroll-down = "light -U 5";
      tooltip = false;
    };

    "custom/bkl-down" = {
      format = "- ";
      on-click = "light -U 5";
      tooltip = false;
    };
    mpris = {
      format = "| {title}";
      format-paused = "| mpris";
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
      tooltip = false;
    };

    pulseaudio = {
      format = "vol:{volume}% ";
      format-muted = "MUTED ";
      on-click = "${wkCommand} --press 'o p'";
      on-click-right = "pamixer -t";
      on-scroll-up = "pamixer -i 2";
      on-scroll-down = "pamixer -d 2";
      tooltip = false;
    };

    # Note: hwmon-path is host-specific, override in extraSettings
    temperature = {
      interval = 10;
      format = "| {temperatureC}°C ";
      tooltip = false;
    };

    cpu = {
      format = "| {usage}% ";
      interval = 10;
      on-click = "${kitty} -e htop";
      tooltip = false;
    };

    memory = {
      format = "| {used:0.1f}G ";
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
      format-ethernet = "| {ifname} ";
      format-linked = " {ifname} (No IP)";
      format-disconnected = " Disconnected";
      format-alt = "{ifname}: {ipaddr}/{cidr}";
      tooltip-format = "{ifname}: {ipaddr}";
      on-click = "${kitty} -e nmtui";
      tooltip = false;
    };

    clock = {
      format = "| {:%B %d %H:%M} ";
      tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
      tooltip = false;
    };

    idle_inhibitor = {
      format = "| {icon} ";
      format-icons = {
        activated = "0";
        deactivated = "-";
      };
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
      format = "| - {capacity}% ";
      format-charging = "| + {capacity}% ";
      format-plugged = "| {capacity}% ";
      format-icons = [
        ""
        ""
        ""
        ""
        ""
      ];
      tooltip = false;
    };
  };
  mkConfig = {
    wkCommand,
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
      // sharedModules wkCommand
      // compositorModules
    )
    extraSettings;
}
