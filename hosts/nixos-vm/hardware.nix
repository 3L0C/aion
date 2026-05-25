{
  lib,
  modulesPath,
  ...
}: {
  imports = [
    (modulesPath + "/profiles/qemu-guest.nix")
  ];

  boot = {
    initrd = {
      availableKernelModules = [
        "ahci"
        "xhci_pci"
        "virtio_pci"
        "virtio_gpu" # Required for Wayland compositors in VM
        "sr_mod"
        "virtio_blk"
      ];
      kernelModules = [];
    };
    kernelModules = ["kvm-amd" "virtio_gpu"];
    extraModulePackages = [];
  };

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-uuid/5f098dc9-e496-43ab-8022-ce5095bd882f";
      fsType = "ext4";
    };

    "/boot" = {
      device = "/dev/disk/by-uuid/3AB3-2FF4";
      fsType = "vfat";
      options = [
        "fmask=0077"
        "dmask=0077"
      ];
    };
    "/mnt/aion" = {
      device = "aion";
      fsType = "virtiofs";
    };
    "/home/user/Projects" = {
      device = "Projects";
      fsType = "virtiofs";
    };
  };

  swapDevices = [];

  networking.hostName = "nixos-vm";
  networking.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

  hardware.graphics.enable = true;
}
