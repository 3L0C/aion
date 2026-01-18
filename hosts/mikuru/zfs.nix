{
  lib,
  pkgs,
  ...
}: {
  environment.systemPackages = [pkgs.zfs];
  boot = {
    kernelPackages = lib.mkForce pkgs.linuxPackages;

    supportedFilesystems = ["zfs"];
    zfs = {
      forceImportRoot = false;
      extraPools = ["tank"]; # Import existing pool at boot
    };
  };
  boot.zfs.requestEncryptionCredentials = false;
  sops.secrets.zfs-tank-key = {};
  systemd.services.zfs-load-key-tank = {
    description = "Load ZFS encryption key for tank pool";
    wantedBy = ["zfs-mount.service"];
    before = ["zfs-mount.service"];
    after = ["zfs-import-tank.service" "sops-nix.service"];
    requires = ["zfs-import-tank.service"];
    wants = ["sops-nix.service"];
    unitConfig.DefaultDependencies = false;
    path = [pkgs.coreutils pkgs.zfs];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
    };
    script = ''
      base64 -d /run/secrets/zfs-tank-key | zfs load-key -L file:///dev/stdin tank
    '';
  };
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
