{
  flake.modules.homeManager.filesystems = { pkgs, ... }: {
    home.packages = with pkgs; [
      dosfstools # DOS filesystem utilities
      ntfs3g # NTFS filesystem driver and utilities
      gvfs # Virtual filesystem implementation for GIO
      nfs-utils # Support programs for Network File Systems
      cifs-utils # For mount.cifs, required unless domain name resolution is not needed
      sshfs # FUSE client based on the SSH File Transfer Protocol
    ];
  };
}
