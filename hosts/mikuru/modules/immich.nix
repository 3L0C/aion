# Immich - Self-hosted photo and video backup solution
{
  services.immich = {
    enable = true;
    mediaLocation = "/mnt/tank/data/media/immich";
    group = "media";
    accelerationDevices = null; # Allow access to all devices (GPU transcoding)
  };
  users.users.immich.extraGroups = ["media"];
  systemd.services.immich-server.serviceConfig.BindReadOnlyPaths = [
    "/mnt/tank/data/media/photos"
  ];
}
