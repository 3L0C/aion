{inputs, ...}: {
  imports = [
    ./hyprland.nix
    ./hyprlock.nix
    ./master.nix
    ./plugins
    inputs.hyprland.homeManagerModules.default
  ];
}
