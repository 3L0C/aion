# FlareSolverr - Cloudflare bypass proxy for Jackett/Prowlarr
{config, ...}: {
  virtualisation.oci-containers.containers.flaresolverr = {
    image = "ghcr.io/flaresolverr/flaresolverr:latest";
    ports = ["8191:8191"];
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

  networking.firewall.allowedTCPPorts = [8191];
}
