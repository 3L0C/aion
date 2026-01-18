{
  config,
  lib,
  pkgs,
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
  systemd.services.mullvad-daemon = lib.mkIf (config.services.mullvad-vpn.enable or false) {
    after = ["tailscaled.service"];
    wants = ["tailscaled.service"];
  };
  systemd.services.nftables-tailscale-fix = lib.mkIf (config.services.mullvad-vpn.enable or false) {
    description = "Reload nftables after Mullvad to restore Tailscale bypass rules";
    after = ["mullvad-daemon.service"];
    requires = ["mullvad-daemon.service"];
    wantedBy = ["multi-user.target"];
    path = [config.services.mullvad-vpn.package];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
    };
    script = ''
      timeout=60
      while [ $timeout -gt 0 ]; do
        if mullvad status 2>/dev/null | grep -q "Connected"; then
          sleep 2  # Brief additional wait for firewall rules to settle
          ${pkgs.systemd}/bin/systemctl restart nftables.service
          exit 0
        fi
        sleep 1
        timeout=$((timeout - 1))
      done
      ${pkgs.systemd}/bin/systemctl restart nftables.service
    '';
  };
}
