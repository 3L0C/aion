{ lib, pkgs, ... }:
let
  mpv-persist-properties =
    pkgs.callPackage (lib.custom.relativeToRoot "pkgs/mpv/scripts/persist-properties.nix") {  };
in
{
  programs.mpv = {
    scripts = [ mpv-persist-properties ];
    scriptOpts = {
      persist_properties = {
        properties = "sub-pos";
      };
    };
  };
}
