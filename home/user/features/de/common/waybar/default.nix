{pkgs, ...}: {
  imports = [
    ./style.nix
  ];
  stylix.targets.waybar.addCss = false;

  # Statusbar scripts used by waybar modules
  home.packages = with pkgs.custom.scripts.statusbar; [
    sb-internet # Network status
  ];
}
