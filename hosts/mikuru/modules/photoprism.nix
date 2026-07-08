{config, ...}: {
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
