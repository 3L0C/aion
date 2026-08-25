# wk keybind popup for the oxbow session; the chords live in ./wks.
{ config, ... }:
let
  wkLib = config.flake.lib.wk;
in
{
  flake.modules.homeManager.oxbow =
    {
      pkgs,
      config,
      lib,
      ...
    }:
    let
      shared = wkLib { inherit pkgs config lib; };
    in
    {
      home.packages = [
        (shared.mkWkVariant {
          name = "oxbow";
          dir = ./wks;
        })
      ];
    };
}
