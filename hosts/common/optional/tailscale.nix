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
  networking.nftables = {
    enable = true;
    tables.mullvad_tailscale = {
      family = "inet";
      content = ''
        chain output {
          type route hook output priority 0; policy accept;
          ip daddr 100.64.0.0/10 ct mark set 0x00000f41 meta mark set 0x6d6f6c65;
        }

        chain input {
          type filter hook input priority -100; policy accept;
          ip saddr 100.64.0.0/10 ct mark set 0x00000f41 meta mark set 0x6d6f6c65;
        }
      '';
    };
  };
}
