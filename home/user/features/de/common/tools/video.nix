{pkgs, ...}: {
  home.packages = with pkgs; [
    video-trimmer # Trim videos quickly
  ];
}
