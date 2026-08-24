# Jellyfin media server with AMD GPU transcoding
{
  flake.modules.nixos.jellyfin = {
    # The only route that requests the wildcard certificate.
    traefikRoutes.jellyfin = {
      port = 8096;
      wildcard = true;
    };

    services.jellyfin = {
      enable = true;
      openFirewall = true;
    };

    # The jellyfin user needs access to the render devices for GPU transcoding.
    users.users.jellyfin.extraGroups = ["render" "video" "media"];
  };
}
