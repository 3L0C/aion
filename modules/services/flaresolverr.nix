# FlareSolverr - Cloudflare bypass proxy for Jackett/Prowlarr
{
  flake.modules.nixos.flaresolverr = { config, ... }: {
    traefikRoutes.flaresolverr.port = 8191;

    virtualisation.oci-containers.containers.flaresolverr = {
      image = "ghcr.io/flaresolverr/flaresolverr:latest";
      ports = [ "127.0.0.1:8191:8191" ];
      environment = {
        TZ = config.time.timeZone;
        LOG_LEVEL = "info";
      };
      # Resource limits - FlareSolverr runs a browser, can be memory-intensive
      extraOptions = [
        "--pull=always"
        "--memory=2g"
        "--cpus=2"
      ];
    };
  };
}
