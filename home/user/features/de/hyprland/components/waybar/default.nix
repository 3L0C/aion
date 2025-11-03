{pkgs, ...}: {
  imports = [
    ./waybar.nix
  ];
  home.packages = with pkgs.custom.scripts;
    [
      hypr-layout # Hyprland layout display
    ]
    ++ (with statusbar; [
      sb-playerctl # Media player info
      sb-mpv # MPV player info
      sb-internet # Network status
    ]);
}
