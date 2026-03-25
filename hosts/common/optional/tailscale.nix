{
  config,
  lib,
  pkgs,
  ...
}: let
  isHeadless = config.hostSpec.kind == "headless";
in {
  sops.secrets."tailscale/authkey".sopsFile = config.sops.commonSecretsFile;
  sops.secrets."tailscale/authkey_expires".sopsFile = config.sops.commonSecretsFile;

  services.tailscale = {
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
                ${pkgs.systemd}/bin/systemctl restart nftables.service
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
  systemd.services.tailscaled-autoconnect = {
    serviceConfig = {
      TimeoutStartSec = "5s";
      Restart = "on-failure";
      RestartSec = "10s";
    };
  };
  system.activationScripts.checkTailscaleExpiry = {
    deps = ["setupSecrets"];
    text = ''
      expires=$(cat ${config.sops.secrets."tailscale/authkey_expires".path} 2>/dev/null || echo "")
      if [[ -z "$expires" ]]; then
        echo "WARNING: Tailscale authkey_expires not set in secrets"
        exit 0
      fi

      today=$(date +%Y-%m-%d)
      warn_date=$(date -d "+14 days" +%Y-%m-%d)

      if [[ "$today" > "$expires" ]]; then
        echo "ERROR: Tailscale auth key expired on $expires. Generate a new one at:"
        echo "  https://login.tailscale.com/admin/settings/keys"
        echo "Then update ~/aion-secrets/hosts/common/secrets.yaml"
        exit 1
      elif [[ "$warn_date" > "$expires" ]]; then
        echo "WARNING: Tailscale auth key expires on $expires (within 14 days)"
        echo "Consider generating a new one at:"
        echo "  https://login.tailscale.com/admin/settings/keys"
      fi
    '';
  };
}
