{
  config,
  lib,
  pkgs,
  ...
}: let
  portalChooser = pkgs.writeShellApplication {
    name = "xdph-wlr-chooser";
    runtimeInputs = with pkgs; [rofi];
    text = ''
      exec rofi -dmenu -i -p "Screencast source"
    '';
  };

  envExports = lib.concatStringsSep "\n" (
    lib.mapAttrsToList (name: value: "export ${name}=${value}") config.wayland.envVars
  );
in {
  xdg.configFile = let
    portalText = ''
      [preferred]
      default=gtk
      org.freedesktop.impl.portal.ScreenCast=wlr
      org.freedesktop.impl.portal.Screenshot=wlr
      org.freedesktop.impl.portal.Inhibit=none
    '';
  in {
    "river-classic/init" = {
      executable = true;
      text = ''
        #!/usr/bin/env sh
        ${envExports}
        uwsm finalize
      '';
    };
    "xdg-desktop-portal/riverclassic-portals.conf".text = portalText;
    "xdg-desktop-portal-wlr/config.ini".text = lib.generators.toINI {} {
      screencast = {
        chooser_type = "dmenu";
        chooser_cmd = lib.getExe portalChooser;
      };
    };
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
