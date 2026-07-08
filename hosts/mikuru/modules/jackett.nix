{
  services.jackett = {
    enable = true;
  };
  users.users.jackett.extraGroups = ["media"];
}
