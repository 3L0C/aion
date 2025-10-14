{ pkgs, localPkgsPath, ... }:
let
  _mpv-scripts = pkgs.callPackage (localPkgsPath + "/mpv-scripts/default.nix") {  };
in
{
  home.packages = [
    _mpv-scripts
  ];
}
