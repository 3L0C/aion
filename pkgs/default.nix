{pkgs}: let
  inherit (pkgs) callPackage;
in {
  jellyproxy = callPackage ./jellyproxy {};
  mpvScripts = callPackage ./mpv/scripts.nix {};
  mpvUserScripts = pkgs.lib.recurseIntoAttrs (callPackage ./mpv/user-scripts {});
  mpv-scripts = callPackage ./mpv-scripts {};
  scripts = pkgs.lib.recurseIntoAttrs (callPackage ./scripts {});
  shiru = callPackage ./shiru {};
  river-shifttags = callPackage ./river-shifttags {};
  update-pkgs = callPackage ./update-pkgs {};
}
