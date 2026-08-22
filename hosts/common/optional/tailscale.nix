# Tailscale mesh VPN. The mode follows hostSpec.kind: server for headless,
# client for desktop/laptop. The sops auth key removes the manual `tailscale up`.
{
  config,
  lib,
  pkgs,
  ...
}: let
  isHeadless = config.hostSpec.kind == "headless";
in {
  sops.secrets."tailscale/authkey".sopsFile = config.sops.commonSecretsFile;

  services.tailscale = {
    package = pkgs.master.tailscale;
    enable = true;
    useRoutingFeatures =
      if isHeadless
      then "server"
      else "client";
    authKeyFile = config.sops.secrets."tailscale/authkey".path;
    extraUpFlags = lib.optionals (!isHeadless) ["--accept-routes"];
  };

  networking = {
    firewall = {
      trustedInterfaces = ["tailscale0"];
      allowedUDPPorts = [config.services.tailscale.port];
    };
    nftables = {
      enable = true;
      tables.mullvad_tailscale = {
        family = "inet";
        content = ''
          chain output {
            type route hook output priority -1; policy accept;
            meta mark 0x6d6f6c65 ct mark set 0x00000f41;
            ip daddr 100.64.0.0/10 ct mark set 0x00000f41 meta mark set 0x6d6f6c65;
            ip daddr 192.168.1.0/24 ct mark set 0x00000f41 meta mark set 0x6d6f6c65;
          }

          chain input {
            type filter hook input priority -150; policy accept;
            ip saddr 100.64.0.0/10 ct mark set 0x00000f41 meta mark set 0x6d6f6c65;
            ip saddr 192.168.1.0/24 ct mark set 0x00000f41 meta mark set 0x6d6f6c65;
          }
        '';
      };
    };
    networkmanager.dispatcherScripts = lib.mkIf (config.services.mullvad-vpn.enable or false) [
      {
        source = pkgs.writeShellScript "mullvad-tailscale-fix" ''
                    if [ "$2" != "up" ] || [ "$1" = "wg0-mullvad" ] || [ "$1" = "tailscale0" ]; then
                      exit 0
                    fi

                    (
                      timeout=60
                      while [ $timeout -gt 0 ]; do
                        if ${config.services.mullvad-vpn.package}/bin/mullvad status 2>/dev/null | grep -q "Connected"; then
                          sleep 2  # Brief wait for firewall rules to settle
                          ${pkgs.nftables}/bin/nft -f - <<'NFTEOF'
                    table inet mullvad_tailscale {
                      chain output {
                        type route hook output priority -1; policy accept;
                        meta mark 0x6d6f6c65 ct mark set 0x00000f41;
                        ip daddr 100.64.0.0/10 ct mark set 0x00000f41 meta mark set 0x6d6f6c65;
                        ip daddr 192.168.1.0/24 ct mark set 0x00000f41 meta mark set 0x6d6f6c65;
                      }
                      chain input {
                        type filter hook input priority -150; policy accept;
                        ip saddr 100.64.0.0/10 ct mark set 0x00000f41 meta mark set 0x6d6f6c65;
                        ip saddr 192.168.1.0/24 ct mark set 0x00000f41 meta mark set 0x6d6f6c65;
                      }
                    }
          NFTEOF
                          exit 0
                        fi
                        sleep 1
                        timeout=$((timeout - 1))
                      done
                    ) &
        '';
        type = "basic";
      }
    ];
  };
  systemd.services.mullvad-daemon = lib.mkIf (config.services.mullvad-vpn.enable or false) {
    after = ["tailscaled.service"];
    wants = ["tailscaled.service"];
  };

  # The default Type=notify with a 90s timeout blocks graphical.target when
  # the network is slow. Fail fast and let systemd retry.
  systemd.services.tailscaled-autoconnect = {
    serviceConfig = {
      TimeoutStartSec = "5s";
      Restart = "on-failure";
      RestartSec = "10s";
    };
  };
}
