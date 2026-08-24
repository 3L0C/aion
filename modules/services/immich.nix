# Immich - Self-hosted photo and video backup solution
{
  flake.modules.nixos.immich = {config, ...}: {
    traefikRoutes.immich.port = 2283;

    services.immich = {
      enable = true;
      mediaLocation = "${config.hostSpec.mediaRoot}/immich";
      group = "media";
      accelerationDevices = null; # null allows all devices (GPU transcoding).
    };

    users.users.immich.extraGroups = ["media"];

    # The service runs in a mount namespace. Bind-mount the shared photos directory into it.
    systemd.services.immich-server.serviceConfig.BindReadOnlyPaths = [
      "${config.hostSpec.mediaRoot}/photos"
    ];
  };
}
