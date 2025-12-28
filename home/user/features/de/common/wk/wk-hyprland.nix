{
  pkgs,
  config,
  lib,
  ...
}: let
  shared = import ./shared.nix {inherit pkgs config lib;};
in {
  home.packages = [
    (shared.mkWkVariant {
      name = "hyprland";
      entryPoint = "hyprland/hyprland_key_chords.wks";
    })
  ];
}
