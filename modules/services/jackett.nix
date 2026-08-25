# Jackett indexer proxy
{
  flake.modules.nixos.jackett = {
    traefikRoutes.jackett.port = 9117;

    services.jackett = {
      enable = true;
    };

    users.users.jackett.extraGroups = [ "media" ];
  };
}
