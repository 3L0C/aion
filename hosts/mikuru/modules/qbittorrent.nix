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
      Application = {
        FileLogger = {
          Age = 1;
          AgeType = 1;
          Backup = true;
          DeleteOld = true;
          Enabled = true;
          MaxSizeBytes = 66560;
          Path = "/var/lib/qBittorrent/qBittorrent/logs";
        };
      };

      AutoRun = {
        enabled = false;
        program = "";
      };

      BitTorrent = {
        Session = {
          AddTorrentStopped = false;
          BTProtocol = "TCP";
          DefaultSavePath = "/mnt/tank/data/torrents";
          DisableAutoTMMByDefault = false;
          DisableAutoTMMTriggers = {
            CategorySavePathChanged = false;
            DefaultSavePathChanged = false;
          };
          ExcludedFileNames = "";
          GlobalDLSpeedLimit = 0;
          GlobalMaxInactiveSeedingMinutes = 20160;
          GlobalMaxRatio = 2;
          GlobalMaxSeedingMinutes = 20160;
          IgnoreSlowTorrentsForQueueing = true;
          MaxActiveDownloads = 15;
          MaxActiveTorrents = 30;
          MaxActiveUploads = 25;
          MaxUploadsPerTorrent = 10;
          Port = 38681;
          Preallocation = true;
          QueueingSystemEnabled = true;
          SSL.Port = 52615;
          ShareLimitAction = "Stop";
          SlowTorrentsDownloadRate = 200;
          SlowTorrentsUploadRate = 100;
          TempPath = "/mnt/tank/data/torrents/.incomplete";
        };
      };

      Core = {
        AutoDeleteAddedTorrentFile = "IfAdded";
      };

      LegalNotice = {
        Accepted = true;
      };

      Network = {
        PortForwardingEnabled = false;
        Proxy = {
          HostnameLookupEnabled = false;
          Profiles = {
            BitTorrent = true;
            Misc = true;
            RSS = true;
          };
        };
      };

      Preferences = {
        Connection = {
          PortRangeMin = 6881;
          UPnP = false;
        };
        Downloads = {
          SavePath = "/mnt/tank/data/torrents";
          TempPath = "/mnt/tank/data/torrents/.incomplete";
        };
        General.Locale = "en";
        MailNotification.req_auth = true;
        WebUI = {
          Address = "*";
          AlternativeUIEnabled = true;
          RootFolder = "${pkgs.vuetorrent}/share/vuetorrent";
          AuthSubnetWhitelist = "192.168.1.0/24";
          AuthSubnetWhitelistEnabled = false;
          "Password_PBKDF2" = ''"@ByteArray(yNDAAuHNo2Zn1qqpyx0oqA==:eijfjdysIMFtGZzwXa+vtErsS/mikLmz2K+QYw5W7KXJA7jhP3lIsuppD9sWxdekpUMTI/U1YmINyrm8RiNCYQ==)"'';
          Port = 8081;
          ServerDomains = "*";
        };
      };

      RSS = {
        AutoDownloader = {
          DownloadRepacks = true;
          SmartEpisodeFilter = ''s(\d+)e(\d+), (\d+)x(\d+), "(\d{4}[.\-]\d{1,2}[.\-]\d{1,2})", "(\d{1,2}[.\-]\d{1,2}[.\-]\d{4})"'';
        };
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
