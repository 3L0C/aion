{
  services.photoprism = {
    enable = true;
    originalsPath = "/mnt/tank/data/media/photos";
    group = "media";
    settings = {
      PHOTOPRISM_ADMIN_USER = "admin";
      PHOTOPRISM_ADMIN_PASSWORD = "password";
    };
  };
}
