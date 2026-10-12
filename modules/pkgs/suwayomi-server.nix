{
  perSystem = { pkgs, ... }: {
    packages.suwayomi-server = pkgs.callPackage ./_suwayomi-server { };
  };
}
