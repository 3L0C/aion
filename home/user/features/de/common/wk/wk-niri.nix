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
      name = "niri";
      entryPoint = "niri/niri_key_chords.wks";
    })
  ];
}
