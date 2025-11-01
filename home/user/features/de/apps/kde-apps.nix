{pkgs, ...}: {
  home.packages = with pkgs; [
    kdePackages.dolphin # Advanced file manager
    kdePackages.okular # Universal document viewer (PDF, ePub, etc.)
    kdePackages.filelight # Disk usage visualizer
    pavucontrol # PulseAudio/PipeWire volume control
  ];
}
