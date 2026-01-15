# Glance dashboard
{config, ...}: let
  startpage = import ./startpage.nix;
  feeds = import ./feeds.nix;
  videos = import ./videos.nix;
in {
  sops.secrets."adguard/password" = {};

  sops.templates."glance-env" = {
    content = ''
      ADGUARD_PASSWORD=${config.sops.placeholder."adguard/password"}
    '';
  };
  stylix.targets.glance.enable = true;

  services.glance = {
    enable = true;
    environmentFile = config.sops.templates."glance-env".path;

    settings = {
      server = {
        host = "0.0.0.0";
        port = 8080;
      };

      pages = [startpage feeds videos];
    };
  };
}
