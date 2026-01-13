{
  virtualisation.oci-containers.containers.audiobookshelf = {
    image = "ghcr.io/advplyr/audiobookshelf:latest";
    ports = ["13378:80"];
    volumes = [
      "/var/lib/audiobookshelf/config:/config"
      "/var/lib/audiobookshelf/metadata:/metadata"
      "/mnt/tank/data/media/audiobooks:/audiobooks"
      "/mnt/tank/data/media/podcasts:/podcasts"
    ];
    environment = {
      TZ = "America/Los_Angeles";
    };
  };
  systemd.tmpfiles.rules = [
    "d /var/lib/audiobookshelf/config 0755 root root -"
    "d /var/lib/audiobookshelf/metadata 0755 root root -"
  ];
  networking.firewall.allowedTCPPorts = [13378];
}
