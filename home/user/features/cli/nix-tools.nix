{pkgs, ...}: {
  home.packages = with pkgs.custom.scripts; [
    nb # Nix build helper
  ];
}
