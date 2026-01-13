# Komga comics/manga server
{
  services.komga = {
    enable = true;
    openFirewall = true;
    settings.server.port = 25600;
    # State stored in /var/lib/komga by default
  };
}
