{inputs, ...}: {
  imports = [
    ../../profiles/desktop.nix      # Desktop environment (includes base)
    ../../profiles/development.nix  # Dev tools
    ../../profiles/media.nix        # Media applications
  ];
}
