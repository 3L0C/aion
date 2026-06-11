{
  inputs,
  pkgs,
}:
inputs
// {
  lanzaboote =
    inputs.lanzaboote
    // {
      nixosModules =
        inputs.lanzaboote.nixosModules
        // {
          lanzaboote = {
            imports = ["${pkgs.lanzaboote-src}/nix/modules/lanzaboote.nix"];
            boot.lanzaboote.package = inputs.lanzaboote.packages.${pkgs.stdenv.hostPlatform.system}.lzbt;
          };
        };
    };
}
