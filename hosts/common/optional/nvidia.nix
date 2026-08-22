{lib, ...}: {
  services.xserver.videoDrivers = ["nvidia"];

  hardware.nvidia = {
    # Open kernel modules: required for Turing+ (RTX 20+), mandatory for
    # Blackwell (RTX 50+); the proprietary driver does not support Blackwell.
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
