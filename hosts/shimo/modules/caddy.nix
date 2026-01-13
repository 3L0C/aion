{
  pkgs,
  config,
  ...
}: {
  sops = {
    secrets."porkbun/api-key" = {};
    secrets."porkbun/secret-key" = {};
    templates."caddy-env" = {
      content = ''
        PORKBUN_API_KEY=${config.sops.placeholder."porkbun/api-key"}
        PORKBUN_SECRET_KEY=${config.sops.placeholder."porkbun/secret-key"}
      '';
    };
  };

  services.caddy = {
    enable = true;
    package = pkgs.caddy.withPlugins {
      plugins = ["github.com/caddy-dns/porkbun@v0.2.1"];
      hash = "sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA="; # Will fail, use hash from error
    };
    globalConfig = ''
      acme_dns porkbun {
        api_key {env.PORKBUN_API_KEY}
        api_secret_key {env.PORKBUN_SECRET_KEY}
      }
    '';

    virtualHosts = {
      "jellyfin.colebruns.com".extraConfig = ''
        reverse_proxy localhost:8096
      '';
      "sonarr.colebruns.com".extraConfig = ''
        reverse_proxy localhost:8989
      '';
      "radarr.colebruns.com".extraConfig = ''
        reverse_proxy localhost:7878
      '';
      "lidarr.colebruns.com".extraConfig = ''
        reverse_proxy localhost:8686
      '';
      "prowlarr.colebruns.com".extraConfig = ''
        reverse_proxy localhost:9696
      '';
      "bazarr.colebruns.com".extraConfig = ''
        reverse_proxy localhost:6767
      '';
      "jellyseerr.colebruns.com".extraConfig = ''
        reverse_proxy localhost:5055
      '';
      "navidrome.colebruns.com".extraConfig = ''
        reverse_proxy localhost:4533
      '';
      "komga.colebruns.com".extraConfig = ''
        reverse_proxy localhost:25600
      '';
      "audiobookshelf.colebruns.com".extraConfig = ''
        reverse_proxy localhost:13378
      '';
    };
  };
  systemd.services.caddy.serviceConfig.EnvironmentFile = [
    config.sops.templates."caddy-env".path
  ];

  networking.firewall.allowedTCPPorts = [80 443];
}
