{inputs, ...}: {
  imports = [
    ./bootloader.nix
    ./hardware.nix
    ./disks.nix
    ./zfs.nix
    ../common/optional/stylix.nix
    ./syncthing.nix
    ../common/optional/fail2ban.nix
    ./modules/arr.nix
    ./modules/audiobookshelf.nix
    ./modules/bentopdf.nix
    ./modules/cleanuparr.nix
    ./modules/flaresolverr.nix
    ./modules/glance
    ./modules/jackett.nix
    ./modules/jellyfin.nix
    ./modules/komga.nix
    ./modules/navidrome.nix
    ./modules/nfs-export.nix
    ./modules/notifiarr.nix
    ./modules/immich.nix
    ./modules/photoprism.nix
    ./modules/qbittorrent.nix
    ./modules/traefik.nix
    ./modules/samba.nix
    ./modules/suwayomi.nix
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
