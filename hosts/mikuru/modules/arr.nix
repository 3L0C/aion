{
  users = {
    groups.media = {};
    users = {
      sonarr.extraGroups = ["media"];
      radarr.extraGroups = ["media"];
      lidarr.extraGroups = ["media"];
      bazarr.extraGroups = ["media"];
    };
  };

  services = {
    # Sonarr - TV show management
    sonarr = {
      enable = true;
      openFirewall = true;
      group = "media";
    };
    radarr = {
      enable = true;
      openFirewall = true;
      group = "media";
    };
    lidarr = {
      enable = true;
      openFirewall = true;
      group = "media";
    };
    prowlarr = {
      enable = true;
      openFirewall = true;
    };
    bazarr = {
      enable = true;
      openFirewall = true;
      group = "media";
    };
    jellyseerr = {
      enable = true;
      openFirewall = true;
    };
  };
}
