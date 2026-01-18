# Navidrome music streaming server
{
  users.users.navidrome.extraGroups = ["media"];

  services.navidrome = {
    enable = true;
    openFirewall = true;
    settings = {
      Address = "0.0.0.0";
      Port = 4533;
      MusicFolder = "/mnt/tank/data/media/music";
      DataFolder = "/var/lib/navidrome";
      EnableInsightsCollector = false;
      ScanSchedule = "@every 1h";
      TranscodingCacheSize = "1GB";
    };
  };
}
