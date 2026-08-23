# Network configuration: Quad9 DNS with DNS-over-TLS and DNSSEC
{
  flake.modules.nixos.networking = {
    config,
    pkgs,
    ...
  }: {
    networking = {
      hostName = config.hostSpec.name;
      networkmanager.enable = true;

      nameservers = [
        "9.9.9.11" # Quad9 primary (no EDNS Client Subnet, DNSSEC)
        "149.112.112.11" # Quad9 secondary
        "2620:fe::11" # Quad9 primary IPv6
        "2620:fe::fe:11" # Quad9 secondary IPv6
      ];

      nftables = {
        enable = true;
        checkRuleset = true;
      };

      firewall = {
        enable = true;
      };
    };

    services.resolved = {
      enable = true;
      # Time desync from a Windows dual-boot can break DNSSEC validation.
      # If DNS fails after a Windows boot, run: sudo dns-recovery
      settings = {
        Resolve = {
          DNSSEC = "allow-downgrade";
          Domains = "~.";
          DNSOverTLS = "yes";
          FallbackDNS = "127.0.0.1 ::1";
          MulticastDNS = "no";
          LLMNR = "no";
          ReadEtcHosts = "yes";
          ResolveUnicastSingleLabel = "no";
        };
      };
    };

    environment.systemPackages = with pkgs; [
      networkmanagerapplet
      custom.scripts.dns-recovery
    ];
  };
}
