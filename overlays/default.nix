{inputs, ...}: {
  stable = final: _prev: {
    stable = import inputs.nixpkgs-stable {
      inherit (final.stdenv.hostPlatform) system;
      config = {
        allowUnfree = true;
      };
    };
  };
  master = final: _prev: {
    master = import inputs.nixpkgs-master {
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
  ocdwm-overlay = final: _prev: {
    inherit (inputs.ocdwm.packages.${final.stdenv.hostPlatform.system}) ocdwm;
  };
  wine-ge-overlay = final: _prev: {
    inherit (inputs.nix-gaming.packages.${final.stdenv.hostPlatform.system}) wine-ge;
  };
  lix = _final: prev: {
    lixTools = {
      inherit
        (prev.lixPackageSets.latest)
        nixpkgs-review
        nix-eval-jobs
        nix-fast-build
        colmena
        ;
    };
  };
  modifications = _final: prev: let
    river-patched = prev.river.overrideAttrs (oldAttrs: {
      patches =
        (oldAttrs.patches or [])
        ++ [
          (prev.fetchpatch {
            name = "cursor-fix-window-jittering.patch";
            url = "https://codeberg.org/river/river/commit/d4fef528467974b9014b0bc9c47a9ea682cc8d4b.patch";
            hash = "sha256-88YZMUjo9fDz5OT6glI8wCrUolUOa7K15bN7DBNFUAQ=";
          })
          (prev.fetchpatch {
            name = "seat-pointer-warp-before-op.patch";
            url = "https://codeberg.org/river/river/commit/01e63f8d5b76d94f56e86519f8bde34486a12475.patch";
            hash = "sha256-Z/JHrk9kUkyuRbEw98h1WKCtAtIKUReVPrdFreSf3jw=";
          })
        ];
    });
  in {
    openldap = prev.openldap.overrideAttrs {
      doCheck = !prev.stdenv.hostPlatform.isi686;
    };

    # xdg-desktop-portal-wlr: build from master for PipeWire 1.6.x fix and
    # screencast improvements (buffer flags, damage reporting) not in 0.8.1
    xdg-desktop-portal-wlr = prev.xdg-desktop-portal-wlr.overrideAttrs {
      version = "0.8.1-unstable-2026-03-19";
      src = prev.fetchFromGitHub {
        owner = "emersion";
        repo = "xdg-desktop-portal-wlr";
        rev = "896cee82a6f14ee996fb870c0fc5e27533e37907";
        hash = "sha256-uQYXGiMmrMHCygh5IHt90NSZLPbY7uVMyDx8zUTHXaM=";
      };
    };

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
          mv $out/bin/river $out/bin/river-classic
        '';

      meta =
        oldAttrs.meta
        // {
          mainProgram = "river-classic";
        };
    });
    river = river-patched;
    river-no-session = river-patched.overrideAttrs (oldAttrs: {
      postInstall =
        (oldAttrs.postInstall or "")
        + ''
          # Remove the plain river.desktop session file
          rm -f $out/share/wayland-sessions/river.desktop
        '';
    });
  };
}
