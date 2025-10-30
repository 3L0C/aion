{pkgs, ...}: {
  home.packages = with pkgs.custom.scripts; [
    nb              # Nix build helper
    bs              # Build script
    vidthumb        # Video thumbnail generator
    doomemacs       # Doom Emacs launcher
    hmpv            # MPV helper
    wip-test        # Test script
  ];
}
