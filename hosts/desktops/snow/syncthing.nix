{ username, ... }:
{
  services.syncthing = {
    enable = true;
    group = "users";
    user = username;
    dataDir = "/home/${username}/sync";
    configDir = "/home/${username}/.config/syncthing";
  };
}
