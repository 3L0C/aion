# PhotoPrism photo management
{config, ...}: {
  # The sops password seeds the initial database only.
  # PhotoPrism stores the live password in its own database.
  sops.secrets."photoprism/admin-password" = {};

  services.photoprism = {
    enable = true;
    originalsPath = "/mnt/tank/data/media/photos";
    group = "media";
    passwordFile = config.sops.secrets."photoprism/admin-password".path;
    settings = {
      PHOTOPRISM_ADMIN_USER = "admin";
    };
  };
}
