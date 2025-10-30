{ lib, pkgs, ... }:
let
  stats = pkgs.callPackage (lib.custom.relativeToRoot "pkgs/mpv/scripts/stats.nix") {  };
in
{
  programs.mpv = {
    scripts = [
      stats
    ];
  };
}
