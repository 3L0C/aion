{...}: {
  imports = [
    ./disks.nix # Declarative disk partitioning (disko)
    ./hardware.nix
    ./syncthing.nix
    ./bootloader.nix
    ../common/pc.nix
    ../common/optional/kmonad
    ../common/users/user
  ];

  system.stateVersion = "26.05";
}
