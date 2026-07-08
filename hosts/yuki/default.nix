{...}: {
  imports = [
    ./hardware.nix
    ./disks.nix
    ./mounts.nix
    ./syncthing.nix
    ../common/pc.nix
    ../common/users/user
    ../common/optional/fixes/usb-wake-fix.nix
    ../common/optional/fixes/amdgpu-sdma-fix.nix
    ../common/optional/lanzeboote.nix
    ../common/optional/ollama.nix
    ../common/optional/open-webui.nix
  ];
  system.stateVersion = "26.11";
}
