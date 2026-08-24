# Kavita manga/comics reading server with progress tracking
{
  flake.modules.nixos.kavita = {config, ...}: {
    traefikRoutes.kavita.port = 5000;

    sops.secrets."kavita/token-key" = {};

    users.users.kavita.extraGroups = ["media"];

    services.kavita = {
      enable = true;
      tokenKeyFile = config.sops.secrets."kavita/token-key".path;
      settings.Port = 5000;
    };
  };
}
