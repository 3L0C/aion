{ config, pkgs, ... }:
{
  networking = {
    hostName = config.hostSpec.name;
    networkmanager.enable = true;
    nameservers = [
      "8.8.8.8"
      "8.8.4.4"
      "1.1.1.1"
    ];
  };

  services.resolved = {
    enable = true;
    domains = [ "~." ];
    fallbackDns = [
      "8.8.8.8"
      "8.8.4.4"
      "1.1.1.1"
    ];
  };

  environment.systemPackages = with pkgs; [ networkmanagerapplet ];
}
