{lib, ...}: {
  services.openssh.ports = lib.mkForce [54734];
  networking.firewall.allowedTCPPorts = lib.mkForce [54734];

  # Fail2ban for SSH brute force protection
  services.fail2ban = {
    enable = true;
    maxretry = 5;
    bantime = "1h";
    bantime-increment = {
      enable = true;
      maxtime = "168h"; # 1 week max
      factor = "4";
    };
    jails.sshd = {
      settings = {
        enabled = true;
        port = "54734";
        filter = "sshd";
        maxretry = 3;
      };
    };
  };
}
