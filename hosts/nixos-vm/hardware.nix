# Hardware configuration for the QEMU/KVM virtual machine.
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
        "virtio_gpu" # Necessary for Wayland compositors in the VM.
        "sr_mod"
        "virtio_blk"
      ];
      kernelModules = [];
    };
    kernelModules = ["kvm-amd" "virtio_gpu"];
    extraModulePackages = [];
  };

  # disko provides / and /boot (see ./disks.nix).
  fileSystems = {
    # virtiofs mounts from the host.
    "/home/user/aion" = {
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
