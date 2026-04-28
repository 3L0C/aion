{...}: {
  imports = [
    ./hardware.nix
    ./disks.nix
    ./mounts.nix
    ./syncthing.nix
    ./bootloader.nix
    ../common/pc.nix
    ../common/users/user
    ../common/optional/fixes/usb-wake-fix.nix
    ../common/optional/fixes/amdgpu-sdma-fix.nix
    ../common/optional/ollama.nix
  ];
  system.stateVersion = "26.05";
}
