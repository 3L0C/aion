{
  lib,
  pkgs,
  ...
}: let
  shared = import ../../common/waybar/shared.nix {inherit lib pkgs;};
in {
  programs.waybar.enable = true;
  xdg.configFile."waybar/niri-config.json".text = builtins.toJSON (
    shared.mkConfig {
      wkCommand = "wk-niri";

      modulesLeft = [
        "niri/workspaces"
        "niri/window"
      ];
      compositorModules = {
        "niri/workspaces" = {
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
          };
        };

        "niri/window" = {
          format = "{title}";
          separate-outputs = true;
          icon = false;
          tooltip = false;
        };
      };
      extraSettings = {
        temperature.hwmon-path-abs = "/sys/devices/pci0000:00/0000:00:18.3/hwmon";
        temperature.input-filename = "temp3_input";
      };
    }
  );
}
