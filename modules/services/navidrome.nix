# Navidrome music streaming server
{
  flake.modules.nixos.navidrome = { config, ... }: {
    traefikRoutes.navidrome.port = 4533;

    users.users.navidrome.extraGroups = [ "media" ];

    services.navidrome = {
      enable = true;
      settings = {
        Address = "0.0.0.0";
        Port = 4533;
        MusicFolder = "${config.hostSpec.mediaRoot}/music";
        DataFolder = "/var/lib/navidrome";
        EnableInsightsCollector = false;
        ScanSchedule = "@every 1h";
        TranscodingCacheSize = "1GB";
      };
    };
  };
}
