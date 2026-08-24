# pkgs.custom.* for the configurations. legacyPackages mirrors the
# flat packages and adds the nested sets, so `nix build .#scripts.nb`
# and the update-pkgs discovery walk keep working.
{config, ...}: let
  flakeConfig = config;
in {
  perSystem = {config, ...}: {
    legacyPackages = config.packages;
  };

  flake.overlays.custom = final: _prev: {
    custom =
      flakeConfig.flake.legacyPackages.${final.stdenv.hostPlatform.system}
      // {
        # scripts.vn takes wine-ge, an overlay attribute, so this set
        # builds against final instead of the flake output.
        scripts = final.lib.recurseIntoAttrs (final.callPackage ./_scripts {});
      };
  };
}
