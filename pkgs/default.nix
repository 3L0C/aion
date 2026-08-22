{pkgs}: let
  inherit (pkgs) callPackage;
in {
  openshot-qt = callPackage ./openshot-qt {};

  backup-mikuru = callPackage ./backup-mikuru {};
  jellyproxy = callPackage ./jellyproxy {};
  mpvScripts = callPackage ./mpv/scripts.nix {};

  mpvUserScripts = pkgs.lib.recurseIntoAttrs (callPackage ./mpv/user-scripts {});

  mpv-scripts = callPackage ./mpv-scripts {};

  scripts = pkgs.lib.recurseIntoAttrs (callPackage ./scripts {});

  update-pkgs = callPackage ./update-pkgs {};
}
