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
    river-classic-dev = prev.river-classic.overrideAttrs {
      version = "dev-${inputs.river-classic-src.shortRev or "unknown"}";
      src = inputs.river-classic-src;
      doInstallCheck = false;
    };
    river-classic-dev-no-session = let
      unwrapped = final.river-classic-dev.overrideAttrs (oldAttrs: {
        postInstall =
          (oldAttrs.postInstall or "")
          + ''
            rm -f $out/share/wayland-sessions/river.desktop
            mv $out/bin/river $out/bin/riverdev
            ln -s riverdev $out/bin/river
          '';
        meta =
          (oldAttrs.meta or {})
          // {
            mainProgram = "riverdev";
          };
      });
    in
      unwrapped;
  };
}
