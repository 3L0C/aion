{ config, ... }:
let
  hm = config.flake.modules.homeManager;
in
{
  hosts.mikuru = {
    system = "x86_64-linux";
  };

  flake.modules.nixos."hosts/mikuru" = {
    imports = with config.flake.modules.nixos; [
      base
      headless
      lanzaboote
      fail2ban
      stylix

      podman
      traefik

      arr
      audiobookshelf
      bentopdf
      cleanuparr
      flaresolverr
      glance
      immich
      jackett
      jellyfin
      kavita
      komga
      navidrome
      nfs-export
      notifiarr
      photoprism
      qbittorrent-server
      samba
      suwayomi
      syncthing
    ];

    hostSpec = {
      name = "mikuru";
      kind = "headless";
      isWork = false;
      primaryUser = "user"; # Primary administrator account

      cpuThermalZone = null;
      hasDiscreteGPU = true; # AMD RX 6600 XT for hardware transcoding

      domain = "colebruns.com";
      mediaRoot = "/mnt/tank/data/media";
      torrentsRoot = "/mnt/tank/data/torrents";
    };

    traefikRoutes = {
      # Route to the AdGuard instance on the router.
      adguard.url = "http://192.168.1.1:8080";
      syncthing.port = 8384;
    };

    home-manager.users.user.imports = [ hm.cli ];

    # Do not change after the initial install.
    system.stateVersion = "26.11";
  };
}
