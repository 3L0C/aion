# Shared Waybar configuration helpers
{
  flake.lib.waybar =
    {
      lib,
      config,
    }:
    let
      terminal = lib.getExe config.userSpec.terminal;
    in
    rec {
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
        "custom/mpris"
        "temperature"
        "memory"
        "clock"
        "pulseaudio"
        "idle_inhibitor"
        "custom/cc-toggle"
        "tray"
      ];

      # Shared module definitions
      sharedModules = {
        "custom/cc-toggle" = {
          format = "| ctrl ";
          on-click = "eww open --toggle control-center";
          tooltip = false;
        };

        idle_inhibitor = {
          format = "| {icon} ";
          format-icons = {
            deactivated = "-";
            activated = "0";
          };
          tooltip = false;
        };

        "custom/mpris" = {
          format = "| {} ";
          format-empty = "";
          return-type = "json";
          exec = "sb-mpris-json";
          interval = 1;
          max-length = 18;
          on-click = "sb-mpris-json play-pause";
          on-click-right = "eww open --toggle media-panel";
          tooltip = false;
        };

        pulseaudio = {
          format = "| {volume}% ";
          format-muted = "| MUTED ";
          on-scroll-up = "pamixer -i 2";
          on-scroll-down = "pamixer -d 2";
          on-click = "${terminal} --class pulsemixer pulsemixer";
          on-click-right = "eww open --toggle control-center";
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
          on-click = "${terminal} -e htop";
          tooltip = false;
        };

        memory = {
          format = "| {used:0.1f}G ";
          interval = 10;
          on-click = "${terminal} -e htop";
          tooltip = false;
        };

        network = {
          format-wifi = "| {essid} ({signalStrength}%) ";
          format-ethernet = "| {ifname} ";
          format-linked = "| {ifname} (No IP) ";
          format-disconnected = "| Disconnected ";
          format-alt = "| {ifname}: {ipaddr}/{cidr} ";
          tooltip-format = "{ifname}: {ipaddr}";
          on-click = "${terminal} -e nmtui";
          tooltip = false;
        };

        clock = {
          format = "| {:%b %d %H:%M} ";
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

        backlight = {
          format = "| bkl:{percent}% ";
          on-scroll-up = "brightnessctl set +5%";
          on-scroll-down = "brightnessctl set 5%-";
          tooltip = false;
        };
      };

      # Helper to build complete waybar config
      mkConfig =
        {
          modulesLeft,
          compositorModules ? { },
          extraSettings ? { },
        }:
        lib.recursiveUpdate (
          barSettings
          // {
            modules-left = modulesLeft;
            modules-right = modulesRight;
          }
          // sharedModules
          // compositorModules
        ) extraSettings;
    };
}
