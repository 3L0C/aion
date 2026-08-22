{pkgs, ...}: {
  home.packages = with pkgs; [
    custom.openshot-qt # Free, open-source video editor
  ];
}
