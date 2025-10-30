{ lib, pkgs, ... }:
let
  trackselect = pkgs.callPackage (lib.custom.relativeToRoot "pkgs/mpv/scripts/trackselect.nix") {  };
in
{
  programs.mpv = {
    scripts = [
      trackselect
    ];
  };
}
