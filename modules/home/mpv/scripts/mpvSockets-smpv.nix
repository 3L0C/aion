{ pkgs, localPkgsPath, ... }:
let
  mpvSockets =
    pkgs.callPackage (localPkgsPath + "/mpv/scripts/mpvSockets-smpv.nix") {  };
in
{
  programs.mpv.scripts = [ mpvSockets ];
}
