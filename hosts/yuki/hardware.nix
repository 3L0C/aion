{
  config,
  inputs,
  lib,
  ...
}: {
  imports = [
    inputs.nixos-hardware.nixosModules.common-cpu-amd
    inputs.nixos-hardware.nixosModules.common-gpu-amd
    inputs.nixos-hardware.nixosModules.common-pc-ssd
  ];

  boot = {
    initrd = {
      availableKernelModules = [
        "xhci_pci"
        "ahci"
        "nvme"
        "usbhid"
        "usb_storage"
      ];
      kernelModules = [
        "dm-snapshot"
        "cryptd"
      ];

      # Enable systemd in initrd for FIDO2 LUKS support
      systemd.enable = true;
      luks.devices = {
        nixcrypt = {
          device = "/dev/disk/by-label/NIXLUKS";
          allowDiscards = true;
          crypttabExtraOpts = [
            "fido2-device=auto"
            "token-timeout=30"
          ];
        };
      };
    };
    kernelModules = [
      "kvm-amd"
    ];
    extraModulePackages = [];
  };
  fileSystems."/" = {
    device = "/dev/disk/by-label/NIXROOT";
    fsType = "ext4";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-label/NIXBOOT";
    fsType = "vfat";
    options = [
      "fmask=0077"
      "dmask=0077"
    ];
  };

  swapDevices = [
    {device = "/dev/disk/by-label/NIXSWAP";}
  ];

  nix.settings.max-jobs = 16;
  hardware = {
    enableAllFirmware = true; # Helps with compatibility
    xone.enable = true; # Enable the xone driver for xbox one, etc. accessories
    cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  };
  powerManagement.cpuFreqGovernor = lib.mkDefault "performance";
}
