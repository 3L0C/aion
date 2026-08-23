# Nix daemon and package manager configuration
{
  flake.modules.nixos.nix = {
    lib,
    pkgs,
    ...
  }: {
    nix = {
      # Use Lix (from nixpkgs) in place of CppNix.
      package = pkgs.lixPackageSets.latest.lix;

      # https://github.com/NixOS/nix/issues/2982
      channel.enable = false;

      # Scheduled store optimization (more efficient than always-on)
      optimise = {
        automatic = true;
        dates = ["weekly"];
      };

      extraOptions = ''
        accept-flake-config = true
      '';

      settings = {
        # Disable always-on store optimization (use scheduled instead)
        auto-optimise-store = false;
        allow-import-from-derivation = lib.mkDefault true;
        allowed-users = lib.mkDefault ["root" "@wheel"];
        trusted-users = lib.mkForce ["@wheel"];

        # Binary cache substituters
        extra-substituters = lib.mkAfter [
          "https://nix-community.cachix.org"
          "https://nix-gaming.cachix.org"
        ];

        extra-trusted-public-keys = [
          "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
          "nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4="
        ];

        # Performance and reliability settings
        connect-timeout = 10; # Faster timeout for unavailable caches
        log-lines = 25; # More build context in logs
        max-silent-time = 600; # 10-minute timeout for silent builds
        warn-dirty = false; # Don't warn about dirty git trees in flakes

        experimental-features = [
          "nix-command"
          "flakes"
        ];

        # Advertise system capabilities for distributed builds
        system-features = [
          "kvm"
          "big-parallel"
          "nixos-test"
        ];
      };
    };

    programs.nix-ld.enable = true;
  };
}
