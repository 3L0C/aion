{
  services.nfs.server = {
    enable = true;
    exports = ''
      /mnt/tank/data 192.168.1.0/24(rw,sync,no_subtree_check,no_root_squash)
    '';
  };

  networking.firewall.allowedTCPPorts = [2049];
}
