{
  flake.modules.nixos.services = { pkgs, ... }: {
    services = {
      dbus = {
        enable = true;

        # needed for GNOME services outside of GNOME Desktop
        packages = with pkgs; [
          gcr_4 # GNOME crypto services (daemon and tools)
          gnome-settings-daemon # GNOME Settings Daemon
        ];
      };

      fstrim.enable = true;
      gvfs.enable = true;

      # don't shutdown when power button is short-pressed
      logind.settings.Login.HandlePowerKey = "ignore";
    };
  };
}
