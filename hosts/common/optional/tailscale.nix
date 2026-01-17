{
  config,
  lib,
  ...
}: let
  isHeadless = config.hostSpec.kind == "headless";
in {
  services.tailscale = {
    enable = true;
    useRoutingFeatures =
      if isHeadless
      then "server"
      else "client";
    extraUpFlags = lib.optionals (!isHeadless) ["--accept-routes"];
  };

  networking.firewall = {
    trustedInterfaces = ["tailscale0"];
    allowedUDPPorts = [config.services.tailscale.port];
  };
}
