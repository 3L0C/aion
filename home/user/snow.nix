{...}: {
  imports = [
    ./global
    ./features/cli
    ./features/de/common
    ./features/de/apps
    ./features/de/file-thumbnails.nix
    ./features/de/hyprland-heim
    ./features/de/launcher
    ./features/de/mango
    ./features/de/notifications
    ./features/de/services/uwsm.nix
    ./features/de/services/waybar
    ./features/de/services/wk
    ./features/de/terminal
    ./features/de/wayland-tools.nix
    ./features/de/xdg-integration.nix
    ./features/dev
    ./features/media/mpv
    ./features/media/music.nix
    ./features/packages
    ./features/scripts
  ];
}
