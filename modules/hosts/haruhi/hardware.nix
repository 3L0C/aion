# haruhi: ASUS ROG Zephyrus G16 2025 (GU605CR)
# Intel Core Ultra 9 285H (Arrow Lake H) + NVIDIA RTX 5070 Ti (Blackwell)
{
  flake.modules.nixos."hosts/haruhi" = {
    config,
    inputs,
    lib,
    ...
  }: {
    imports =
      [
        # Arrow Lake iGPU uses the same architecture as Lunar Lake.
        # This module enables the xe driver and VAAPI.
        "${inputs.nixos-hardware}/common/gpu/intel/lunar-lake"
        "${inputs.nixos-hardware}/common/gpu/nvidia/blackwell"
      ]
      ++ (with inputs.nixos-hardware.nixosModules; [
        common-cpu-intel
        common-pc-laptop
        common-pc-ssd
      ])
      ++ (with config.flake.modules.nixos; [
        nvidia
        power
        asus-shutdown-fix
      ]);

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

        # systemd in initrd is necessary for FIDO2 LUKS unlock.
        systemd.enable = true;
      };

      kernelModules = [
        "kvm-intel"
        "asus_wmi" # ASUS WMI for backlight and hotkeys
      ];
      extraModulePackages = [];

      # OLED backlight fix: disable the NVIDIA backlight handlers so Intel controls the panel.
      # Reference: https://bbs.archlinux.org/viewtopic.php?id=305237
      kernelParams = [
        "nvidia.NVreg_EnableBacklightHandler=0"
        "nvidia.NVreg_RegistryDwords=EnableBrightnessControl=0"
        "i915.enable_dpcd_backlight=1"
      ];
    };

    hardware.nvidia = {
      dynamicBoost.enable = true;

      # RTD3: the dGPU can power down fully. This needs offload mode.
      powerManagement.finegrained = true;

      prime = {
        # Bus IDs confirmed with lspci. Do not change without a new lspci check.
        intelBusId = "PCI:0:2:0";
        nvidiaBusId = "PCI:1:0:0";

        # Run an app on the dGPU with: nvidia-offload <command>
        offload = {
          enable = true;
          enableOffloadCmd = true;
        };
      };
    };

    nix.settings.max-jobs = 24; # Core Ultra 9 285H has 24 threads

    hardware = {
      cpu.intel.updateMicrocode =
        lib.mkDefault config.hardware.enableRedistributableFirmware;
    };

    powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";

    # ASUS ROG daemon: keyboard backlight, fan control, power profiles.
    services.asusd = {
      enable = true;
    };

    # ROG keyboard function key mappings
    services.udev.extraHwdb = ''
      evdev:name:*:dmi:bvn*:bvr*:bd*:svnASUS*:pn*:*
        KEYBOARD_KEY_ff31007c=f20    # Fn+P -> mic mute
        KEYBOARD_KEY_ff3100b2=home   # Fn+Left -> Home
        KEYBOARD_KEY_ff3100b3=end    # Fn+Right -> End
    '';
  };
}
