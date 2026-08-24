# Cleanuparr qBittorrent orphan torrent cleaner.
# There is no native NixOS module, so it runs as a Podman container.
{
  flake.modules.nixos.cleanuparr = {config, ...}: {
    traefikRoutes.cleanuparr.port = 11011;

    virtualisation.oci-containers.containers.cleanuparr = {
      image = "ghcr.io/cleanuparr/cleanuparr:latest";
      volumes = [
        "/var/lib/cleanuparr:/config"
        "${config.hostSpec.torrentsRoot}:${config.hostSpec.torrentsRoot}"
      ];
      environment = {
        PORT = "11011";
        TZ = config.time.timeZone;
        PUID = "1000";
        PGID = "1000";
        UMASK = "022";
      };
      extraOptions = [
        "--pull=always"
        "--memory=256m"
        "--network=host"
      ];
    };

    systemd.tmpfiles.rules = [
      "d /var/lib/cleanuparr 0755 1000 1000 -"
    ];
  };
}
