{pkgs, ...}: {
  home.packages = with pkgs; [
    xchm # Viewer for Microsoft HTML Help files
  ];
}
