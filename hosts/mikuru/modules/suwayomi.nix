# Suwayomi manga download server (Tachiyomi-compatible)
{
  services.suwayomi-server = {
    enable = true;
    openFirewall = true;
    dataDir = "/mnt/tank/data/media/manga";
    user = "user";
    group = "media";

    settings.server = {
      port = 4567; # Default 8080 conflicts with Glance
      downloadAsCbz = true; # CBZ format for Komga compatibility
      localSourcePath = "/mnt/tank/data/media/manga-local";
    };
  };
  systemd.services.suwayomi-server = {
    environment.HOME = "/mnt/tank/data/media/manga";
    serviceConfig.SetLoginEnvironment = false;
  };
}
