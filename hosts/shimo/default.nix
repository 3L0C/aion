{
  imports = [
    ./hardware.nix
    ./bootloader.nix
    ./zfs.nix
    ./ssh.nix
    ./modules/nfs-export.nix
    ./modules/jellyfin.nix
    ./modules/navidrome.nix
    ./modules/komga.nix
    ./modules/audiobookshelf.nix
    ./modules/arr.nix
    ../common/headless.nix
    ../common/users/user
  ];
  virtualisation.podman = {
    enable = true;
    dockerCompat = true; # Create docker alias
  };
  virtualisation.oci-containers.backend = "podman";
  system.stateVersion = "24.11";
}
