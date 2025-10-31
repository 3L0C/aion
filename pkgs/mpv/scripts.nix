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
