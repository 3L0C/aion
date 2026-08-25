# SSH server base settings; hosts can override port, add fail2ban, etc.
{
  flake.modules.nixos.openssh = {
    services.openssh = {
      enable = true;
      ports = [ 22 ];

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

    # Hosts with custom ports must override this
    networking.firewall.allowedTCPPorts = [ 22 ];
  };
}
