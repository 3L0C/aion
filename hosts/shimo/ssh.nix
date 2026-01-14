{lib, ...}: {
  services.openssh.ports = lib.mkForce [54734];
  networking.firewall.allowedTCPPorts = [54734];
}
