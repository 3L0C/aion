{
  virtualisation.oci-containers.containers.cleanuparr = {
    image = "ghcr.io/cleanuparr/cleanuparr:latest";
    ports = ["11011:11011"];
    volumes = [
      "/var/lib/cleanuparr:/config"
      "/mnt/tank/data/torrents:/data/torrents"
    ];
    environment = {
      PORT = "11011";
      TZ = "America/Los_Angeles";
      PUID = "1000";
      PGID = "1000";
      UMASK = "022";
    };
  };
  systemd.tmpfiles.rules = [
    "d /var/lib/cleanuparr 0755 root root -"
  ];
}
