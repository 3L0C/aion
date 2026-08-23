{
  flake.modules.nixos."hosts/haruhi" = {
    fileSystems = {
      # Mikuru NFS share (via Tailscale for laptop mobility)
      "/mnt/share" = {
        device = "mikuru.tail7d01e8.ts.net:/mnt";
        fsType = "nfs";
        options = [
          "x-systemd.automount"
          "noauto"
          "x-systemd.idle-timeout=600"
          "_netdev"
          "nofail"
        ];
      };
    };
  };
}
