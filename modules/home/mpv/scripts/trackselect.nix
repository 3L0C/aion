{ pkgs, localPkgsPath, ... }:
let
  trackselect = pkgs.callPackage (localPkgsPath + "/mpv/scripts/trackselect.nix") {  };
in
{
  programs.mpv = {
    scripts = [
      trackselect
    ];
  };
}
