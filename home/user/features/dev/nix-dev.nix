{pkgs, ...}: {
  home.packages = with pkgs; [
    nixd # Nix language server
    nixfmt # Official Nix formatter (RFC 166 style)
  ];
}
