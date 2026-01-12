{...}: {
  imports = [
    ./hardware.nix
    ./bootloader.nix
    ./zfs.nix
    ./ssh.nix
    ./modules/nfs-export.nix
    ./modules/jellyfin.nix
    ../common/headless.nix
    ../common/users/user
  ];
  system.stateVersion = "24.11";
}
