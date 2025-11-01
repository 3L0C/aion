{...}: {
  imports = [
    ./waybar.nix
    ./settings.nix
    ./style.nix
    ./mango # Mango-specific waybar configuration
  ];
}
