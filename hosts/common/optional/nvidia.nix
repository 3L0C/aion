{lib, ...}: {
  services.xserver.videoDrivers = ["nvidia"];

  hardware.nvidia = {
    open = lib.mkDefault true;
    modesetting.enable = lib.mkDefault true;
    powerManagement.enable = lib.mkDefault true;
  };
  boot.kernelParams = [
    "nvidia-drm.modeset=1"
    "nouveau.modeset=0"
    "nvidia.NVreg_PreserveVideoMemoryAllocations=1"
  ];
}
