# qBittorrent download client confined to AirVPN
{inputs, ...}: {
  flake.modules.nixos.qbittorrent-server = {
    config,
    lib,
    pkgs,
    ...
  }: {
    imports = [inputs.vpn-confinement.nixosModules.default];

    # qBittorrent listens on the VPN namespace IP, not localhost.
    traefikRoutes.qbittorrent.url = "http://192.168.15.1:8081";

    sops = {
      secrets = {
        "airvpn/wg-conf" = {};

        # WebUI password hash (PBKDF2 "@ByteArray(...)" string). Kept out of the repo
        # and the nix store. Injected into qBittorrent.conf at service start.
        "qbittorrent/webui-password-pbkdf2" = {};
      };
      templates."qbittorrent-webui-password" = {
        owner = "qbittorrent";
        content = ''
          [Preferences]
          WebUI\Password_PBKDF2=${config.sops.placeholder."qbittorrent/webui-password-pbkdf2"}
        '';
      };
    };

    # VPN namespace name is limited to 7 characters.
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
      openFirewall = false; # The VPN namespace opens the ports.
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
            DefaultSavePath = config.hostSpec.torrentsRoot;
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
            TempPath = "${config.hostSpec.torrentsRoot}/.incomplete";
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
            SavePath = config.hostSpec.torrentsRoot;
            TempPath = "${config.hostSpec.torrentsRoot}/.incomplete";
          };
          General.Locale = "en";
          MailNotification.req_auth = true;
          WebUI = {
            Address = "*";
            AlternativeUIEnabled = true;
            RootFolder = "${pkgs.vuetorrent}/share/vuetorrent";
            AuthSubnetWhitelist = "192.168.1.0/24";
            AuthSubnetWhitelistEnabled = false;
            # Password_PBKDF2 comes from sops (see the ExecStartPre below).
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

    systemd.services.qbittorrent = {
      vpnConfinement = {
        enable = true;
        vpnNamespace = "airvpn";
      };
      serviceConfig = {
        # Group-writable umask so *arr services can hardlink downloads.
        UMask = "0002";
        # Append the WebUI password after the module's own ExecStartPre installs
        # the nix-generated qBittorrent.conf. QSettings merges the repeated
        # [Preferences] section, so the appended key takes effect.
        ExecStartPre = lib.mkAfter [
          (pkgs.writeShellScript "qbittorrent-webui-password" ''
            cat ${config.sops.templates."qbittorrent-webui-password".path} \
              >> ${config.services.qbittorrent.profileDir}/qBittorrent/config/qBittorrent.conf
          '')
        ];
      };
    };

    systemd.tmpfiles.rules = [
      "d ${config.hostSpec.torrentsRoot} 0775 qbittorrent media -"
      "d ${config.hostSpec.torrentsRoot}/.incomplete 0775 qbittorrent media -"
    ];

    users.users.qbittorrent.extraGroups = ["media"];
  };
}
