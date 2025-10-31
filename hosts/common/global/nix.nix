{
  pkgs,
  inputs,
  ...
}: {
  nix = {
    settings = {
      # Disable always-on store optimization (use scheduled instead)
      auto-optimise-store = false;

      experimental-features = [
        "nix-command"
        "flakes"
      ];

      # Binary cache substituters
      substituters = [
        "https://nix-community.cachix.org"
        "https://nix-gaming.cachix.org"
        "https://hyprland.cachix.org"
        "https://ghostty.cachix.org"
      ];

      trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4="
        "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
        "ghostty.cachix.org-1:QB389yTa6gTyneehvqG58y0WnHjQOqgnA+wBnpWWxns="
      ];

      # Performance and reliability settings
      connect-timeout = 5; # Faster timeout for unavailable caches
      log-lines = 25; # More build context in logs
      max-silent-time = 600; # 10-minute timeout for silent builds
      warn-dirty = false; # Don't warn about dirty git trees in flakes

      # Advertise system capabilities for distributed builds
      system-features = ["kvm" "big-parallel" "nixos-test"];
    };

    # Scheduled store optimization (more efficient than always-on)
    optimise = {
      automatic = true;
      dates = ["weekly"];
    };
  };

  nixpkgs = {
    overlays = [inputs.nur.overlays.default];
  };

  environment.systemPackages = with pkgs; [
    wget
    git
  ];
}
