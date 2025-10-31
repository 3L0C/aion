{
  lib,
  pkgs,
  ...
}: {
  wayland.windowManager.hyprland.settings = {
    ecosystem = {
      enforce_permissions = true;
    };
    permission = [
      "${lib.escapeRegex (lib.getExe pkgs.grim)}, screencopy, allow"
      "${lib.escapeRegex (lib.getExe pkgs.hyprlock)}, screencopy, allow"
      "${lib.escapeRegex (lib.getExe pkgs.xdg-desktop-portal-hyprland)}, screencopy, allow"
    ];
  };
}
