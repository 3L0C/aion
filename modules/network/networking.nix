# Networking tools and utilities
{
  flake.modules.homeManager.networking = { pkgs, ... }: {
    home.packages = with pkgs; [
      iproute2 # Collection of utilities for controlling TCP/IP networking
      ipset # Administration tool for IP sets
      net-tools # Configuration tools for Linux networking (deprecated but useful)
      netcat-openbsd # TCP/IP swiss army knife (OpenBSD variant)
      socat # Multipurpose relay for bidirectional data transfer
      wireguard-tools # Next generation secure network tunnel tools
    ];
  };
}
