{
  perSystem = { pkgs, ... }: {
    packages.openshot-qt = pkgs.callPackage ./_openshot-qt { };
  };
}
