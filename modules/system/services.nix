{
  flake.modules.nixos.services = { pkgs, ... }: {
    services = {
      dbus = {
        enable = true;

        # needed for GNOME services outside of GNOME Desktop
        packages = with pkgs; [
          gcr
          gnome-settings-daemon
        ];
      };

      fstrim.enable = true;
      gvfs.enable = true;

      # don't shutdown when power button is short-pressed
      logind.settings.Login.HandlePowerKey = "ignore";
    };
  };
}
