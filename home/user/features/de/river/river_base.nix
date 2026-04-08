{
  config,
  lib,
  pkgs,
  ...
}: {
  wayland.windowManager.river = {
    enable = true;
    package = null;
    systemd = {
      enable = false; # UWSM handles systemd integration
    };
    xwayland.enable = true;
    extraConfig = ''
      ${lib.concatStringsSep "\n" (
        lib.mapAttrsToList (name: value: "export ${name}=${value}") config.wayland.envVars
      )}

      # Notify UWSM that River is ready
      uwsm finalize
    '';
  };

  xdg.configFile = let
    portalText = ''
      [preferred]
      default=gtk
      org.freedesktop.impl.portal.ScreenCast=wlr
      org.freedesktop.impl.portal.Screenshot=wlr
      org.freedesktop.impl.portal.Inhibit=none
    '';
    portalChooser = pkgs.writeShellApplication {
      name = "xdph-wlr-chooser";
      runtimeInputs = with pkgs; [lswt jq rofi wlr-randr coreutils gnused];
      text = ''
        set -euo pipefail

        monitors=$(wlr-randr --json | jq -r '.[] | "Monitor: \(.name)"')
        windows=$(lswt -j | jq -r '
          .toplevels[]
          | "Window: \(.identifier)\t\(.app_id // "?") — \(.title // "")"
        ')

        choice=$(printf '%s\n%s\n' "$monitors" "$windows" \
          | rofi -dmenu -i -p "Screencast source")
        printf '%s\n' "''${choice%%$'\t'*}"
      '';
    };
  in {
    "xdg-desktop-portal/river-portals.conf".text = portalText;
    "xdg-desktop-portal/riverdev-portals.conf".text = portalText;
    "xdg-desktop-portal-wlr/config.ini".text = ''
      [screencast]
      chooser_type = simple
      chooser_cmd = ${lib.getExe portalChooser}
    '';
  };
  home.packages = with pkgs; [
    riverdo # Improved riverctl
    grim # Screenshot tool
    lswt # Command that lists Wayland toplevels
    ristate # River-status client written in Rust
    river-bedload # Display information about river in json in the STDOUT
    slurp # Area selection for screenshots/screensharing
    wayshot # Native, blazing-fast screenshot tool for wlroots based compositors such as sway and river
    wev # Wayland event viewer
    wlopm # Simple client implementing zwlr-output-power-management-v1
  ];
}
