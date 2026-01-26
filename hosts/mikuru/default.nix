{inputs, ...}: {
  imports = [
    ./bootloader.nix
    ./hardware.nix
    ./disks.nix
    ./zfs.nix
    ../common/optional/stylix.nix
    ./syncthing.nix
    ../common/optional/fail2ban.nix
    ./modules/nfs-export.nix
    ./modules/jellyfin.nix
    ./modules/navidrome.nix
    ./modules/komga.nix
    ./modules/audiobookshelf.nix
    ./modules/arr.nix
    ./modules/traefik.nix
    ./modules/qbittorrent.nix
    ./modules/glance
    ./modules/notifiarr.nix
    ./modules/cleanuparr.nix
    ./modules/jackett.nix
    ./modules/flaresolverr.nix
    ./modules/samba.nix
    ./modules/bentopdf.nix

    inputs.vpn-confinement.nixosModules.default
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
