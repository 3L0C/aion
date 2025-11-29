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
  riverdo-overlay = final: _prev: {
    inherit (inputs.riverdo.packages.${final.stdenv.hostPlatform.system}) riverdo;
  };
  claude-code-overlay = _final: prev: {
    claude-code = prev.claude-code.overrideAttrs {
      version = "2.0.51";

      src = prev.fetchurl {
        url = "https://registry.npmjs.org/@anthropic-ai/claude-code/-/claude-code-2.0.51.tgz";
        hash = "sha256-h7i7k0WdWhMgFhg4i2dTsYM/u94aZRcaJNCvJfJ7AC4=";
      };
    };
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
