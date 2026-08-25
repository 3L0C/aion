# *arr media stack with HTTP health checks that restart unresponsive services.
{
  flake.modules.nixos.arr =
    { pkgs, ... }:
    let
      mkHealthCheck =
        name: port:
        let
          checkScript = pkgs.writeShellScript "${name}-health-check" ''
            if ! ${pkgs.curl}/bin/curl -sf --max-time 30 "http://localhost:${toString port}/ping" >/dev/null 2>&1; then
              echo "${name} health check failed, restarting..."
              systemctl restart ${name}
            fi
          '';
        in
        {
          "${name}-health-check" = {
            description = "Health check for ${name}";
            serviceConfig = {
              Type = "oneshot";
              ExecStart = checkScript;
            };
          };
        };

      mkHealthCheckTimer = name: {
        "${name}-health-check" = {
          description = "Run ${name} health check every 5 minutes";
          wantedBy = [ "timers.target" ];
          timerConfig = {
            OnBootSec = "5min";
            OnUnitActiveSec = "5min";
            RandomizedDelaySec = "30s";
          };
        };
      };

      healthCheckServices =
        (mkHealthCheck "sonarr" 8989)
        // (mkHealthCheck "radarr" 7878)
        // (mkHealthCheck "lidarr" 8686)
        // (mkHealthCheck "prowlarr" 9696)
        // (mkHealthCheck "bazarr" 6767);

      healthCheckTimers =
        (mkHealthCheckTimer "sonarr")
        // (mkHealthCheckTimer "radarr")
        // (mkHealthCheckTimer "lidarr")
        // (mkHealthCheckTimer "prowlarr")
        // (mkHealthCheckTimer "bazarr");
    in
    {
      traefikRoutes = {
        sonarr.port = 8989;
        radarr.port = 7878;
        lidarr.port = 8686;
        prowlarr.port = 9696;
        bazarr.port = 6767;
        seerr.port = 5055; # NOTE: service is now just seerr, may need to make other changes elsewhere
      };

      systemd.services = healthCheckServices;
      systemd.timers = healthCheckTimers;
      users = {
        groups.media = { };
        users = {
          sonarr.extraGroups = [ "media" ];
          radarr.extraGroups = [ "media" ];
          lidarr.extraGroups = [ "media" ];
          bazarr.extraGroups = [ "media" ];
        };
      };

      services = {
        # Sonarr - TV show management
        sonarr = {
          enable = true;
          group = "media";
        };

        # Radarr - movie management
        radarr = {
          enable = true;
          group = "media";
        };

        # Lidarr - music management
        lidarr = {
          enable = true;
          group = "media";
        };

        # Prowlarr - indexer manager
        prowlarr = {
          enable = true;
        };

        # Bazarr - subtitle management
        bazarr = {
          enable = true;
          group = "media";
        };

        # Jellyseerr - request management for Jellyfin
        seerr = {
          enable = true;
          openFirewall = true;
        };
      };
    };
}
