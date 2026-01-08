{pkgs, ...}: {
  home.packages = with pkgs; [
    nixd # Nix language server for IDE integration
    nixfmt # Official Nix formatter (RFC 166 style)
  ];
}
