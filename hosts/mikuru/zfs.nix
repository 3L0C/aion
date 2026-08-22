# ZFS for mikuru: imports the existing encrypted RAIDZ2 pool "tank".
{
  lib,
  pkgs,
  ...
}: {
  environment.systemPackages = [pkgs.zfs];
  boot = {
    # ZFS needs the LTS kernel. The zen kernel is often incompatible.
    # mkForce overrides linuxPackages_zen from common/global/bootloader.nix.
    kernelPackages = lib.mkForce pkgs.linuxPackages;

    supportedFilesystems = ["zfs"];
    zfs = {
      forceImportRoot = false;
      extraPools = ["tank"]; # Import the existing pool at boot.
    };
  };

  # No boot-time key prompt: sops supplies the key (see the service below).
  boot.zfs.requestEncryptionCredentials = false;

  sops.secrets.zfs-tank-key = {};

  # Load the ZFS key after sops decrypts it and before mount.
  # The key is base64-encoded in sops; decode it before load-key.
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
      if [ "$(zfs get -H -o value keystatus tank)" = "available" ]; then
        echo "Key already loaded for tank"
        exit 0
      fi
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
      frequent = 4; # 15-minute snapshots
      hourly = 24;
      daily = 7;
      weekly = 4;
      monthly = 12;
    };
    trim.enable = false; # The pool is on HDDs. HDDs do not support TRIM.
  };

  # ZFS requires a stable hostId for pool ownership. Do not change.
  networking.hostId = "43973e50";
}
