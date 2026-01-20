{
  config,
  lib,
  pkgs,
  ...
}: let
  waybar = lib.getExe config.programs.waybar.package;
  hyprLayoutScript = lib.getExe pkgs.custom.scripts.hypr-layout;
  shared = import ../../../common/waybar/shared.nix {inherit lib pkgs;};
in {
  programs.waybar = {
    enable = true;
    systemd.enable = false;
  };
  systemd.user.services.waybar-hyprland = {
    Unit = {
      Description = "Waybar status bar (Hyprland)";
      Documentation = "https://github.com/Alexays/Waybar/wiki";
      PartOf = ["wayland-session@start\\x2dhyprland.target"];
      After = ["wayland-wm@start\\x2dhyprland.service"];
    };

    Service = {
      Type = "simple";
      ExecStart = "${waybar} -c ${config.xdg.configHome}/waybar/hyprland-config.json";
      ExecReload = "${pkgs.coreutils}/bin/kill -SIGUSR2 $MAINPID";
      Restart = "on-failure";
      KillMode = "mixed";
    };

    Install = {
      WantedBy = lib.mkForce ["wayland-session@start\\x2dhyprland.target"];
    };
  };
  xdg.configFile."waybar/hyprland-config.json".text = builtins.toJSON (
    shared.mkConfig {
      wkCommand = "wk-hyprland";

      modulesLeft = [
        "hyprland/workspaces"
        "hyprland/submap"
        "custom/layout"
        "hyprland/window"
      ];
      compositorModules = {
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
          exec = hyprLayoutScript;
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
      };
      extraSettings =
        {
          temperature.hwmon-path-abs = "/sys/devices/pci0000:00/0000:00:18.3/hwmon";
          temperature.input-filename = "temp3_input";
        }
        // lib.optionalAttrs (config.hostSpec.kind == "laptop") {
          "group/control-center".modules = [
            "custom/cc-indicator"
            "custom/cc-run"
            "custom/vol-up"
            "pulseaudio"
            "custom/vol-down"
            "custom/bkl-up"
            "backlight"
            "custom/bkl-down"
            "idle_inhibitor"
          ];
        };
    }
  );
}
