{inputs, ...}: let
  addPatches = pkg: patches:
    pkg.overrideAttrs (oldAttrs: {
      patches = (oldAttrs.patches or []) ++ patches;
    });
in {
  stable = final: _prev: {
    stable = import inputs.nixpkgs-stable {
      inherit (final) system;
      config = {
        allowUnfree = true;
      };
    };
  };
  custom-packages = final: _prev: {
    custom = import ../pkgs {pkgs = final;};
  };
  wk-overlay = final: _prev: {
    wk-patched = addPatches inputs.wk.packages.${final.system}.wk [
      ./wk-patches/config.patch
      ./wk-patches/key_chords.patch
    ];
  };
  modifications = _final: prev: {
    base16-schemes = prev.base16-schemes.overrideAttrs (oldAttrs: {
      postInstall =
        (oldAttrs.postInstall or "")
        + ''
          # Add custom base16 schemes
          install ${./schemes}/*.yaml $out/share/themes/
        '';
    });
    river-classic-no-session = prev.river-classic.overrideAttrs (oldAttrs: {
      postInstall =
        (oldAttrs.postInstall or "")
        + ''
          # Remove the plain river.desktop session file
          rm -f $out/share/wayland-sessions/river.desktop
        '';
    });
  };
}
