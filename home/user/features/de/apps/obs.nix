{pkgs, ...}: {
  home.packages = with pkgs; [
    obs-studio # Free, open source software for live streaming and recording
  ];
}
