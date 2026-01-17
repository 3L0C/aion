{
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
      checkRuleset = true; # Validate ruleset before applying
    };
    firewall = {
      enable = true;
    };
  };
  services.resolved = {
    enable = true;
    settings = {
      Resolve = {
        DNSSEC = "allow-downgrade"; # Allow DNSSEC but fallback on validation errors
        Domains = "~."; # Use for all domains
        DNSOverTLS = "yes"; # Enable DNS-over-TLS (encrypted DNS queries)
        FallbackDNS = "127.0.0.1 ::1"; # Fallback to localhost if all else fails
        MulticastDNS = "no";
        LLMNR = "no";
        ReadEtcHosts = "yes";
        ResolveUnicastSingleLabel = "no";
      };
    };
  };
  environment.systemPackages = with pkgs; [networkmanagerapplet];
}
