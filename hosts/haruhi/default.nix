{...}: {
  imports = [
    ./disks.nix # Declarative disk partitioning (disko)
    ./hardware.nix
    ./mounts.nix
    ./syncthing.nix
    ../common/pc.nix
    ../common/optional/kmonad
    ../common/optional/lanzeboote.nix
    ../common/users/user
  ];

  system.stateVersion = "26.11";
}
