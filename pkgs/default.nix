{pkgs}: let
  inherit (pkgs) callPackage;
in {
  jellyproxy = callPackage ./jellyproxy {};
  mpvScripts = callPackage ./mpv/scripts.nix {};
  mpv-scripts = callPackage ./mpv-scripts {};
  scripts = pkgs.lib.recurseIntoAttrs (callPackage ./scripts {});
  shiru = callPackage ./shiru {};
}
