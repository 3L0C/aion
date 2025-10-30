{ inputs, pkgs, ... }:
{
  home.packages = [
    (inputs.wk.packages.${pkgs.system}.wk.override {
      patches = [
        ./config.patch
        ./key_chords.patch
      ];
    })
  ];
}
