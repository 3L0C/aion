{config, ...}: {
  services.tailscale = {
    enable = true;
    useRoutingFeatures = "server"; # Enable subnet routing
  };

  networking.firewall = {
    trustedInterfaces = ["tailscale0"];
    allowedUDPPorts = [config.services.tailscale.port];
  };
}
