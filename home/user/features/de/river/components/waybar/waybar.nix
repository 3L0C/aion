{
  config,
  lib,
  pkgs,
  ...
}: let
  waybar = lib.getExe config.programs.waybar.package;
  riverdo = lib.getExe pkgs.riverdo;
  kitty = lib.getExe pkgs.kitty;
  shared = import ../../../common/waybar/shared.nix {inherit lib pkgs;};
  wlanIface =
    if config.hostSpec.wlanInterface != null
    then config.hostSpec.wlanInterface
    else "";
  isLaptop = config.hostSpec.kind == "laptop";
in {
  programs.waybar = {
    enable = true;
    systemd.enable = false;
  };
  systemd.user.services.waybar-river = lib.custom.mkWaylandService {
    river = {
      Unit = {
        Description = "Waybar status bar (River)";
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
    riverdev = {
      Unit = {
        Description = "Waybar status bar (River)";
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
  xdg.configFile."waybar/river-config.json".text = builtins.toJSON (
    shared.mkConfig {
      modulesLeft = [
        "river/tags"
        "river/layout"
        "river/window"
      ];
      compositorModules =
        {
          "river/tags" = {
            num-tags = 9;
            tag-labels = [
              "1"
              "2"
              "3"
              "4"
              "5"
              "6"
              "7"
              "8"
              "9"
            ];
            disable-click = false;
            hide-vacant = true;
          };

          "river/layout" = {
            format = "{}";
            on-click-right = "${riverdo} swap-outputs --focused-tag --swap DP-3 --with DP-1";
            tooltip = false;
          };

          "river/window" = {
            format = "{}";
            on-click-right = "${riverdo} zoom";
            on-scroll-up = "${riverdo} focus-view previous";
            on-scroll-down = "${riverdo} focus-view next";
            max-length = 100;
            expand = true;
            tooltip = false;
          };
        }
        // lib.optionalAttrs isLaptop {
          inherit (shared.sharedModules) battery;
        };
      extraSettings =
        {
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
    }
  );
}
