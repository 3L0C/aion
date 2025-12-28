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
      name = "river";
      entryPoint = "river/river_key_chords.wks";
    })
  ];
}
