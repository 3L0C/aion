{
  config,
  lib,
  ...
}: {
  services.tailscale = {
    enable = true;
    useRoutingFeatures = lib.mkIf (config.hostSpec.kind == "headless") "server";
  };

  networking.firewall = {
    trustedInterfaces = ["tailscale0"];
    allowedUDPPorts = [config.services.tailscale.port];
  };
}
