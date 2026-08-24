{
  perSystem = {pkgs, ...}: {
    packages.jellyproxy = pkgs.callPackage ./_jellyproxy {};
  };
}
