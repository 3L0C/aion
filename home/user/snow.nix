{
  inputs,
  ...
}: {
  imports = [
    ./global
    ./features/de/common
    ./features/de/apps
    ./features/de/hyprland-heim  # Heim approach: nixpkgs, no plugins
    ./features/de/mango
    ./features/de/services/waybar
    ./features/de/services/wk
    ./features/dev
    ./features/media/mpv
    ./features/packages
    ./features/scripts
    inputs.mango.hmModules.mango
  ];
}
