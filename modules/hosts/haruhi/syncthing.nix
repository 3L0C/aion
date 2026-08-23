{
  flake.modules.nixos."hosts/haruhi" = {
    services.syncthing = {
      enable = true;
      group = "users";
      user = "user";
      dataDir = "/home/user/sync";
      configDir = "/home/user/.config/syncthing";
      guiAddress = "0.0.0.0:8384";
    };
  };
}
