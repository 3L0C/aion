{ lib, pkgs, ... }:
let
  mpvSockets =
    pkgs.callPackage (lib.custom.relativeToRoot "pkgs/mpv/scripts/mpvSockets-smpv.nix") {  };
in
{
  programs.mpv.scripts = [ mpvSockets ];
}
