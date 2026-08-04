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
  boot.initrd.systemd.emergencyAccess = true;
  boot.kernelParams = ["rd.systemd.debug_shell=1"];

  system.stateVersion = "26.11";
}
