# KDE Plasma (Wayland) as a greetd session option, without SDDM
{
  flake.modules.nixos.kde = { pkgs, ... }: {
    # Do not import the wayland aspect here. plasma6 does its own
    # Wayland setup (portals, qt.platformTheme, dbus), and the forced
    # QT_QPA_PLATFORM can interfere.
    services.desktopManager.plasma6.enable = true;

    environment.plasma6.excludePackages = with pkgs.kdePackages; [
      elisa # Music player
      konsole # We use kitty
    ];
  };
}
