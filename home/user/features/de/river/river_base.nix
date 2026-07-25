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
    "river/init" = {
      executable = true;
      text = ''
        #!/usr/bin/env sh
        ${envExports}

        # Notify UWSM that River is ready
        uwsm finalize
      '';
    };
    "xdg-desktop-portal/river-portals.conf".text = portalText;
    "xdg-desktop-portal-wlr/config.ini".text = lib.generators.toINI {} {
      screencast = {
        chooser_type = "dmenu";
        chooser_cmd = lib.getExe portalChooser;
      };
    };
  };
}
