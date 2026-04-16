{pkgs, ...}: {
  imports = [
    ./style.nix
  ];
  stylix.targets.waybar.addCss = false;

  # Statusbar scripts used by waybar modules
  home.packages =
    (with pkgs.custom.scripts.statusbar; [
      sb-internet # Network status
      sb-mpris-json # MPRIS with Playing > Paused > Stopped priority
    ])
    ++ [
      pkgs.jq # Consumed by sb-mpris-json for JSON output
      pkgs.playerctl # Queried by sb-mpris-json and eww media-players.sh
    ];
}
