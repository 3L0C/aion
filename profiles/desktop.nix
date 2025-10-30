{inputs, ...}: {
  imports = [
    ./base.nix
    ../home/user/features/de/common
    ../home/user/features/de/apps
    ../home/user/features/de/hyprland-heim
    ../home/user/features/de/mango
    ../home/user/features/de/services/waybar
    ../home/user/features/de/services/wk
    inputs.mango.hmModules.mango
  ];
}
