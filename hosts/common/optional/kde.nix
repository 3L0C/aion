# KDE Plasma (Wayland) as a greetd session option, without SDDM
{pkgs, ...}: {
  services.desktopManager.plasma6.enable = true;

  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    elisa # Music player
    konsole # We use kitty
  ];
}
