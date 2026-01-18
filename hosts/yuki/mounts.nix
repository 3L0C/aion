{
  environment.etc.crypttab = {
    mode = "0600";
    text = ''
      # <mapped-name> <device uuid> [key-file] [options]
      sandisk   UUID=51a5bc2d-9e63-4db2-8f9d-1d4a320476e9 /root/keys/sandisk.key          discard,luks,nofail
      samssd    UUID=e89c0933-8140-4119-8220-ce2ae6317018 /root/keys/samssd.key           discard,luks,nofail
      backuphdd UUID=0f5939b7-3bdf-4711-a1fc-6e6f06f50d22 /root/keys/panda-backup-hdd.key luks,nofail
    '';
  };

  fileSystems = {
    # Shimo NFS share
    "/mnt/share" = {
      device = "192.168.1.126:/mnt";
      fsType = "nfs";
      options = [
        "x-systemd.automount"
        "noauto"
        "x-systemd.idle-timeout=600"
        "_netdev"
        "nofail"
      ];
    };

    # Windows data
    "/mnt/ssd" = {
      device = "UUID=DED2435ED2433A53";
      fsType = "ntfs-3g";
      options = [
        "uid=1000"
        "gid=100"
        "async"
        "user"
        "exec"
        "umask=000"
      ];
    };

    # Backup HDD
    "/mnt/backup" = {
      device = "UUID=5bd51353-667e-4344-b760-d3fe996e9b76";
      fsType = "ext4";
      options = [
        "defaults"
        "noatime"
        "nofail"
      ];
    };

    # Games HDD
    "/mnt/hdd" = {
      device = "UUID=F8A49EDFA49EA024";
      fsType = "ntfs-3g";
      options = [
        "uid=1000"
        "gid=100"
        "async"
        "user"
        "exec"
        "umask=000"
      ];
    };
  };
}
