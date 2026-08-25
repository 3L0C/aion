# Audiobookshelf audiobook/podcast server.
# There is no native NixOS module, so it runs as a Podman container.
{
  flake.modules.nixos.audiobookshelf = { config, ... }: {
    traefikRoutes.audiobookshelf.port = 13378;

    virtualisation.oci-containers.containers.audiobookshelf = {
      image = "ghcr.io/advplyr/audiobookshelf:latest";
      ports = [ "127.0.0.1:13378:80" ];
      volumes = [
        "/var/lib/audiobookshelf/config:/config"
        "/var/lib/audiobookshelf/metadata:/metadata"
        "${config.hostSpec.mediaRoot}/audiobooks:/audiobooks"
        "${config.hostSpec.mediaRoot}/podcasts:/podcasts"
      ];
      environment = {
        TZ = config.time.timeZone;
      };
      extraOptions = [
        "--pull=always"
        "--memory=1g"
        "--cpus=2"
      ];
    };

    systemd.tmpfiles.rules = [
      "d /var/lib/audiobookshelf/config 0755 root root -"
      "d /var/lib/audiobookshelf/metadata 0755 root root -"
    ];
  };
}
