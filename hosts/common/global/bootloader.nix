{pkgs, ...}: {
  boot = {
    loader = {
      systemd-boot = {
        enable = true;
        configurationLimit = 10;
        consoleMode = "max"; # Maximum console resolution
        editor = false; # Disable boot menu editor for security
      };
      efi.canTouchEfiVariables = true;
    };
    kernelPackages = pkgs.linuxPackages_zen;
    initrd = {
      compressor = pkgs: "${pkgs.lz4.out}/bin/lz4";
      compressorArgs = [
        "-l" # Legacy format for better compatibility
        "-10" # Maximum compression level for LZ4
        "--favor-decSpeed" # Optimize for decompression speed
      ];
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
