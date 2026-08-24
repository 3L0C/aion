{
  perSystem = {pkgs, ...}: {
    legacyPackages.scripts =
      pkgs.lib.recurseIntoAttrs (pkgs.callPackage ./_scripts {});
  };
}
