{
  perSystem = {pkgs, ...}: {
    legacyPackages = {
      mpvScripts = pkgs.callPackage ./_mpv/scripts.nix {};
      mpvUserScripts =
        pkgs.lib.recurseIntoAttrs (pkgs.callPackage ./_mpv/user-scripts {});
    };
  };
}
