# Komga comics/manga server
{
  flake.modules.nixos.komga = {
    traefikRoutes.komga.port = 25600;

    users.users.komga.extraGroups = ["media"];

    services.komga = {
      enable = true;
      settings.server.port = 25600;
      # State stored in /var/lib/komga by default
    };
  };
}
