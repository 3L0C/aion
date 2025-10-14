{ pkgs, localPkgsPath, ... }:
let
  stats = pkgs.callPackage (localPkgsPath + "/mpv/scripts/stats.nix") {  };
in
{
  programs.mpv = {
    scripts = [
      stats
    ];
  };
}
