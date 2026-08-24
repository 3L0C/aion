# Traefik reverse proxy with Porkbun DNS challenge for wildcard SSL.
# Services register under options.traefikRoutes. This file owns only
# the daemon, the entry points, and the ACME resolver.
{
  flake.modules.nixos.traefik = {
    config,
    lib,
    ...
  }: let
    domain = config.hostSpec.domain;
  in {
    options.traefikRoutes = lib.mkOption {
      type = lib.types.attrsOf (lib.types.submodule ({config, ...}: {
        options = {
          port = lib.mkOption {
            type = lib.types.nullOr lib.types.port;
            default = null;
            description = "Local port the backend listens on";
          };
          url = lib.mkOption {
            type = lib.types.str;
            default = "http://localhost:${toString config.port}";
            description = "Backend URL; set it directly for non-local backends";
          };
          middlewares = lib.mkOption {
            type = lib.types.listOf lib.types.str;
            default = [];
            description = "Traefik middleware names for this router";
          };
          wildcard = lib.mkOption {
            type = lib.types.bool;
            default = false;
            description = "Request the wildcard certificate on this router; exactly one route sets this";
          };
        };
      }));
      default = {};
      description = "Reverse-proxy routes; a key becomes <key>.<hostSpec.domain>";
    };

    config = {
      sops = {
        secrets = {
          "porkbun/api-key" = {};
          "porkbun/secret-key" = {};
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
              email = "admin@${domain}";
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

        dynamicConfigOptions.http = {
          routers = lib.mapAttrs (name: route:
            {
              rule = "Host(`${name}.${domain}`)";
              service = name;
              entryPoints = ["websecure"];
              tls =
                if route.wildcard
                then {
                  certResolver = "porkbun";
                  domains = [
                    {
                      main = domain;
                      sans = ["*.${domain}"];
                    }
                  ];
                }
                # No certResolver: the router uses the stored wildcard cert.
                else {};
            }
            // lib.optionalAttrs (route.middlewares != []) {
              inherit (route) middlewares;
            })
          config.traefikRoutes;

          services =
            lib.mapAttrs (_: route: {
              loadBalancer.servers = [{inherit (route) url;}];
            })
            config.traefikRoutes;
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
    };
  };
}
