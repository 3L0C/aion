# NFS export for /mnt
# Allows access from local network and Tailscale
{
  services.nfs.server = {
    enable = true;
    exports = ''
      /mnt 192.168.1.0/24(rw,sync,no_subtree_check,no_root_squash,crossmnt) 100.64.0.0/10(rw,sync,no_subtree_check,no_root_squash,crossmnt)
    '';
  };

  networking.firewall.allowedTCPPorts = [2049];
}
