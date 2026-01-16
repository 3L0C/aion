{
  config,
  inputs,
  lib,
  ...
}: {
  imports = [
    inputs.nixos-hardware.nixosModules.common-cpu-intel
    inputs.nixos-hardware.nixosModules.common-pc-laptop
    inputs.nixos-hardware.nixosModules.common-pc-ssd
    ../common/optional/nvidia.nix
    ../common/optional/fixes/asus-shutdown-fix.nix
  ];

  boot = {
    initrd = {
      availableKernelModules = [
        "xhci_pci"
        "thunderbolt"
        "vmd" # Intel Volume Management Device
        "nvme"
        "usbhid"
        "usb_storage"
        "sd_mod"
        "rtsx_pci_sdmmc" # SD card reader
      ];
      kernelModules = [
        "dm-snapshot"
        "cryptd"
      ];
      luks.devices.cryptroot = {
        device = "/dev/disk/by-label/NIXLUKS";
        allowDiscards = true; # SSD TRIM support
      };
    };

    kernelModules = [
      "kvm-intel"
      "asus_wmi" # ASUS WMI for backlight and hotkeys
    ];
    extraModulePackages = [];
    kernelParams = [
      "i915.enable_dpcd_backlight=1"
      "nvidia.NVreg_EnableBacklightHandler=0"
      "nvidia.NVReg_RegistryDwords=EnableBrightnessControl=0"
    ];
  };
  hardware.nvidia = {
    dynamicBoost.enable = true;

    prime = {
      intelBusId = "PCI:0:2:0";
      nvidiaBusId = "PCI:1:0:0"; # VERIFY ON ACTUAL HARDWARE!
      offload = {
        enable = true;
        enableOffloadCmd = true;
      };
    };
  };
  fileSystems."/" = {
    device = "/dev/disk/by-label/NIXROOT";
    fsType = "ext4";
  };
  fileSystems."/boot" = {
    device = "/dev/disk/by-label/SYSTEM";
    fsType = "vfat";
    options = [
      "fmask=0077"
      "dmask=0077"
    ];
  };

  swapDevices = [
    {device = "/dev/disk/by-label/NIXSWAP";}
  ];
  nix.settings.max-jobs = 24; # Core Ultra 9 285H has 24 threads

  hardware = {
    enableAllFirmware = true;
    cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  };
  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
  services.asusd = {
    enable = true;
    enableUserService = true;
  };

  # ROG keyboard function key mappings
  services.udev.extraHwdb = ''
    evdev:name:*:dmi:bvn*:bvr*:bd*:svnASUS*:pn*:*
      KEYBOARD_KEY_ff31007c=f20    # Fn+P -> mic mute
      KEYBOARD_KEY_ff3100b2=home   # Fn+Left -> Home
      KEYBOARD_KEY_ff3100b3=end    # Fn+Right -> End
  '';
}
