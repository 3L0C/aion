{...}: {
  imports = [
    ./hardware.nix
    ./bootloader.nix
    ./zfs.nix
    ./mounts.nix
    ./ssh.nix
    ../common/headless.nix
    ../common/users/user
  ];
  system.stateVersion = "24.11";
}
