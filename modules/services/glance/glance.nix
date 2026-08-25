# Glance dashboard
{
  flake.modules.nixos.glance =
    { config, ... }:
    let
      startpage = import ./_startpage.nix;
      feeds = import ./_feeds.nix;
      videos = import ./_videos.nix;
    in
    {
      traefikRoutes.glance.port = 8080;

      # AdGuard password for the DNS stats widget.
      sops.secrets."adguard/password" = { };

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

          pages = [
            startpage
            feeds
            videos
          ];
        };
      };
    };
}
