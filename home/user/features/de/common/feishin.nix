{pkgs, ...}: {
  home.packages = with pkgs; [
    feishin # Modern music player for Jellyfin/Subsonic
  ];
}
