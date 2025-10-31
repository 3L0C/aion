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
    dnssec = "true"; # Enable DNSSEC validation
    domains = ["~."]; # Use for all domains
    dnsovertls = "true"; # Enable DNS-over-TLS (encrypted DNS queries)
    fallbackDns = [
      "127.0.0.1"
      "::1"
    ];
    extraConfig = ''
      MulticastDNS=no
      LLMNR=no
      ReadEtcHosts=yes
      ResolveUnicastSingleLabel=no
    '';
  };
  environment.systemPackages = with pkgs; [networkmanagerapplet];
}
