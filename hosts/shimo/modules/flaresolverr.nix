# FlareSolverr - Cloudflare bypass proxy for Jackett/Prowlarr
{
  virtualisation.oci-containers.containers.flaresolverr = {
    image = "ghcr.io/flaresolverr/flaresolverr:latest";
    ports = ["8191:8191"];
    environment = {
      TZ = "America/Los_Angeles";
      LOG_LEVEL = "info";
    };
  };

  networking.firewall.allowedTCPPorts = [8191];
}
