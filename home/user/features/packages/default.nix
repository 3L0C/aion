{...}: {
  imports = [
    ./local.nix # Locally-built packages from pkgs/
    ./system.nix # System services and hardware support
    ./system-libs.nix # System-level compatibility libraries
  ];
}
