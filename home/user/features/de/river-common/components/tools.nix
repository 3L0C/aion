{pkgs, ...}: {
  home.packages = with pkgs; [
    grim # Screenshot tool
    slurp # Area selection for screenshots/screensharing
    wayshot # Native, blazing-fast screenshot tool
    wev # Wayland event viewer
    wlopm # Simple client implementing zwlr-output-power-management-v1
  ];
}
