# MPV lua script set; follows nixpkgs pkgs/applications/video/mpv/scripts.nix
{
  lib,
  pkgs,
}:
lib.pipe
{
  inherit (pkgs) callPackage;
  directory = ./scripts;
}
[
  lib.packagesFromDirectoryRecursive
  lib.recurseIntoAttrs
]
