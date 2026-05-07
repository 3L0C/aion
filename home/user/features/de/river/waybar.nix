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
  xdg.configFile."waybar/river-config.json".text = builtins.toJSON (
    shared.mkConfig {
      modulesLeft = [];
      compositorModules = lib.optionalAttrs isLaptop {
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
