{
  config,
  inputs,
  lib,
  ...
}: {
  imports = [
    inputs.nixos-hardware.nixosModules.common-cpu-intel
    "${inputs.nixos-hardware}/common/gpu/intel/lunar-lake"
    "${inputs.nixos-hardware}/common/gpu/nvidia/blackwell"
    inputs.nixos-hardware.nixosModules.common-pc-laptop
    inputs.nixos-hardware.nixosModules.common-pc-ssd
    ../common/optional/nvidia.nix
    ../common/optional/power.nix
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

      # Enable systemd in initrd for FIDO2 LUKS support
      systemd.enable = true;
    };

    kernelModules = [
      "kvm-intel"
      "asus_wmi" # ASUS WMI for backlight and hotkeys
    ];
    extraModulePackages = [];
    kernelParams = [
      "nvidia.NVreg_EnableBacklightHandler=0"
      "nvidia.NVreg_RegistryDwords=EnableBrightnessControl=0"
      "i915.enable_dpcd_backlight=1"
    ];
  };
  hardware.nvidia = {
    dynamicBoost.enable = true;
    powerManagement.finegrained = true;

    prime = {
      intelBusId = "PCI:0:2:0";
      nvidiaBusId = "PCI:1:0:0";
      offload = {
        enable = true;
        enableOffloadCmd = true;
      };
    };
  };

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
