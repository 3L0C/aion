{
  config,
  lib,
  pkgs,
  ...
}: let
  waybar = lib.getExe config.programs.waybar.package;
  riverdo = lib.getExe pkgs.riverdo;
  shared = import ../../../common/waybar/shared.nix {inherit lib pkgs;};
  wlanIface =
    if config.hostSpec.wlanInterface != null
    then config.hostSpec.wlanInterface
    else "";
  ethIface =
    if config.hostSpec.ethernetInterface != null
    then config.hostSpec.ethernetInterface
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
      wkCommand = "wk-river";

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
            on-click-right = "${riverdo} swap-outputs --focused-tag";
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
          "custom/sb-internet" = {
            format = "{}";
            exec = "WLAN_IFACE=${wlanIface} ETH_IFACE=${ethIface} sb-internet";
            interval = 5;
            on-click = "BLOCK_BUTTON=1 WLAN_IFACE=${wlanIface} ETH_IFACE=${ethIface} sb-internet";
            on-click-middle = "BLOCK_BUTTON=2 WLAN_IFACE=${wlanIface} ETH_IFACE=${ethIface} sb-internet";
            on-click-right = "BLOCK_BUTTON=3 WLAN_IFACE=${wlanIface} ETH_IFACE=${ethIface} sb-internet";
            tooltip = false;
          };
        }
        // lib.optionalAttrs isLaptop {
          inherit (shared.sharedModules "wk-river") battery;
        };
      extraSettings =
        {
          modules-right =
            shared.modulesRight
            ++ lib.optional isLaptop "battery";
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
