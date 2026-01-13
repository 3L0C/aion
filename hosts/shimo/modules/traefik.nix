{config, ...}: {
  sops = {
    secrets."porkbun/api-key" = {};
    secrets."porkbun/secret-key" = {};
    templates."traefik-env" = {
      content = ''
        PORKBUN_API_KEY=${config.sops.placeholder."porkbun/api-key"}
        PORKBUN_SECRET_KEY=${config.sops.placeholder."porkbun/secret-key"}
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
            resolvers = ["1.1.1.1:53" "8.8.8.8:53"];
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
            tls.certResolver = "porkbun";
          };
          sonarr = {
            rule = "Host(`sonarr.colebruns.com`)";
            service = "sonarr";
            entryPoints = ["websecure"];
            tls.certResolver = "porkbun";
          };
          radarr = {
            rule = "Host(`radarr.colebruns.com`)";
            service = "radarr";
            entryPoints = ["websecure"];
            tls.certResolver = "porkbun";
          };
          lidarr = {
            rule = "Host(`lidarr.colebruns.com`)";
            service = "lidarr";
            entryPoints = ["websecure"];
            tls.certResolver = "porkbun";
          };
          prowlarr = {
            rule = "Host(`prowlarr.colebruns.com`)";
            service = "prowlarr";
            entryPoints = ["websecure"];
            tls.certResolver = "porkbun";
          };
          bazarr = {
            rule = "Host(`bazarr.colebruns.com`)";
            service = "bazarr";
            entryPoints = ["websecure"];
            tls.certResolver = "porkbun";
          };
          jellyseerr = {
            rule = "Host(`jellyseerr.colebruns.com`)";
            service = "jellyseerr";
            entryPoints = ["websecure"];
            tls.certResolver = "porkbun";
          };
          navidrome = {
            rule = "Host(`navidrome.colebruns.com`)";
            service = "navidrome";
            entryPoints = ["websecure"];
            tls.certResolver = "porkbun";
          };
          komga = {
            rule = "Host(`komga.colebruns.com`)";
            service = "komga";
            entryPoints = ["websecure"];
            tls.certResolver = "porkbun";
          };
          audiobookshelf = {
            rule = "Host(`audiobookshelf.colebruns.com`)";
            service = "audiobookshelf";
            entryPoints = ["websecure"];
            tls.certResolver = "porkbun";
          };
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
          komga.loadBalancer.servers = [{url = "http://localhost:25600";}];
          audiobookshelf.loadBalancer.servers = [{url = "http://localhost:13378";}];
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

  networking.firewall.allowedTCPPorts = [80 443];
}
