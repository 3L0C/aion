# qBittorrent download client confined to AirVPN
{
  config,
  pkgs,
  ...
}: {
  sops.secrets."airvpn/wg-conf" = {};
  vpnNamespaces.airvpn = {
    enable = true;
    wireguardConfigFile = config.sops.secrets."airvpn/wg-conf".path;
    accessibleFrom = ["192.168.1.0/24"];
    portMappings = [
      {
        from = 8081;
        to = 8081;
      }
    ]; # WebUI
    openVPNPorts = [
      {
        port = 38681;
        protocol = "both";
      }
    ]; # AirVPN forwarded port
  };
  services.qbittorrent = {
    enable = true;
    webuiPort = 8081;
    torrentingPort = 38681; # AirVPN forwarded port
    openFirewall = false; # Handled by VPN namespace
    serverConfig = {
      Preferences = {
        "WebUI\\Address" = "*";
        "WebUI\\Port" = 8081;
        "WebUI\\AlternativeUIEnabled" = true;
        "WebUI\\RootFolder" = "${pkgs.vuetorrent}";
        "Downloads\\SavePath" = "/mnt/tank/data/torrents";
        "Downloads\\TempPath" = "/mnt/tank/data/torrents/.incomplete";
      };
    };
  };
  systemd.services.qbittorrent.vpnConfinement = {
    enable = true;
    vpnNamespace = "airvpn";
  };
  systemd.tmpfiles.rules = [
    "d /mnt/tank/data/torrents 0775 qbittorrent media -"
    "d /mnt/tank/data/torrents/.incomplete 0775 qbittorrent media -"
  ];
  users.users.qbittorrent.extraGroups = ["media"];
}
