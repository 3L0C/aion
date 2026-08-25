{ inputs, ... }: {
  flake.modules.nixos."hosts/yuki" =
    {
      config,
      lib,
      ...
    }:
    {
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
        };

        kernelModules = [
          "kvm-amd"
        ];

        extraModulePackages = [ ];
      };

      nix.settings.max-jobs = 16;

      hardware = {
        xone.enable = true; # Enable the xone driver for xbox one, etc. accessories
        cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
      };

      powerManagement.cpuFreqGovernor = lib.mkDefault "performance";
    };
}
