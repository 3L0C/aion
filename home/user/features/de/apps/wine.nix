{pkgs, ...}: {
  home.packages = with pkgs; [
    wineWowPackages.waylandFull # Wine with Wayland support (32-bit and 64-bit)
    winetricks # Helper script for installing Windows libraries in Wine
  ];
}
