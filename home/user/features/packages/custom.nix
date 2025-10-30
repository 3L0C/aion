{ lib, pkgs, ... }:
let
  _mpv-scripts = pkgs.callPackage (lib.custom.relativeToRoot "pkgs/mpv-scripts/default.nix") {  };
in
{
  home.packages = [
    _mpv-scripts
  ];
}
