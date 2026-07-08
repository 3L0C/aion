{config, ...}: let
  mkRouter = host: service: {
    rule = "Host(`${host}`)";
    inherit service;
    entryPoints = ["websecure"];
    tls = {}; # Uses default/stored wildcard cert
  };
in {
  sops = {
    secrets = {
      "porkbun/api-key" = {};
      "porkbun/secret-key" = {};
      "suwayomi/htpasswd".owner = "traefik";
    };
    templates."traefik-env" = {
      content = ''
        PORKBUN_API_KEY=${config.sops.placeholder."porkbun/api-key"}
        PORKBUN_SECRET_API_KEY=${config.sops.placeholder."porkbun/secret-key"}
      '';
    };
  };

  services.traefik = {
    enable = true;

    staticConfigOptions = {
      api.dashboard = false;

      entryPoints = {
        web = {
          address = ":80";
          http.redirections.entryPoint = {
            to = "websecure";
            scheme = "https";
          };
        };
        websecure = {
          address = ":443";
        };
      };

      certificatesResolvers.porkbun = {
        acme = {
          email = "admin@colebruns.com";
          storage = "/var/lib/traefik/acme.json";
          dnsChallenge = {
            provider = "porkbun";
            resolvers = [
              "1.1.1.1:53"
              "8.8.8.8:53"
            ];
          };
        };
      };
    };

    dynamicConfigOptions = {
      http = {
        routers = {
          jellyfin = {
            rule = "Host(`jellyfin.colebruns.com`)";
            service = "jellyfin";
            entryPoints = ["websecure"];
            tls = {
              certResolver = "porkbun";
              domains = [
                {
                  main = "colebruns.com";
                  sans = ["*.colebruns.com"];
                }
              ];
            };
          };
          sonarr = mkRouter "sonarr.colebruns.com" "sonarr";
          radarr = mkRouter "radarr.colebruns.com" "radarr";
          lidarr = mkRouter "lidarr.colebruns.com" "lidarr";
          prowlarr = mkRouter "prowlarr.colebruns.com" "prowlarr";
          bazarr = mkRouter "bazarr.colebruns.com" "bazarr";
          jellyseerr = mkRouter "jellyseerr.colebruns.com" "jellyseerr";
          navidrome = mkRouter "navidrome.colebruns.com" "navidrome";
          kavita = mkRouter "kavita.colebruns.com" "kavita";
          komga = mkRouter "komga.colebruns.com" "komga";
          suwayomi =
            mkRouter "suwayomi.colebruns.com" "suwayomi"
            // {
              middlewares = ["suwayomi-auth"];
            };
          audiobookshelf = mkRouter "audiobookshelf.colebruns.com" "audiobookshelf";
          qbittorrent = mkRouter "qbittorrent.colebruns.com" "qbittorrent";
          glance = mkRouter "glance.colebruns.com" "glance";
          notifiarr = mkRouter "notifiarr.colebruns.com" "notifiarr";
          cleanuparr = mkRouter "cleanuparr.colebruns.com" "cleanuparr";
          syncthing = mkRouter "syncthing.colebruns.com" "syncthing";
          jackett = mkRouter "jackett.colebruns.com" "jackett";
          bentopdf = mkRouter "bentopdf.colebruns.com" "bentopdf";
          adguard = mkRouter "adguard.colebruns.com" "adguard";
          flaresolverr = mkRouter "flaresolverr.colebruns.com" "flaresolverr";
          immich = mkRouter "immich.colebruns.com" "immich";
          photoprism = mkRouter "photoprism.colebruns.com" "photoprism";
        };

        middlewares = {
          suwayomi-auth.basicAuth.usersFile = config.sops.secrets."suwayomi/htpasswd".path;
        };

        services = {
          jellyfin.loadBalancer.servers = [{url = "http://localhost:8096";}];
          sonarr.loadBalancer.servers = [{url = "http://localhost:8989";}];
          radarr.loadBalancer.servers = [{url = "http://localhost:7878";}];
          lidarr.loadBalancer.servers = [{url = "http://localhost:8686";}];
          prowlarr.loadBalancer.servers = [{url = "http://localhost:9696";}];
          bazarr.loadBalancer.servers = [{url = "http://localhost:6767";}];
          jellyseerr.loadBalancer.servers = [{url = "http://localhost:5055";}];
          navidrome.loadBalancer.servers = [{url = "http://localhost:4533";}];
          kavita.loadBalancer.servers = [{url = "http://localhost:5000";}];
          komga.loadBalancer.servers = [{url = "http://localhost:25600";}];
          suwayomi.loadBalancer.servers = [{url = "http://localhost:4567";}];
          immich.loadBalancer.servers = [{url = "http://localhost:2283";}];
          photoprism.loadBalancer.servers = [{url = "http://localhost:2342";}];
          audiobookshelf.loadBalancer.servers = [{url = "http://localhost:13378";}];
          qbittorrent.loadBalancer.servers = [{url = "http://192.168.15.1:8081";}];
          glance.loadBalancer.servers = [{url = "http://localhost:8080";}];
          notifiarr.loadBalancer.servers = [{url = "http://localhost:5454";}];
          cleanuparr.loadBalancer.servers = [{url = "http://localhost:11011";}];
          syncthing.loadBalancer.servers = [{url = "http://localhost:8384";}];
          jackett.loadBalancer.servers = [{url = "http://localhost:9117";}];
          bentopdf.loadBalancer.servers = [{url = "http://localhost:8083";}];
          adguard.loadBalancer.servers = [{url = "http://192.168.1.1:8080";}];
          flaresolverr.loadBalancer.servers = [{url = "http://localhost:8191";}];
        };
      };
    };
  };
  systemd.services.traefik.serviceConfig.EnvironmentFile = [
    config.sops.templates."traefik-env".path
  ];
  systemd.tmpfiles.rules = [
    "d /var/lib/traefik 0750 traefik traefik -"
  ];

  networking.firewall.allowedTCPPorts = [
    80
    443
  ];
}
