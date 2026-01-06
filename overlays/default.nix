{inputs, ...}: {
  stable = final: _prev: {
    stable = import inputs.nixpkgs-stable {
      inherit (final.stdenv.hostPlatform) system;
      config = {
        allowUnfree = true;
      };
    };
  };
  custom-packages = final: _prev: {
    custom = import ../pkgs {pkgs = final;};
  };
  wk-overlay = final: _prev: {
    inherit (inputs.wk.packages.${final.stdenv.hostPlatform.system}) wk;
  };
  wk-prompt-overlay = final: _prev: {
    inherit (inputs.wk-prompt.packages.${final.stdenv.hostPlatform.system}) wk-prompt;
  };
  riverdo-overlay = final: _prev: {
    inherit (inputs.riverdo.packages.${final.stdenv.hostPlatform.system}) riverdo;
  };

  modifications = final: prev: {
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
    river-classic-test = prev.river-classic.overrideAttrs (oldAttrs: {
      patches =
        (oldAttrs.patches or [])
        ++ [
          (prev.fetchpatch {
            url = "https://codeberg.org/river/river-classic/commit/a46c0df7eddecab194719dd77ef487bc81f04e76.patch";
            hash = "sha256-6daRviNslFwcIcoRZxilfZv/oJTjqmj6VX7r8mJxTZY=";
          })
        ];
    });
    river-classic-test-no-session = final.river-classic-test.overrideAttrs (oldAttrs: {
      postInstall =
        (oldAttrs.postInstall or "")
        + ''
          rm -f $out/share/wayland-sessions/river.desktop
        '';
    });
  };
}
