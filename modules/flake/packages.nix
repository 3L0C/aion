{
  flake.overlays.custom = final: _prev: {
    custom = import ../../pkgs {pkgs = final;};
  };

  perSystem = {pkgs, ...}: {
    legacyPackages = import ../../pkgs {inherit pkgs;};
  };
}
