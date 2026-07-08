{pkgs, ...}: {
  home.packages = with pkgs; [
    dosfstools # DOS filesystem utilities
    ntfs3g # NTFS filesystem driver and utilities
    gvfs # Virtual filesystem implementation for GIO
    nfs-utils # Support programs for Network File Systems
    smbnetfs # Virtual filesystem implementation for GIO - SMB/CIFS backend (Windows file sharing)
    cifs-utils # For mount.cifs, required unless domain name resolution is not needed
    simple-mtpfs # A FUSE filesystem that supports reading/writing from MTP devices
    sshfs # FUSE client based on the SSH File Transfer Protocol
  ];
}
