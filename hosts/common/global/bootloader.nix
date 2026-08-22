{pkgs, ...}: {
  boot = {
    # Zen kernel: better for Wine/gaming than Xanmod
    kernelPackages = pkgs.linuxPackages_zen;

    # LZ4 initrd: trades compression ratio for faster decompression at boot
    initrd = {
      compressor = pkgs: "${pkgs.lz4.out}/bin/lz4";
      compressorArgs = [
        "-l" # Legacy format for better compatibility
        "-10"
        "--favor-decSpeed"
      ];
    };

    # /tmp stays on the root disk and is cleared at boot. A tmpfs would
    # compete with large Nix builds for memory.
    tmp.cleanOnBoot = true;

    loader = {
      systemd-boot = {
        enable = true;
        configurationLimit = 10;
        consoleMode = "max";
        editor = false; # Boot menu editor allows init= root escalation
      };
      efi.canTouchEfiVariables = true;
    };

    supportedFilesystems = [
      "ext4"
      "vfat"
      "ntfs"
      "btrfs"
      "xfs"
      "nfs"
      "cifs"
      "iso9660"
      "squashfs"
    ];
  };
}
