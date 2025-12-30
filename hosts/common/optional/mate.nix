{pkgs, ...}: {
  imports = [
    ./xserver.nix
  ];

  services.xserver.desktopManager.mate.enable = true;
  environment.mate.excludePackages = with pkgs.mate; [
    mate-terminal # We use kitty
  ];
}
