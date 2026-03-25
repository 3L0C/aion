# Suwayomi manga download server (Tachiyomi-compatible)
{
  users.users.suwayomi.extraGroups = ["media"];

  services.suwayomi-server = {
    enable = true;
    openFirewall = true;
    group = "media";

    settings.server = {
      ip = "0.0.0.0";
      port = 4567;
      socksProxyEnabled = false;
      socksProxyVersion = 5; # 4 or 5
      socksProxyHost = "";
      socksProxyPort = "";
      socksProxyUsername = "";
      socksProxyPassword = "";
      webUIEnabled = true;
      webUIFlavor = "WebUI"; # "WebUI", "VUI" or "Custom"
      initialOpenInBrowserEnabled = false;
      webUIInterface = "browser"; # "browser" or "electron"
      electronPath = "";
      webUIChannel = "stable"; # "bundled" (the version bundled with the server release), "stable" or "preview" - the webUI version that should be used
      webUIUpdateCheckInterval = 23; # time in hours - 0 to disable auto update - range: 1 <= n < 24 - default 23 hours - how often the server should check for webUI updates
      downloadAsCbz = true;
      downloadsPath = "/mnt/tank/data/media/manga/downloads/mangas";
      autoDownloadNewChapters = true; # if new chapters that have been retrieved should get automatically downloaded
      excludeEntryWithUnreadChapters = false; # ignore automatic chapter downloads of entries with unread chapters
      autoDownloadNewChaptersLimit = 0; # 0 to disable it - how many unread downloaded chapters should be available - if the limit is reached, new chapters won't be downloaded automatically. this limit will also be applied to the auto download of new chapters on an update
      autoDownloadIgnoreReUploads = false; # decides if re-uploads should be ignored during auto download of new chapters
      downloadConversions = {};

      extensionRepos = [
        "https://raw.githubusercontent.com/keiyoushi/extensions/repo/index.min.json"
      ];
      maxSourcesInParallel = 6; # range: 1 <= n <= 20 - default: 6 - sets how many sources can do requests (updates, downloads) in parallel. updates/downloads are grouped by source and all mangas of a source are updated/downloaded synchronously
      excludeUnreadChapters = false;
      excludeNotStarted = false;
      excludeCompleted = true;
      globalUpdateInterval = 12; # time in hours - 0 to disable it - (doesn't have to be full hours e.g. 12.5) - range: 6 <= n < ∞ - default: 12 hours - interval in which the global update will be automatically triggered
      updateMangas = true; # if the mangas should be updated along with the chapter list during a library/category update
      authMode = "none"; # none, basic_auth or simple_login
      authUsername = "";
      authPassword = "";
      debugLogsEnabled = false;
      systemTrayEnabled = false;
      maxLogFiles = 31; # the max number of days to keep files before they get deleted
      maxLogFileSize = "10mb"; # the max size of a log file - possible values: 1 (bytes), 1KB (kilobytes), 1MB (megabytes), 1GB (gigabytes)
      maxLogFolderSize = "100mb"; # the max size of all saved log files - possible values: 1 (bytes), 1KB (kilobytes), 1MB (megabytes), 1GB (gigabytes)
      backupPath = "";
      backupTime = "00:00"; # range: hour: 0-23, minute: 0-59 - default: "00:00" - time of day at which the automated backup should be triggered
      backupInterval = 1; # time in days - 0 to disable it - range: 1 <= n < ∞ - default: 1 day - interval in which the server will automatically create a backup
      backupTTL = 14; # time in days - 0 to disable it - range: 1 <= n < ∞ - default: 14 days - how long backup files will be kept before they will get deleted
      localSourcePath = "/mnt/tank/data/media/manga-local";

      # Cloudflare bypass
      flareSolverrEnabled = true;
      flareSolverrUrl = "https://flaresolverr.colebruns.com";
      flareSolverrTimeout = 60; # time in seconds
      flareSolverrSessionName = "suwayomi";
      flareSolverrSessionTtl = 15; # time in minutes
      flareSolverrAsResponseFallback = false;
      opdsUseBinaryFileSizes = false; # if the file sizes should be displayed in binary (KiB, MiB, GiB) or decimal (KB, MB, GB)
      opdsItemsPerPage = 50; # Range (10 - 5000)
      opdsEnablePageReadProgress = true;
      opdsMarkAsReadOnDownload = false;
      opdsShowOnlyUnreadChapters = false;
      opdsShowOnlyDownloadedChapters = false;
      opdsChapterSortOrder = "DESC"; # "ASC", "DESC"
    };
  };
}
