{
  lib,
  pkgs,
  ...
}: {
  boot = {
    kernelPackages = lib.mkForce pkgs.linuxPackages;

    supportedFilesystems = ["zfs"];
    zfs = {
      forceImportRoot = false;
      extraPools = ["tank"]; # Import existing pool at boot
    };
  };
  boot.zfs.requestEncryptionCredentials = ["tank"];
  services.zfs = {
    autoScrub = {
      enable = true;
      interval = "monthly";
    };
    autoSnapshot = {
      enable = true;
      frequent = 4; # Keep 4 15-minute snapshots
      hourly = 24;
      daily = 7;
      weekly = 4;
      monthly = 12;
    };
    trim.enable = false; # HDDs don't support TRIM
  };
  networking.hostId = "43973e50";
}
