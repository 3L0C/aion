{
  perSystem = {pkgs, ...}: {
    packages.update-pkgs = pkgs.callPackage ./_update-pkgs {};
  };
}
