# Suwayomi manga download server (Tachiyomi-compatible)
{
  services.suwayomi-server = {
    enable = true;
    openFirewall = true;

    settings.server = {
      port = 4567; # Default 8080 conflicts with Glance
      downloadAsCbz = true; # CBZ format for Komga compatibility
    };
  };
}
