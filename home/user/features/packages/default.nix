{...}: {
  imports = [
    ./local.nix # Locally-built packages from pkgs/
    ./system-libs.nix # System-level compatibility libraries
  ];
}
