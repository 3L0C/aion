{pkgs, ...}: {
  home.packages = with pkgs.custom.scripts; [
    nb # Nix build helper
    ne # Nix Eval helper for quick flake introspection
  ];
}
