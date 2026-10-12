# Suwayomi manga download server (Tachiyomi-compatible)
{
  flake.modules.nixos.suwayomi = { pkgs, config, ... }: {
    traefikRoutes.suwayomi = {
      port = 4567;
      middlewares = [ "suwayomi-auth" ];
    };

    # Suwayomi has no usable built-in auth. Traefik protects it at the
    # edge; it reads the htpasswd file directly.
    sops.secrets."suwayomi/htpasswd".owner = "traefik";
    services.traefik.dynamicConfigOptions.http.middlewares.suwayomi-auth = {
      basicAuth.usersFile = config.sops.secrets."suwayomi/htpasswd".path;
    };

    users.users.suwayomi.extraGroups = [ "media" ];

    services.suwayomi-server = {
      enable = true;
      group = "media";

      package = pkgs.custom.suwayomi-server;

      settings.server = {
        # Loopback only: Traefik exposes the service with basic auth.
        ip = "127.0.0.1";
        port = 4567;

        socksProxyEnabled = false;
        socksProxyVersion = 5;
        socksProxyHost = "";
        socksProxyPort = "";
        socksProxyUsername = "";
        socksProxyPassword = "";

        webUIEnabled = true;
        webUIFlavor = "WebUI";
        initialOpenInBrowserEnabled = false;
        webUIInterface = "browser";
        electronPath = "";
        webUIChannel = "stable";
        webUIUpdateCheckInterval = 23; # hours

        downloadAsCbz = true;
        downloadsPath = "${config.hostSpec.mediaRoot}/manga/downloads";
        autoDownloadNewChapters = true;
        excludeEntryWithUnreadChapters = false;
        autoDownloadNewChaptersLimit = 0; # 0 disables the limit
        autoDownloadIgnoreReUploads = false;
        downloadConversions = { };

        extensionRepos = [
          "https://raw.githubusercontent.com/keiyoushi/extensions/repo/index.min.json"
        ];

        maxSourcesInParallel = 6;

        excludeUnreadChapters = false;
        excludeNotStarted = false;
        excludeCompleted = true;
        globalUpdateInterval = 12; # hours
        updateMangas = true;

        # Traefik's basicAuth middleware enforces authentication at the edge (see traefik.nix).
        # This config cannot reference secret files, so keep authMode "none" here.
        authMode = "none";
        authUsername = "";
        authPassword = "";

        debugLogsEnabled = false;
        systemTrayEnabled = false;
        maxLogFiles = 31; # days
        maxLogFileSize = "10mb";
        maxLogFolderSize = "100mb";

        backupPath = "";
        backupTime = "00:00";
        backupInterval = 1; # days
        backupTTL = 14; # days

        localSourcePath = "${config.hostSpec.mediaRoot}/manga-local";

        # Cloudflare bypass
        flareSolverrEnabled = true;
        flareSolverrUrl = "https://flaresolverr.${config.hostSpec.domain}";
        flareSolverrTimeout = 60; # seconds
        flareSolverrSessionName = "suwayomi";
        flareSolverrSessionTtl = 15; # minutes
        flareSolverrAsResponseFallback = false;

        opdsUseBinaryFileSizes = false;
        opdsItemsPerPage = 50;
        opdsEnablePageReadProgress = true;
        opdsMarkAsReadOnDownload = false;
        opdsShowOnlyUnreadChapters = false;
        opdsShowOnlyDownloadedChapters = false;
        opdsChapterSortOrder = "DESC";
      };
    };
  };
}
