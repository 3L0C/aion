{
  services.photoprism = {
    enable = true;
    user = "user";
    group = "media";
    originalsPath = "/mnt/tank/data/media/photos";
    settings = {
      PHOTOPRISM_ADMIN_USER = "admin";
      PHOTOPRISM_ADMIN_PASSWORD = "password";
    };
  };
}
