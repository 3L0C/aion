# Immich - Self-hosted photo and video backup solution
{
  services.immich = {
    enable = true;
    mediaLocation = "/mnt/tank/data/media/immich";
    group = "media";
    accelerationDevices = null; # null allows all devices (GPU transcoding).
  };

  users.users.immich.extraGroups = ["media"];

  # The service runs in a mount namespace. Bind-mount the shared photos directory into it.
  systemd.services.immich-server.serviceConfig.BindReadOnlyPaths = [
    "/mnt/tank/data/media/photos"
  ];
}
