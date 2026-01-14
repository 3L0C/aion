{
  services.jackett = {
    enable = true;
    openFirewall = true;
  };
  users.users.jackett.extraGroups = ["media"];
}
