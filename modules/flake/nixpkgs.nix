{
  config,
  inputs,
  ...
}:
{
  flake.overlays = {
    stable = final: _prev: {
      stable = import inputs.nixpkgs-stable {
        inherit (final.stdenv.hostPlatform) system;
        config.allowUnfree = true;
      };
    };

    master = final: _prev: {
      master = import inputs.nixpkgs-master {
        inherit (final.stdenv.hostPlatform) system;
        config.allowUnfree = true;
      };
    };

    wk = inputs.wk.overlays.default;

    wk-prompt = final: _prev: {
      inherit (inputs.wk-prompt.packages.${final.stdenv.hostPlatform.system}) wk-prompt;
    };

    oxbow = inputs.oxbow.overlays.default;

    wine-ge = final: _prev: {
      inherit (inputs.nix-gaming.packages.${final.stdenv.hostPlatform.system}) wine-ge;
    };

    # Lix-linked builds of tools that hardcode a Nix reference, for
    # ad-hoc `nix run`. Namespaced under pkgs.lixTools.*: shadowing the
    # canonical attrs caused infinite recursion (nix-update ->
    # nixpkgs-review -> itself through the overlay).
    lix = _final: prev: {
      lixTools = {
        inherit (prev.lixPackageSets.latest)
          nixpkgs-review
          nix-eval-jobs
          nix-fast-build
          colmena
          ;
      };
    };

    modifications = final: prev: {
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
        postInstall = (oldAttrs.postInstall or "") + ''
          # Add custom base16 schemes
          install ${./nixpkgs/schemes}/*.yaml $out/share/themes/
        '';
      });

      # River without a session file
      river-no-session = final.master.river.overrideAttrs (oldAttrs: {
        postInstall = (oldAttrs.postInstall or "") + ''
          # Remove the plain river.desktop session file
          rm -f $out/share/wayland-sessions/river.desktop
        '';
      });
    };
  };

  flake.modules.nixos.nixpkgs-setup = {
    nixpkgs = {
      overlays = builtins.attrValues config.flake.overlays;
      config.allowUnfree = true;
    };
  };
}
