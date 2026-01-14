{config, ...}: let
  user = config.hostSpec.primaryUser;
in {
  services.syncthing = {
    enable = true;
    group = "users";
    inherit user;
    dataDir = "/home/${user}/sync";
    configDir = "/home/${user}/.config/syncthing";
    settings.gui.insecureSkipHostcheck = true;
  };
  networking.firewall = {
    allowedTCPPorts = [22000];
    allowedUDPPorts = [22000 21027];
  };
}
