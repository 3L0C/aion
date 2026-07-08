# Komga comics/manga server
{
  users.users.komga.extraGroups = ["media"];

  services.komga = {
    enable = true;
    settings.server.port = 25600;
    # State stored in /var/lib/komga by default
  };
}
