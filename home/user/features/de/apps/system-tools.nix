{pkgs, ...}: {
  home.packages = with pkgs; [
    gnome-disk-utility # Disk management and SMART monitoring
    mission-center # System resource monitor (modern htop alternative)
    pcmanfm # Lightweight file manager
    sioyek # PDF viewer optimized for technical documents
    video-trimmer # Simple video trimmer
    xchm # CHM file viewer
  ];
}
