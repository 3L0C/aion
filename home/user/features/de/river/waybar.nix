{
  config,
  lib,
  pkgs,
  ...
}: let
  waybar = lib.getExe config.programs.waybar.package;
  kitty = lib.getExe pkgs.kitty;

  shared = import ../common/waybar/shared.nix {inherit lib pkgs;};

  wlanIface =
    if config.hostSpec.wlanInterface != null
    then config.hostSpec.wlanInterface
    else "";

  isLaptop = config.hostSpec.kind == "laptop";

  scriptsDir = "${config.xdg.configHome}/waybar/scripts";
  tagNumbers = lib.range 1 9;

  octlModulesLeft =
    map (n: "custom/tag#${toString n}") tagNumbers
    ++ [
      "custom/layout"
      "custom/mode"
      "custom/window"
    ];
  octlModules = output:
    lib.listToAttrs (map (n: {
        name = "custom/tag#${toString n}";
        value = {
          exec = "${scriptsDir}/tag.sh ${toString n} ${output}";
          return-type = "json";
          format = "{}";
          on-click = "octl tag view ${toString n}";
          on-click-right = "octl tag toggle ${toString n}";
          on-scroll-down = "octl tag next";
          on-scroll-up = "octl tag prev";
          tooltip = false;
        };
      })
      tagNumbers)
    // {
      "custom/layout" = {
        exec = "${scriptsDir}/layout.sh ${output}";
        return-type = "json";
        format = "{}";
        on-click = "octl layout next";
        on-click-right = "octl layout tiling scheme next";
        on-scroll-down = "octl layout tiling stack next";
        on-scroll-up = "octl layout tiling stack prev";
        tooltip = false;
      };

      "custom/mode" = {
        exec = "${scriptsDir}/mode.sh";
        return-type = "json";
        format = "{}";
        tooltip = false;
      };

      "custom/window" = {
        exec = "${scriptsDir}/window.sh ${output}";
        return-type = "json";
        format = "{}";
        escape = true;
        expand = true;
        max-length = 100;
        on-click-right = "octl window zoom --no-warp";
        on-scroll-down = "octl window focus next --no-warp";
        on-scroll-up = "octl window focus prev --no-warp";
        tooltip = false;
      };
    };

  mkBar = monitor:
    shared.mkConfig {
      modulesLeft = octlModulesLeft;

      compositorModules =
        octlModules monitor.name
        // lib.optionalAttrs isLaptop {
          inherit (shared.sharedModules) battery;
        };

      extraSettings =
        {
          name = "ocdwm-bar";
          output = monitor.name;

          modules-right =
            [
              "custom/mpris"
              "custom/sep"
              "pulseaudio"
              "custom/sep"
              "temperature"
              "custom/sep"
              "memory"
            ]
            ++ lib.optionals isLaptop ["custom/sep" "battery"]
            ++ [
              "custom/sep"
              "clock"
              "custom/sep"
              "idle_inhibitor"
              "custom/sep"
              "custom/cc-toggle"
              "custom/sep"
              "tray"
            ];

          network = {
            interface = wlanIface;
            format-wifi = " {essid} ({signalStrength}%) ";
            format-ethernet = " {ifname} ";
            format-disconnected = " Disconnected ";
            on-click = "${kitty} -e nmtui";
            tooltip = false;
          };
        }
        // lib.optionalAttrs (config.hostSpec.cpuHwmonPath != null) {
          temperature = {
            hwmon-path-abs = config.hostSpec.cpuHwmonPath;
            input-filename = config.hostSpec.cpuTempInput;
          };
        };
    };

  enabledMonitors = lib.filter (m: m.enabled) config.monitors;
in {
  systemd.user.services.waybar-river = lib.custom.mkWaylandService {
    river = {
      Unit = {
        Description = "Waybar status bar (River 0.4.x)";
        Documentation = "https://github.com/Alexays/Waybar/wiki";
      };

      Service = {
        Type = "simple";
        ExecStart = "${waybar} -c ${config.xdg.configHome}/waybar/river-config.json";
        ExecReload = "${pkgs.coreutils}/bin/kill -SIGUSR2 $MAINPID";
        Restart = "on-failure";
        KillMode = "mixed";
      };
    };
  };

  xdg.configFile =
    {
      "waybar/river-config.json".text =
        builtins.toJSON (map mkBar enabledMonitors);
    }
    // lib.listToAttrs (map (s: {
      name = "waybar/scripts/${s}";
      value = {
        source = ./waybar-scripts/${s};
        executable = true;
      };
    }) ["tag.sh" "layout.sh" "mode.sh" "window.sh" "focus.sh"]);
}
