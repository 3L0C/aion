{pkgs, ...}: {
  boot = {
    loader = {
      systemd-boot = {
        enable = true;
        configurationLimit = 10;
      };
      efi.canTouchEfiVariables = true;
    };
    kernelPackages = pkgs.linuxPackages_zen;
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
