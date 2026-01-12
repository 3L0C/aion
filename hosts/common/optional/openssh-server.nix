{
  services.openssh = {
    enable = true;
    ports = [22]; # Default port, override in host-specific config if needed

    settings = {
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
      PermitRootLogin = "no";
      StrictModes = true;
      UseDns = false;
      X11Forwarding = true;
      Ciphers = [
        "chacha20-poly1305@openssh.com"
        "aes256-gcm@openssh.com"
      ];

      # Post-quantum safe key exchange
      KexAlgorithms = [
        "sntrup761x25519-sha512@openssh.com"
        "curve25519-sha256@libssh.org"
      ];
      HostKeyAlgorithms = "ssh-ed25519";
      PubkeyAcceptedAlgorithms = "ssh-ed25519";
    };
    hostKeys = [
      {
        path = "/etc/ssh/ssh_host_ed25519_key";
        type = "ed25519";
      }
    ];
  };
  networking.firewall.allowedTCPPorts = [22];
}
