{...}: {
  imports = [
    ./cli.nix
    ./custom.nix
    ./dev.nix
    ./system.nix
    ./gui.nix
    ./temp-dev-packages.nix
    ./temp-system-packages.nix
    ./temp-user-packages.nix
  ];
}
