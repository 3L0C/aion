{ pkgs, localPkgsPath, ... }:
let
  mpv-persist-properties =
    pkgs.callPackage (localPkgsPath + "/mpv/scripts/persist-properties.nix") {  };
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
