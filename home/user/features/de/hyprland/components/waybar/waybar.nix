{
  config,
  lib,
  pkgs,
  ...
}: let
  waybar = lib.getExe config.programs.waybar.package;
in {
  programs.waybar = {
    enable = true;
    systemd.enable = false;
  };
  systemd.user.services.waybar-hyprland = {
    Unit = {
      Description = "Waybar status bar (Hyprland)";
      Documentation = "https://github.com/Alexays/Waybar/wiki";
      PartOf = ["wayland-session@Hyprland.target"];
      After = ["wayland-session@Hyprland.target"];
    };

    Service = {
      Type = "simple";
      ExecStart = "${waybar} -c ${config.xdg.configHome}/waybar/hyprland-config.json";
      ExecReload = "${pkgs.coreutils}/bin/kill -SIGUSR2 $MAINPID";
      Restart = "on-failure";
      KillMode = "mixed";
    };

    Install = {
      WantedBy = lib.mkForce ["wayland-session@Hyprland.target"];
    };
  };

  xdg.configFile."waybar/hyprland-config.json".text = builtins.toJSON {
    name = "main-bar";
    layer = "top";
    position = "top";
    height = 28;
    spacing = 0;
    margin = null;
    expand-left = true;
    no-center = true;

    modules-left = [
      "hyprland/workspaces"
      "hyprland/submap"
      "custom/layout"
      "hyprland/window"
    ];

    modules-right = [
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

    "hyprland/workspaces" = {
      all-outputs = false;
      active-only = false;
      separate-outputs = true;
      disable-scroll = true;
      format = "{icon}";
      format-icons = {
        "1" = "1";
        "2" = "2";
        "3" = "3";
        "4" = "4";
        "5" = "5";
        "6" = "6";
        "7" = "7";
        "8" = "8";
        "9" = "9";
        "10" = "10";
      };
      on-scroll-down = "hyprctl dispatch workspace e+1";
      on-scroll-up = "hyprctl dispatch workspace e-1";
      tooltip = false;
    };

    "hyprland/submap" = {
      format = "<span style=\"italic\">{}</span>";
      tooltip = false;
    };

    "custom/layout" = {
      format = "{}";
      exec = "${lib.getExe pkgs.custom.scripts.hypr-layout}";
      interval = 1;
      tooltip = false;
    };

    "hyprland/window" = {
      format = "{title}";
      separate-outputs = true;
      on-click-right = "hyprctl dispatch layoutmsg swapwithmaster master";
      on-scroll-down = "hyprctl dispatch layoutmsg cyclenext";
      on-scroll-up = "hyprctl dispatch layoutmsg cycleprev";
      expand = true;
      tooltip = false;
    };

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
      on-click = "wk-hyprland --press 'o p'";
      on-click-right = "pactl set-sink-mute @DEFAULT_SINK@ toggle";
      on-scroll-up = "pactl set-sink-volume @DEFAULT_SINK@ +2%";
      on-scroll-down = "pactl set-sink-volume @DEFAULT_SINK@ -2%";
      tooltip = false;
    };

    temperature = {
      hwmon-path = "/sys/devices/pci0000:00/0000:00:18.3/hwmon/hwmon4/temp1_input";
      interval = 10;
      format = "| {temperatureC}°C ";
      tooltip = false;
    };

    cpu = {
      format = "| {usage}% ";
      interval = 10;
      on-click = "kitty -e htop";
      tooltip = false;
    };

    memory = {
      format = "| {used:0.1f}G ";
      interval = 10;
      on-click = "kitty -e htop";
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
      on-click = "kitty -e nmtui";
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
}
