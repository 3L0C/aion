{...}: {
  imports = [
    ./hardware.nix
    ./bootloader.nix
    ../common/pc.nix
    ../common/optional/laptop-sleep.nix
    ../common/users/user
  ];

  system.stateVersion = "26.05";
}
