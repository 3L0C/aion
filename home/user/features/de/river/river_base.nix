{
  config,
  lib,
  ...
}: let
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
  };
}
