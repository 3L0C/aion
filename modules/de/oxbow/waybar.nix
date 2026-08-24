{config, ...}: let
  waybarLib = config.flake.lib.waybar;
  inherit (config.flake.lib) mkWaylandService;
in {
  flake.modules.homeManager.oxbow = {
    config,
    lib,
    pkgs,
    ...
  }: let
    shared = waybarLib {inherit lib config;};

    waybar = lib.getExe config.programs.waybar.package;
    terminal = lib.getExe config.userSpec.terminal;

    wlanIface =
      if config.hostSpec.wlanInterface != null
      then config.hostSpec.wlanInterface
      else "";

    isLaptop = config.hostSpec.kind == "laptop";

    scriptsDir = "${config.xdg.configHome}/waybar/scripts";
    tagNumbers = lib.range 1 9;

    oxctlModulesLeft =
      map (n: "custom/tag#${toString n}") tagNumbers
      ++ [
        "custom/layout"
        "custom/mode"
        "custom/window"
      ];

    # Per-output oxctl module definitions (scripts filter on --output)
    oxctlModules = output:
      lib.listToAttrs (map (n: {
          name = "custom/tag#${toString n}";
          value = {
            exec = "${scriptsDir}/tag.sh ${toString n} ${output}";
            return-type = "json";
            format = "{}";
            on-click = "oxctl tag view ${toString n}";
            on-click-right = "oxctl tag toggle ${toString n}";
            on-scroll-down = "oxctl tag next";
            on-scroll-up = "oxctl tag prev";
            tooltip = false;
          };
        })
        tagNumbers)
      // {
        "custom/layout" = {
          exec = "${scriptsDir}/layout.sh ${output}";
          return-type = "json";
          format = "{}";
          on-click = "oxctl layout next";
          on-click-right = "oxctl layout prev";
          on-scroll-down = "oxctl layout tiling next";
          on-scroll-up = "oxctl layout tiling prev";
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
          on-click = "oxctl output overview";
          on-click-right = "oxctl window zoom --no-warp";
          on-scroll-down = "oxctl window focus next --no-warp";
          on-scroll-up = "oxctl window focus prev --no-warp";
          tooltip = false;
        };

        "custom/capture" = {
          exec = "${scriptsDir}/capture.sh ${output}";
          return-type = "json";
          format = "{}";
          tooltip = false;
        };

        "custom/capture-sep" = {
          exec = "${scriptsDir}/capture.sh ${output} sep";
          return-type = "json";
          format = "{}";
          tooltip = false;
        };
      };

    mkBar = monitor:
      shared.mkConfig {
        modulesLeft = oxctlModulesLeft;

        compositorModules =
          oxctlModules monitor.name
          // lib.optionalAttrs isLaptop {
            inherit (shared.sharedModules) battery;
          };

        extraSettings =
          {
            name = "oxbow-bar";
            output = monitor.name;

            modules-right =
              [
                "custom/capture-sep"
                "custom/capture"
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
              on-click = "${terminal} -e nmtui";
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
    programs.waybar = {
      enable = true;
      systemd.enable = false;
    };

    systemd.user.services.waybar-river = mkWaylandService {
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
      }) ["tag.sh" "layout.sh" "mode.sh" "window.sh" "focus.sh" "capture.sh"]);
  };
}
