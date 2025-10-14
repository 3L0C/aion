{ pkgs, ... }:
{
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.systemd-boot.configurationLimit = 10;
  boot.kernelPackages = pkgs.linuxPackages_zen;
  boot.supportedFilesystems = [ 
    "ext4" "vfat" "ntfs" "btrfs" "xfs" 
    "nfs" "cifs" "iso9660" "squashfs" 
  ];
}
