{...}: {
  imports = [
    ./hardware.nix
    ./syncthing.nix
    ./bootloader.nix
    ../common/pc.nix
    ../common/users/user
  ];

  system.stateVersion = "26.05";
}
