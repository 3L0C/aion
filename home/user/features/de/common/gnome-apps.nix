{pkgs, ...}: {
  home.packages = with pkgs; [
    gnome-disk-utility # Disk management and SMART monitoring
    mission-center # System resource monitor (modern htop alternative)
  ];
}
