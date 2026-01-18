{
  services.syncthing = {
    enable = true;
    group = "users";
    user = "user";
    dataDir = "/home/user/sync";
    configDir = "/home/user/.config/syncthing";
  };
  networking.firewall = {
    allowedTCPPorts = [22000];
    allowedUDPPorts = [22000 21027];
  };
}
