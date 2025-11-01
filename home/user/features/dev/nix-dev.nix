{pkgs, ...}: {
  home.packages = with pkgs; [
    nixd # Nix language server for IDE integration
    nixfmt-rfc-style # Official Nix formatter (RFC 166 style)
  ];
}
