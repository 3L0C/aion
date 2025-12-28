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
    "custom/sb-playerctl"
    "custom/sb-mpv"
    "pulseaudio"
    "temperature"
    "memory"
    "custom/sb-internet"
    "clock"
    "idle_inhibitor"
    "tray"
  ];
  sharedModules = wkCommand: {
    "custom/sb-playerctl" = {
      format = "{}";
      exec = "sb-playerctl";
      interval = 1;
      on-click = "BLOCK_BUTTON=1 sb-playerctl";
      tooltip = false;
    };

    "custom/sb-mpv" = {
      format = "{}";
      exec = "sb-mpv";
      on-click = "BLOCK_BUTTON=1 sb-mpv";
      on-click-middle = "BLOCK_BUTTON=2 sb-mpv";
      on-click-right = "BLOCK_BUTTON=3 sb-mpv";
      on-scroll-down = "BLOCK_BUTTON=4 sb-mpv";
      on-scroll-up = "BLOCK_BUTTON=5 sb-mpv";
      interval = 1;
      tooltip = false;
    };

    pulseaudio = {
      format = "| {volume}% ";
      format-muted = "| MUTED";
      on-click = "${wkCommand} --press 'o p'";
      on-click-right = "pactl set-sink-mute @DEFAULT_SINK@ toggle";
      on-scroll-up = "pactl set-sink-volume @DEFAULT_SINK@ +2%";
      on-scroll-down = "pactl set-sink-volume @DEFAULT_SINK@ -2%";
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
      format = "| {icon} |";
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
  };
  mkConfig = {
    wkCommand,
    modulesLeft,
    compositorModules ? {},
    extraSettings ? {},
  }:
    lib.recursiveUpdate
    (barSettings
      // {
        modules-left = modulesLeft;
        modules-right = modulesRight;
      }
      // sharedModules wkCommand
      // compositorModules)
    extraSettings;
}
