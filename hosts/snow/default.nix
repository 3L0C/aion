{...}: {
  imports = [
    ./hardware.nix
    ./mounts.nix
    ./syncthing.nix
    ./bootloader.nix
    ../common/pc.nix
    ../common/users/user
    ../common/optional/fixes/usb-wake-fix.nix
  ];
  system.stateVersion = "26.05";
}
