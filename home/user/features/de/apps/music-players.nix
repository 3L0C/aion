{pkgs, ...}: {
  home.packages = with pkgs; [
    feishin # Modern music player for Jellyfin/Subsonic
    supersonic # Lightweight music player for Subsonic-compatible servers
  ];
}
