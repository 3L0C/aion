{inputs, ...}: {
  imports = [
    ./bootloader.nix
    ./hardware.nix
    ./ssh.nix
    ./syncthing.nix
    ./zfs.nix
    ./modules/nfs-export.nix
    ./modules/jellyfin.nix
    ./modules/navidrome.nix
    ./modules/komga.nix
    ./modules/audiobookshelf.nix
    ./modules/arr.nix
    ./modules/traefik.nix
    ./modules/qbittorrent.nix
    ./modules/glance.nix
    ./modules/notifiarr.nix
    ./modules/cleanuparr.nix
    ./modules/tailscale.nix
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
