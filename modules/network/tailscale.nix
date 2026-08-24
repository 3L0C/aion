# Tailscale mesh VPN. The mode follows hostSpec.kind: server for headless,
# client for desktop/laptop. The sops auth key removes the manual `tailscale up`.
let
  # Tailnet hosts mapping: hostname -> domain
  # Add new hosts here to include them in SSH config
  tailnetHosts = {
    haruhi = "tail7d01e8.ts.net";
    mikuru = "tail7d01e8.ts.net";
    yuki = "tail7d01e8.ts.net";
  };
in {
  flake.modules.nixos.tailscale = {
    config,
    lib,
    pkgs,
    ...
  }: let
    isHeadless = config.hostSpec.kind == "headless";
  in {
    # The user ssh config rewrites HostName to the tailnet FQDN. OpenSSH
    # matches known_hosts against the substituted name, so pin both.
    programs.ssh.knownHosts =
      lib.genAttrs (lib.attrNames tailnetHosts)
      (h: {extraHostNames = ["${h}.${tailnetHosts.${h}}"];});

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

    networking.firewall = {
      trustedInterfaces = ["tailscale0"];
      allowedUDPPorts = [config.services.tailscale.port];
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
  };

  # Tailnet ssh shortcuts for the user.
  flake.modules.homeManager.tailscale = {
    config,
    lib,
    ...
  }: let
    currentHost = config.hostSpec.name;

    # Generate SSH settings entries for all tailnet hosts except the current one
    tailnetSettings = lib.mapAttrs' (hostname: domain: {
      name = hostname;
      value = {
        HostName = "${hostname}.${domain}";
        User = "user";
        IdentityFile = "~/.ssh/id_3L0C";
        AddKeysToAgent = "yes";
      };
    }) (lib.filterAttrs (hostname: _: hostname != currentHost) tailnetHosts);
  in {
    programs.ssh.settings = tailnetSettings;
  };
}
