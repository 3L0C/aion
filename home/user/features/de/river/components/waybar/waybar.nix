{
  config,
  lib,
  pkgs,
  ...
}: let
  waybar = lib.getExe config.programs.waybar.package;
in {
  systemd.user.services.waybar-river = {
    Unit = {
      Description = "Waybar status bar (River)";
      Documentation = "https://github.com/Alexays/Waybar/wiki";
      PartOf = ["wayland-session@River.target"];
      After = ["wayland-session@River.target"];
    };

    Service = {
      Type = "simple";
      ExecStart = "${waybar} -c ${config.xdg.configHome}/waybar/river-config.json";
      ExecReload = "${pkgs.coreutils}/bin/kill -SIGUSR2 $MAINPID";
      Restart = "on-failure";
      KillMode = "mixed";
    };

    Install = {
      WantedBy = lib.mkForce ["wayland-session@River.target"];
    };
  };
  xdg.configFile."waybar/river-config.json".text = builtins.toJSON {
    name = "main-bar";
    layer = "top";
    position = "top";
    height = 28;
    spacing = 0;
    margin = null;
    expand-left = true;
    no-center = true;
    modules-left = [
      "river/tags" # Replaces hyprland/workspaces
      "river/mode" # Replaces hyprland/submap
      "river/layout" # Replaces custom/layout
      "river/window" # Replaces hyprland/window
    ];

    modules-right = [
      "pulseaudio"
      "temperature"
      "memory"
      "clock"
      "idle_inhibitor"
      "tray"
    ];
    "river/tags" = {
      num-tags = 9;
      tag-labels = ["1" "2" "3" "4" "5" "6" "7" "8" "9"];
      disable-click = false;
    };
    "river/mode" = {
      format = "<span style=\"italic\">{}</span>";
      tooltip = false;
    };
    "river/layout" = {
      format = "{}";
      tooltip = false;
    };
    "river/window" = {
      format = "{title}";
      max-length = 50;
      tooltip = false;
    };
    pulseaudio = {
      format = "| {volume}% ";
      format-muted = "| MUTED";
      on-click = "wk --press 'o p'";
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

    memory = {
      format = "| {used:0.1f}G ";
      interval = 10;
      on-click = "kitty -e htop";
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
