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
      name = "river-classic";
      entryPoint = "river-classic/river_key_chords.wks";
    })
  ];
}
