{...}:
{
  services.syncthing = {
    enable = true;
    group = "users";
    user = "user";
    dataDir = "/home/user/sync";
    configDir = "/home/user/.config/syncthing";
  };
}
